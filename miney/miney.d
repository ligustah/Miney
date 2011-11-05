module miney.miney;

version(build)
{
	pragma(link, DD-croc, tango);
}

import croc.api;
import croc.api_debug;
import croc.ex_bind;

import tango.net.device.Socket;
import tango.io.device.Array;

import tango.io.selector.Selector;
import tango.io.stream.Buffered;
import tango.io.Stdout;
import tango.io.stream.Buffered;

import tango.time.Time;
import tango.time.Clock;

import tango.math.Math;

import tango.util.container.LinkedList;

import Integer = tango.text.convert.Integer;

import tango.core.Array;
import tango.core.Memory;
import tango.core.Exception;
import tango.core.Variant;

import miney.protocol;
import miney.timer;
import miney.network;
import miney.util;

import bindings = bindings.all;

debug import tango.core.tools.TraceExceptions;

class Miney : ISelectable
{
	private Socket					_socket;
	private Bin						_inBuffer;
	private Bout					_outBuffer;
	private MinecraftDataOutput		_output;
	private MinecraftDataInput		_input;
	private Receivable				_packet;
	private Network					_network;
	private bool					_hasHandshake = false;
	private bool					_socketClosed = false;
	private Time					_lastKeepAlive;
	private Time					_lastUpdate;
	private bool					_connected = false;
	private ulong					_timerID;
	private CrocAction[ulong]		_timerData;
	private ulong[ulong]			_timerRefs;
	private long					_download;
	private long					_upload;
	private LinkedList!(Receivable)	_lastPackets;
	
	private CrocVM					_vm;
	private CrocThread*				_mainThread;
	private ulong					_update;
	
	this()
	{
		assert(false, "no no no");
	}
	
	this(Network n)
	{
		this._lastPackets = new LinkedList!(Receivable)();
		this._network = n;
		this._socket = new Socket();
		this._inBuffer = new Bin(_socket, 1024 * 10);
		this._outBuffer = new Bout(_socket, 1024 * 4);
		this._input = new MinecraftDataInput(_inBuffer);
		this._output = new MinecraftDataOutput(_outBuffer);
		
		this._mainThread = openVM(&_vm);
		
		_socket.native.blocking = false;
		n.addBot(this);
		initAPI();
		init();
	}
	
	/**
		callback function which is internally used by the timer functions
	*/
	private bool miney_timer(void* data)
	{		
		CrocAction mda = cast(CrocAction)data;
		
		auto slot = pushRef(_mainThread, mda.crocRef);
		pushNull(_mainThread);
		
		try
		{
			rawCall(_mainThread, slot, 1);
			bool ret = isTrue(_mainThread, -1);
			pop(_mainThread);
			return ret;
		}catch(CrocException mde)
		{
			catchException(_mainThread);
			methodCall(_mainThread, -1, "tracebackString", 0);
			
			Stdout.formatln("error calling timer callback: {}", mde);
			Stdout.formatln(getString(_mainThread, -1)).flush;
			pop(_mainThread, 2);
			return true;
		}
		
		return false;
	}
	
	/**
		Queue one or more packets to be sent to the server we are connected to at the moment.
		
		FIXME: Should probably throw an error if there is no open connection.
	*/
	static uint miney_send(CrocThread* t)
	{
		Miney m = superGet!(Miney)(t, getUpval(t, 0));
		auto numParams = stackSize(t) - 1;
		
		for(int i = 1; i < numParams; i++)
		{
			Sendable s = superGet!(Sendable)(t, i);
			if(s is null)
				continue;
			m.queue(s);
		}
		
		return 0;
	}
	
	/**
		This is a somewhat hacky function that will write a packet into a string.
		(I used this to test a packet injection vulnerability in Mineserver)
	*/
	static uint miney_raw(CrocThread* t)
	{
		Sendable s = superGet!(Sendable)(t, 1);
		Array a = new Array(64, 64);
		MinecraftDataOutput output = new MinecraftDataOutput(a);
		
		output | s;
		
		pushString(t, cast(char[])a.slice);
		
		return 1;
	}
	
	/**
		retrieve metadata from a metadata packet (e.g. MobSpawn).
		This will return an array.
		
		FIXME: Shouldn't this be a table?!
	*/
	static uint miney_metadata(CrocThread* t)
	{
		MetadataPacket mp = superGet!(MetadataPacket)(t, 1);
			
		Metadata[] meta = mp.metadata;
		
		if(!meta.length)
		{
			newArray(t, 0);
			return 1;
		}
		
		foreach(m; meta)
		{
			Variant v = m.value;
			if(v.isImplicitly!(int))
				pushInt(t, v.get!(int));
			else if(v.isA!(float))
				pushFloat(t, v.get!(float));
			else if(v.isA!(char[]))
				pushString(t, v.get!(char[]));
			else if(v.isA!(Variant[]))
			{
				Variant[] vars = v.get!(Variant[]);
				
				assert(vars.length == 3, "metadata must be a triple");
				
				foreach(var; vars)
					pushInt(t, var.get!(int));
				
				newArrayFromStack(t, 3);
			}
			else
				assert(0, "invalid metadata");
		}
		newArrayFromStack(t, meta.length);
		
		return 1;
	}
	
	/**
		Extract data from a MapChunk packet. Use this function instead
		of the .data property, because that one will return a "byte" array
		and croc only knows longs.
	*/
	static uint miney_data(CrocThread* t)
	{
		MapChunk m = superGet!(MapChunk)(t, 1);
		
		memblockFromDArray(t, m.data);
		
		return 1;
	}
	
	/**
		connect to the specified host:port
		FIXME: should probably throw an error if there is a connection already
	*/
	static uint miney_connect(CrocThread* t)
	{
		Miney m = superGet!(Miney)(t, getUpval(t, 0));
		auto numParams = stackSize(t) - 2;
		
		char[] host = checkStringParam(t, 1);
		uint port = checkIntParam(t, 2);
		
		m._socket.connect(host, port);
		
		//pretend we want to write to see when the connection is established
		m._network.registerBot(m, Event.Read | Event.Write);
		
		return 0;
	}
	
	/**
		Returns the distance between two objects. Both are expected to
		contain the fields x, y and z.
	*/
	static uint miney_distance(CrocThread* t)
	{
		double x1, y1, z1, x2, y2, z2;
		
		auto numParams = stackSize(t) - 1;
		assert(numParams == 2);
		
		x1 = getFloat(t, field(t, 1, "x"));
		y1 = getFloat(t, field(t, 1, "y"));
		z1 = getFloat(t, field(t, 1, "z"));
		x2 = getFloat(t, field(t, 2, "x"));
		y2 = getFloat(t, field(t, 2, "y"));
		z2 = getFloat(t, field(t, 2, "z"));
		
		double a = x1 - x2;
		double b = y1 - y2;
		double c = z1 - z2;
		
		pushFloat(t, sqrt(a * a + b * b + c * c));
		
		return 1;
	}
	
	/**
		adds a timer and returns its ID
	*/
	static uint miney_setTimer(CrocThread* t)
	{
		Miney m = superGet!(Miney)(t, getUpval(t, 0));
		auto numParams = stackSize(t) - 2;
		
		assert(numParams == 2);
		
		long l = getInt(t, 1);
		ulong r = createRef(t, 2);
		
		pushInt(t, m._timerID);
		
		auto mda = new CrocAction(r);
		
		mda.action = Action(TimeSpan.fromMillis(l), &m.miney_timer, cast(void*)mda, true);
		
		m._timerData[m._timerID++] = mda;		//store our action and increment the ID counter
		m._network.addAction(mda.action);
		
		return 1;
	}
	
	/**
		stops a timer given the ID
	*/
	static uint miney_stopTimer(CrocThread* t)
	{
		Miney m = superGet!(Miney)(t, getUpval(t, 0));
		auto numParams = stackSize(t) - 2;
		
		assert(numParams == 1);
		
		ulong r = getInt(t, 1);
		auto p = r in m._timerData;
		
		if(p)
		{
			Stdout.formatln("removing timer: {}", r);
			auto mda = *p;
			
			m._network.removeAction(mda.action);
			m._timerData.remove(r);
			removeRef(t, mda.crocRef);
		}
		else
		{
			throwStdException(t, "ApiError", "invalid timer id {}", r);
		}
		
		return 0;
	}
	
	private void initAPI()
	{
		Stdout("init API").newline;
		CrocThread* t = _mainThread;
		
		loadStdlibs(t, CrocStdlib.All);
		bindings.init(t);
		
		//TODO: find out why I am doing this?
		WrapGlobals!(
			WrapType!(
				Miney,
				"_miney_",
				WrapMethod!(Miney.queue)
			)
		)(t);
		
		//add an array containing the names of all receivables.
		//used by signal.croc
		foreach(k; PacketHandlers.values)
		{
			char[] name = k.name;
			pushString(t, name[name.rfind('.')+1..$]);
		}
		newArrayFromStack(t, PacketHandlers.length);
		newGlobal(t, "receivables");
		
		pushGlobal(t, "modules");
		field(t, -1, "path");
		pushChar(t, ';');
		pushString(t, "scripts");
		cateq(t, -3, 2);
		fielda(t, -2, "path");
		pop(t);
		
		superPush!(Miney)(t, this);
		newFunction(t, &miney_send, "send", 1);
		newGlobal(t, "send");
		
		newFunction(t, &miney_raw, "raw", 0);
		newGlobal(t, "raw");
		
		superPush!(Miney)(t, this);
		newFunction(t, &miney_setTimer, "setTimer", 1);
		newGlobal(t, "setTimer");
		
		superPush!(Miney)(t, this);
		newFunction(t, &miney_stopTimer, "stopTimer", 1);
		newGlobal(t, "stopTimer");
		
		superPush!(Miney)(t, this);
		newFunction(t, &miney_connect, "connect", 1);
		newGlobal(t, "connect");
		
		newFunction(t, &miney_distance, "distance", 0);
		newGlobal(t, "distance");
		
		newFunction(t, &miney_metadata, "metadata", 0);
		newGlobal(t, "metadata");
		
		newFunction(t, &miney_data, "data", 0);
		newGlobal(t, "data");
		
		Stdout("end init API").newline;
	}
	
	private void init()
	{
		Stdout("init").newline;
		importModuleNoNS(_mainThread, "miney");
		
		//store the update function for later use
		lookup(_mainThread, "miney.update");
		_update = createRef(_mainThread, -1);
		pop(_mainThread);
		
		//tell Miney that we are ready to start
		auto slot = lookupCT!("miney.onInit")(_mainThread);
		pushNull(_mainThread);
		rawCall(_mainThread, slot, 0);
		Stdout("end init").newline;
	}
	
	Handle fileHandle()
	{
		return _socket.fileHandle;
	}
	
	public void handleRead()
	{
		//Network will guarantee data to be available here
		size_t read = _inBuffer.populate();
		if(read != _inBuffer.Eof)
		{
			while(parse()){}
		}
		else
		{
			_network.removeBot(this);
			disconnected();
		}
	}
	
	public void handleWrite()
	{
		long before = _outBuffer.limit();
		if(!_connected)
		{
			connected();
		}
		try
		{
			_outBuffer.flush();
		}catch(Exception ioe)
		{
			Stdout.formatln("exception: {}", ioe);
			//need to wait for next turn
		}
		_upload += before - _outBuffer.limit();
		updateWrite();
	}
	
	private void handlePacket(Receivable r)
	{
		//Stdout.formatln("receiving {}", packetID2Name(r.packetID));
		auto slot = lookupCT!("miney.onPacket")(_mainThread);
		pushNull(_mainThread);
		superPush!(Receivable)(_mainThread, r);
		rawCall(_mainThread, slot, 0);
	}
	
	public void queue(Sendable s)
	{
		//Stdout.formatln("sending {:X#}", s.packetID);
		try
		{
			_output | s;
		}catch(Exception e)
		{
			Stdout.formatln("exception in queue: {} {}", e, _outBuffer.limit);
		}
	}
	
	private bool parse()
	{
		if(_packet is null)
		{
			ubyte id = _input.getByte();			
			auto info = getHandler(id);
			
			if(info is null)
			{
				Stdout.formatln("Unknown packet: {:X#}", id);
				Stdout("Last 10 packets:").newline;
				
				foreach(p; _lastPackets)
				{
					Stdout.formatln("{:X#} {}", p.packetID, packetID2Name(p.packetID));
				}
				assert(false);
			}
			
			_packet = cast(Receivable)info.create();
		}
		
		if(_inBuffer.readable < _packet.minSize)
			return false;	// not enough data to parse
		try
		{
			//Stdout.formatln("receiving {}", packetID2Name(_packet.packetID));
			_packet.receive(_input);
		}catch(IOException ioe)
		{
			//Stdout.formatln("exception while parsing({}): {}", _inBuffer.limit, ioe);
			_inBuffer.skip(1 - _inBuffer.position);
			return false;
		}
		
		_download += _inBuffer.position;
		handlePacket(_packet);
		storePacket(_packet);
		_packet = null;
		_inBuffer.compress;
		
		return _inBuffer.readable > 0;
	}
	
	private void connected()
	{
		scope(exit) _connected = true;
		_lastKeepAlive = Clock.now();
		int slot;
		
		try
		{
			slot = lookupCT!("miney.onConnect")(_mainThread);
		}catch(CrocException mde)
		{
			//no onConnect available
			Stdout("No onConnect handler").newline;
			return;
		}
		
		pushNull(_mainThread);
		
		try
		{
			rawCall(_mainThread, slot, 0);
		}catch(CrocException mde)
		{
			//pop(_mainThread);
			catchException(_mainThread);
			pop(_mainThread);
			Stdout.formatln("Error calling onConnect: {}", mde);
		}
	}
	
	private void disconnected()
	{
		scope(exit) _connected = false;
		int slot;
		
		try
		{
			slot = lookupCT!("miney.onDisconnect")(_mainThread);
		}catch(CrocException mde)
		{
			//no onDisconnect available
			Stdout("No onDisconnect handler").newline;
			return;
		}
		
		pushNull(_mainThread);
		
		try
		{
			rawCall(_mainThread, slot, 0);
		}catch(CrocException mde)
		{
			pop(_mainThread);
			Stdout.formatln("Error calling onDisconnect: {}", mde);
		}
	}
	
	private void updateWrite()
	{
		if(_outBuffer.limit > 0)
		{
			//Stdout("want write").newline;
			_network.registerBot(this, Event.Read | Event.Write);
		}
		else
		{
			//Stdout("nothing to send").newline;
			_network.registerBot(this, Event.Read);
		}
	}
	
	public void update()
	{
		Time now = Clock.now;
		
		//TODO add other update routines here?
		if(_connected && now - _lastKeepAlive >= TimeSpan.fromSeconds(30))
		{
			queue(new KeepAlive());	//should this be moved to script code?
			_lastKeepAlive = now;
			Stdout("running GC").newline;
			
			gc(_mainThread);
			GC.collect();
			GC.minimize();
			Stdout.formatln("bytes allocated: {} stack size: {}", bytesAllocated(&_vm), stackSize(_mainThread));
			//printStack(_mainThread);
		}
		
		//TODO i don't think this needs to be called this often, since i added timers
		if(now - _lastUpdate >= TimeSpan.fromMillis(200))
		{
			auto slot = pushRef(_mainThread, _update);
			pushNull(_mainThread);
			pushInt(_mainThread, _download);
			pushInt(_mainThread, _upload);
			rawCall(_mainThread, slot, 0);
			_lastUpdate = now;
			_download = 0;
			_upload = 0;
		}

		updateWrite();
	}
	
	/**
		stores the last 10 packets for debugging purposes
		@see parse()
	*/
	private void storePacket(Receivable r)
	{
		_lastPackets.append(r);
		
		if(_lastPackets.size > 10)
		{
			_lastPackets.removeHead();
		}
	}
}

void main()
{
	CrocVM vm;
	
	auto t = openVM(&vm);
		
	Network n = new Network();
	Miney m = new Miney(n);
	
	n.run();
}