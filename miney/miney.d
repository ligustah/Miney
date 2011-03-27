module miney.miney;

import minid.api;
import minid.bind;

import tango.net.device.Socket;
import tango.io.device.Array;

import tango.io.selector.Selector;
import tango.io.stream.Buffered;
import tango.io.Stdout;
import tango.io.stream.Buffered;

import tango.time.Time;
import tango.time.Clock;

import tango.math.Math;

import Integer = tango.text.convert.Integer;

import tango.core.Thread;
import tango.core.Memory;
import tango.core.Exception;
import tango.core.Variant;

import miney.protocol;
import miney.timer;
import miney.network;
import miney.util;
import bindings.all;

class Miney : ISelectable
{
	private char[]					_host;
	private ushort					_port;
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
	private MDAction[ulong]			_timerData;
	private ulong[ulong]			_timerRefs;	
	private int chunks = 0;
	private long					_download;
	private long					_upload;
	
	private MDVM*					_vm;
	private MDThread*				_mainThread;
	private ulong					_update;
	private MDAction*				_test;
	private ulong					_timerTest;
	
	
	this()
	{
		assert(false, "no no no");
	}
	
	this(char[] host, ushort port, Network n, MDVM* vm)
	{
		this._host = host;
		this._port = port;
		this._network = n;
		this._socket = new Socket();
		this._inBuffer = new Bin(_socket, 4096);
		this._outBuffer = new Bout(_socket, 4096);
		this._input = new MinecraftDataInput(_inBuffer);
		this._output = new MinecraftDataOutput(_outBuffer);
		this._vm = vm;
		this._mainThread = mainThread(vm);
		
		_socket.native.blocking = false;
		n.addBot(this);
		initAPI();
		init();
	}
	
	bool miney_timer(void* data)
	{		
		MDAction mda = cast(MDAction)data;
		
		auto slot = pushRef(_mainThread, mda.mdRef);
		pushNull(_mainThread);
		
		try
		{
			rawCall(_mainThread, slot, 1);
			bool ret = isTrue(_mainThread, -1);
			pop(_mainThread);
			return ret;
		}catch(MDException mde)
		{
			catchException(_mainThread);
			pop(_mainThread);
			
			Stdout.formatln("error calling timer callback: {}", mde);
			Stdout.formatln(getString(_mainThread, getTraceback(_mainThread))).flush;
			pop(_mainThread);
			return true;
		}
		
		return false;
	}
	
	static uint miney_send(MDThread* t)
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
	
	static uint miney_raw(MDThread* t)
	{
		Sendable s = superGet!(Sendable)(t, 1);
		Array a = new Array(64, 64);
		MinecraftDataOutput output = new MinecraftDataOutput(a);
		
		output | s;
		
		pushString(t, cast(char[])a.slice);
		
		return 1;
	}
	
	static uint miney_metadata(MDThread* t)
	{
		MetadataPacket mp = superGet!(MetadataPacket)(t, 1);
			
		Variant[] variants = mp.metadata;
		
		if(!variants.length)
		{
			newArray(t, 0);
			return 1;
		}
		
		foreach(v; variants)
		{
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
		newArrayFromStack(t, variants.length);
		
		return 1;
	}
	
	static uint miney_connect(MDThread* t)
	{
		Miney m = superGet!(Miney)(t, getUpval(t, 0));
		auto numParams = stackSize(t) - 2;
		
		assert(numParams == 2);
		
		char[] host = checkStringParam(t, 1);
		uint port = checkIntParam(t, 2);
		
		m._socket.connect(host, port);
		
		return 0;
	}
	
	static uint miney_distance(MDThread* t)
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
	
	static uint miney_setTimer(MDThread* t)
	{
		Miney m = superGet!(Miney)(t, getUpval(t, 0));
		auto numParams = stackSize(t) - 2;
		
		assert(numParams == 2);
		
		long l = getInt(t, 1);
		ulong r = createRef(t, 2);
		
		pushInt(t, m._timerID);
		
		auto mda = new MDAction(r);
		
		mda.action = Action(TimeSpan.fromMillis(l), &m.miney_timer, cast(void*)mda, true);
		
		m._timerData[m._timerID++] = mda;
		m._network.addAction(mda.action);
		
		return 1;
	}
	
	static uint miney_stopTimer(MDThread* t)
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
			removeRef(t, mda.mdRef);
		}
		else
		{
			throwException(t, "invalid timer id {}", r);
		}
		
		return 0;
	}
	
	private void initAPI()
	{
		MDThread* t = _mainThread;
		
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
		
		lookup(_mainThread, "miney.update");
		_update = createRef(_mainThread, -1);
		pop(_mainThread);
	}
	
	private void init()
	{
		auto slot = lookupCT!("miney.onInit")(_mainThread);
		pushNull(_mainThread);
		rawCall(_mainThread, slot, 0);
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
		auto slot = lookupCT!("miney.onPacket")(_mainThread);
		pushNull(_mainThread);
		superPush!(Receivable)(_mainThread, r);
		rawCall(_mainThread, slot, 0);
	}
	
	public void queue(Sendable s)
	{
		//Stdout("queuing packet").newline;
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
			
			assert(!(info is null), "Unknown packet: " ~ Integer.toString(id, "x#"));
			
			_packet = cast(Receivable)info.create();
		}
		
		if(_inBuffer.readable < _packet.minSize)
			return false;	// not enough data to parse
		try
		{
			_packet.receive(_input);
		}catch(IOException ioe)
		{
			_inBuffer.skip(1 - _inBuffer.position);
			return false;
		}
		
		_download += _inBuffer.position;
		handlePacket(_packet);
		_packet = null;
		_inBuffer.compress;
		
		return _inBuffer.readable > 0;
	}
	
	private void connected()
	{
		scope(exit) _connected = true;
		int slot;
		
		try
		{
			slot = lookupCT!("miney.onConnect")(_mainThread);
		}catch(MDException mde)
		{
			//no onConnect available
			Stdout("No onConnect handler").newline;
			return;
		}
		
		pushNull(_mainThread);
		pushString(_mainThread, _host);
		pushInt(_mainThread, _port);
		
		try
		{
			rawCall(_mainThread, slot, 0);
		}catch(MDException mde)
		{
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
		}catch(MDException mde)
		{
			//no onDisconnect available
			Stdout("No onDisconnect handler").newline;
			return;
		}
		
		pushNull(_mainThread);
		
		try
		{
			rawCall(_mainThread, slot, 0);
		}catch(MDException mde)
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
		
		//add other update routines here
		if(now - _lastKeepAlive >= TimeSpan.fromSeconds(30))
		{
			queue(new KeepAlive());
			_lastKeepAlive = now;
			gc(_mainThread);
			GC.collect();
			//GC.minimize();
			//Stdout.formatln("bytes allocated: {} stack size: {}", bytesAllocated(_vm), stackSize(_mainThread));
		}
		
		if(now - _lastUpdate >= TimeSpan.fromMillis(50))
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
}

void main()
{
	MDVM vm;
	
	auto t = openVM(&vm);
	
	loadStdlibs(t, MDStdlib.All);
	initMineyVM(&vm);
	WrapGlobals!(
		WrapType!(
			Miney,
			"_miney_",
			WrapMethod!(Miney.queue)
		)
	)(t);
	
	//importModule(t, "miney");
	char[] path = getString(t, lookupCT!("modules.path")(t));
	pop(t);
	path ~= ";scripts";
	
	pushGlobal(t, "modules");
	pushString(t, path);
	fielda(t, -2, "path");
	pop(t);
	
	importModuleNoNS(t, "miney");
	//newGlobal(t, "miney");
	
	Network n = new Network();
	Miney m = new Miney("localhost", 25565, n, &vm);
	
	n.run();
}