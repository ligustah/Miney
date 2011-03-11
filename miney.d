module miney;

import minid.api;
import minid.bind;

import tango.net.device.Socket;

import tango.io.selector.Selector;
import tango.io.stream.Buffered;
import tango.io.Stdout;
import tango.io.stream.Buffered;

import tango.time.Time;
import tango.time.Clock;

import Integer = tango.text.convert.Integer;

import tango.core.Thread;
import tango.core.Exception;

import protocol;
import network;
import util;
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
	private int chunks = 0;
	
	private MDVM*					_vm;
	private MDThread*				_mainThread;
	
	this(char[] host, ushort port, Network n, MDVM* vm)
	{
		this._host = host;
		this._port = port;
		this._network = n;
		this._socket = new Socket();
		this._inBuffer = new Bin(_socket, 4096);
		this._outBuffer = new Bout(_socket, 1024);
		this._input = new MinecraftDataInput(_inBuffer);
		this._output = new MinecraftDataOutput(_outBuffer);
		this._vm = vm;
		this._mainThread = mainThread(vm);
		
		_socket.native.blocking = false;
		_socket.connect(_host, _port);
		n.addBot(this);
	}
	
	Handle fileHandle()
	{
		return _socket.fileHandle;
	}
	
	public void handleRead()
	{
		//Network will guarantee data to be available here
		if(_inBuffer.populate() != _inBuffer.Eof)
		{
				while(parse()){}
		}
		else
		{
			_network.removeBot(this);
		}
	}
	
	public void handleWrite()
	{
		_outBuffer.drain(_socket);
		updateWrite();
	}
	
	public void test()
	{
		auto h = new Handshake("Ligustah");
		queue(h);
	}
	
	private void handlePacket(Receivable r)
	{
		switch(r.packetID)
		{
			case PacketID.Handshake:
				Login l = new Login("Ligustah", "Password");
				queue(l);
				break;
			default:
				break;
		}
		
		auto slot = lookupCT!("miney.onPacket")(_mainThread);
		pushNull(_mainThread);
		superPush!(Receivable)(_mainThread, r);
		rawCall(_mainThread, slot, 0);
	}
	
	public void queue(Sendable s)
	{
		_output | s;
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
			_inBuffer.skip(1-_inBuffer.position);
			return false;
		}
		
		handlePacket(_packet);
		_packet = null;
		_inBuffer.compress;
		
		return _inBuffer.readable > 0;
	}
	
	private void updateWrite()
	{
		if(_outBuffer.limit > 0)
		{
			_network.registerBot(this, Event.Read | Event.Write);
		}
		else
		{
			_network.registerBot(this, Event.Read);
		}
	}
	
	public void update()
	{
		//add other update routines here
		if(Clock.now - _lastKeepAlive >= TimeSpan.fromSeconds(30))
		{
			queue(new KeepAlive());
			_lastKeepAlive = Clock.now;
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
	
	importModule(t, "miney");
	//newGlobal(t, "miney");
	
	Network n = new Network();
	Miney m = new Miney("localhost", 25565, n, &vm);
	
	m.test();
	n.run();
}