module protocol;

import tango.io.stream.Data;
import tango.io.device.Conduit;

import tango.io.Stdout;

static const int ProtocolVersion = 9;

static ClassInfo[PacketID] PacketHandlers;

static bool implements(ClassInfo ci, ClassInfo interfac)
{
	foreach(i; ci.interfaces)
	{
		if(i.classinfo is interfac)
		{
			return true;
		}
	}
	return false;
}

static void addHandler(ClassInfo ci)
{
	scope Receivable o = cast(Receivable)ci.create();
	
	if(o)
	{
		PacketHandlers[o.packetID] = ci;
		Stdout.formatln("adding handler for packet 0x{:x} \"{}\"", o.packetID, ci.name);
	}
}

enum PacketID : ubyte
{
	KeepAlive = 0x00,
	Login = 0x01,
	Handshake = 0x02,
	Chat = 0x03,
	TimeUpdate = 0x04,
	EntityEquipment = 0x05,
	SpawnPosition = 0x06,
	UseEntity = 0x07,
	UpdateHealth = 0x08,
	Respawn = 0x09,
	Player = 0x0A,
	PlayerPosition = 0x0B,
	PlayerLook = 0x0C,
	PlayerPositionLook = 0x0D,
	PlayerDigging = 0x0E,
	PlayerBlockPlacement = 0x0F,
	HoldingChange = 0x10,
	UseBed = 0x11,
	Animation = 0x12,
	EntityAction = 0x13,
	NamedEntitySpawn = 0x14,
	PickupSpawn = 0x15,
	CollectItem = 0x16,
	AddObject = 0x17,
	MobSpawn = 0x18,
	EntityPainting = 0x19,
	Unknown = 0x1B,
	EntityVelocity = 0x1C,
	DestroyEntity = 0x1D,
	Entity = 0x1E,
	EntityRelativeMove = 0x1F,
	EntityLook = 0x20,
	EntityLookRelativeMove = 0x21,
	EntityTeleport = 0x22,
	EntityStatus = 0x26,
	AttachEntity = 0x27,
	EntityMetadata = 0x28,
	PreChunk = 0x32,
	MapChunk = 0x33,
	MultiBlockChange = 0x34,
	BlockChange = 0x35,
	PlayNoteBlock = 0x36,
	Explosion = 0x3C,
	OpenWindow = 0x64,
	CloseWindows = 0x65,
	WindowClick = 0x66,
	SetSlot = 0x67,
	WindowItems = 0x68,
	UpdateProgress = 0x69,
	Transaction = 0x6A,
	UpdateSign = 0x82,
	Disconnect = 0xFF
}

public bool variableLength(PacketID type)
{
	switch(type)
	{
		case PacketID.Login:
		case PacketID.Handshake:
		case PacketID.Chat:
		case PacketID.PlayerBlockPlacement:
		case PacketID.NamedEntitySpawn:
		case PacketID.MobSpawn:
		case PacketID.EntityPainting:
		case PacketID.EntityMetadata:
		case PacketID.MapChunk:
		case PacketID.MultiBlockChange:
		case PacketID.Explosion:
		case PacketID.WindowClick:
		case PacketID.SetSlot:
		case PacketID.WindowItems:
		case PacketID.UpdateSign:
		case PacketID.Disconnect:
			return true;
	}
	
	return false;
}

class MinecraftDataOutput : DataOutput
{
	this(OutputStream outs)
	{
		super(outs);
		endian(Network);
	}
	
	public alias string putString;
	
	public size_t string(char[] str)
	{
		int16(str.length);
		return write(str);
	}
}

class MinecraftDataInput : DataInput
{
	this(InputStream ins)
	{
		super(ins);
		endian(Network);
	}
	
	public alias string getString;
	
	public char[] string()
	{
		short len = int16;
		Stdout.formatln("attempting to read {} chars", len);
		char[] str = new char[len];
		read(cast(void[])str);
		
		return str;
	}
}

interface Sendable
{
	public void send(MinecraftDataOutput);
	public PacketID packetID();
}

interface Receivable
{
	public PacketID packetID();
	public size_t minSize();
	public int receive(MinecraftDataInput);
}

class KeepAlive : Receivable, Sendable
{
	static this()
	{
		addHandler(KeepAlive.classinfo);
	}
	
	public size_t minSize()
	{
		return 1;
	}
	
	public PacketID packetID()
	{
		return PacketID.KeepAlive;
	}
	
	public int receive(MinecraftDataInput input)
	{
		return minSize;
	}
	
	public void send(MinecraftDataOutput output)
	{
		output.putByte(packetID);
	}
	
	public this()
	{
	}
}

class Login : Sendable, Receivable
{
	static this()
	{
		addHandler(Login.classinfo);
	}
	
	union
	{
		private int _protocolVersion;
		private int _entityID;
	}
	private char[] _username;
	private char[] _password;
	private long _mapSeed;
	private byte _dimension;
	
	public size_t minSize()
	{
		return 18;
	}
	
	public PacketID packetID()
	{
		return PacketID.Login;
	}
	
	public this(char[] username, char[] password)
	{
		this._protocolVersion = ProtocolVersion;
		this._username = username;
		this._password = password;
	}
	
	public this()
	{
		
	}
	
	public int receive(MinecraftDataInput input)
	{
		_entityID = input.getInt();
		_username = input.getString();
		_password = input.getString();
		_mapSeed = input.getLong();
		_dimension = input.getByte();
		
		return minSize + _username.length + _password.length;
	}
	
	public void send(MinecraftDataOutput output)
	{
		output.putByte(packetID);
		output.putInt(_protocolVersion);
		output.putString(_username);
		output.putString(_password);
		output.putLong(0);	// map seed
		output.putByte(0);	// dimension
	}
	
	public int entityID()
	{
		return _entityID;
	}
	
	public long mapSeed()
	{
		return _mapSeed;
	}
}

class Handshake : Sendable, Receivable
{
	static this()
	{
		addHandler(Handshake.classinfo);
	}
	
	union
	{
		private char[] _username;
		private char[] _connectionHash;
	}
	
	public static const char[] AUTH_NONE = "-";
	public static const char[] AUTH_PASSWORD = "+";
	
	public size_t minSize()
	{
		return 3;
	}
	
	public PacketID packetID()
	{
		return PacketID.Handshake;
	}
	
	public this(char[] username)
	{
		this._username = username;
	}
	
	public this()
	{
	}
	
	public char[] connectionHash()
	{
		return _connectionHash;
	}
	
	public void send(MinecraftDataOutput output)
	{
		output.putByte(PacketID.Handshake);
		output.putString(_username);
	}
	
	public int receive(MinecraftDataInput input)
	{
		_connectionHash = input.getString();
		
		return minSize + _connectionHash.length;
	}
}

class Chat : Sendable, Receivable
{
	static this()
	{
		addHandler(Chat.classinfo);
	}
	
	char[] _message;
	
	public size_t minSize()
	{
		return 3;
	}
	
	public PacketID packetID()
	{
		return PacketID.Chat;
	}
	
	public this(char[] message)
	{
		this._message = message;
	}
	
	public this()
	{
		
	}
	
	public int receive(MinecraftDataInput input)
	{
		_message = input.getString();
		
		return minSize + _message.length;
	}
	
	public void send(MinecraftDataOutput output)
	{
		output.putByte(packetID);
		output.putString(_message);
	}
	
	public char[] message()
	{
		return _message;
	}
	
	public void message(char[] msg)
	{
		_message = msg;
	}
}

class TimeUpdate : Receivable
{
	static this()
	{
		addHandler(TimeUpdate.classinfo);
	}
	
	private long _time;
	
	public PacketID packetID()
	{
		return PacketID.TimeUpdate;
	}
	
	public size_t minSize()
	{
		return 9;
	}
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		_time = input.getLong();
		
		return minSize;
	}
	
	public long time()
	{
		return _time;
	}
}

class SpawnPosition : Receivable
{
	static this()
	{
		addHandler(SpawnPosition.classinfo);
	}
	
	private int _x, _y, _z;
	
	public size_t minSize()
	{
		return 13;
	}
	
	public PacketID packetID()
	{
		return PacketID.SpawnPosition;
	}
	
	public int receive(MinecraftDataInput input)
	{
		_x = input.getInt();
		_y = input.getInt();
		_z = input.getInt();
		
		return minSize;
	}
}

public class Player : Sendable
{
	static this()
	{
		addHandler(Player.classinfo);
	}
	
	private bool _onGround;
	
	public this(bool onGround)
	{
		_onGround = onGround;
	}
	
	
}