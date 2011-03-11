module miney;

import minid.api;
import minid.bind;

import tango.net.device.Socket;

import tango.io.selector.Selector;
import tango.io.stream.Buffered;
import tango.io.Stdout;
import tango.io.stream.Buffered;

import Integer = tango.text.convert.Integer;

import tango.core.Thread;

import protocol;
import network;
import util;

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
	private int chunks = 0;
	
	this(char[] host, ushort port, Network n)
	{
		this._host = host;
		this._port = port;
		this._network = n;
		this._socket = new Socket();
		this._inBuffer = new Bin(_socket, 4096);
		this._outBuffer = new Bout(_socket, 1024);
		this._input = new MinecraftDataInput(_inBuffer);
		this._output = new MinecraftDataOutput(_outBuffer);
		
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
		Stdout.formatln("sending {} bytes", _outBuffer.drain(_socket));
		updateWrite();
	}
	
	public void test()
	{
		auto h = new Handshake("Ligustah");
		queue(h);
	}
	
	private void handlePacket(Receivable r)
	{
		Stdout.format("getting {}", packetID2Name(r.packetID));
		switch(r.packetID)
		{
			case PacketID.Login:
				Login l = cast(Login)r;
				Stdout.formatln(": EID: {} MapSeed: {} Dimension: {}", l.EID, l.mapSeed, l.dimension);
				break;
			case PacketID.Handshake:
				Handshake h = cast(Handshake)r;
				Stdout.formatln(": ConnectionHash: {}", h.connectionHash);
				_hasHandshake = true;
				Login l = new Login("Ligustah", "Password");
				queue(l);
				break;
			case PacketID.MapChunk:
				MapChunk m = cast(MapChunk)r;
				Stdout.formatln(": #{} {}", chunks++, m.size);
				break;
			case PacketID.PreChunk:
				PreChunk p = cast(PreChunk)r;
				Stdout.formatln(": {}/{}", p.x, p.y);
				break;
			default:
				Stdout().newline;
				break;
		}
	}
	
	public void queue(Sendable s)
	{
		Stdout.formatln("queuing {}", packetID2Name(s.packetID));
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
		
		_packet.receive(_input);
		
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
		
		
		updateWrite();
	}
}

void main()
{
	Network n = new Network();
	Miney m = new Miney("localhost", 25565, n);
	
	m.test();
	n.run();
	
	
	/*
	MDVM vm;
	
	auto t = openVM(&vm);
	loadStdlibs(t, MDStdlib.All);
	
	runFile(t, "miney.md");
	
	return;
	
	auto s = new Selector();
	s.open;
	
	Socket sock = new Socket();
	sock.connect("Andre-PC", 25565);
	*/
}