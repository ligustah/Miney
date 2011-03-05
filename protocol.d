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
	else
	{
		assert(false, "invalid handler " ~ ci.name);
	}
}

template getter(char[] name)
{
	static const char[] getter = "public typeof(_" ~ name ~ ") " ~ name ~ "(){ return _" ~ name ~ ";}";
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

enum DiggingStatus : byte
{
	StartedDigging = 0x00,
	Digging = 0x01,
	StoppedDigging = 0x02,
	BlockBroken = 0x03,
	DropItem = 0x04
}

enum Face : byte
{
	BottomY = 0x00,
	TopY = 0x01,
	BottomZ = 0x02,
	TopZ = 0x03,
	BottomX = 0x04,
	TopX = 0x05
	
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
	
	public typeof(this) put(char[] str)
	{
		string(str);
		
		return this;
	}
	
	public typeof(this) put(bool b)
	{
		putBool(b);
		
		return this;
	}
	
	public typeof(this) put(int i)
	{
		putInt(i);
		
		return this;
	}
	
	public typeof(this) put(short s)
	{
		putShort(s);
		
		return this;
	}
	
	public typeof(this) put(float f)
	{
		putFloat(f);
		
		return this;
	}
	
	public typeof(this) put(double d)
	{
		putFloat(d);
		
		return this;
	}
	
	public typeof(this) put(byte b)
	{
		putByte(b);
		
		return this;
	}
	
	public typeof(this) put(PacketID id)
	{
		putByte(id);
		
		return this;
	}
	
	public alias put opOr;
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
	
	public typeof(this) get(out char[] str)
	{
		str = string();
		
		return this;
	}
	
	public typeof(this) get(out bool b)
	{
		b = getBool();
		
		return this;
	}
	
	public typeof(this) get(out int i)
	{
		i = getInt();
		
		return this;
	}
	
	public typeof(this) get(out byte b)
	{
		b = getByte();
		
		return this;
	}
	
	public typeof(this) get(out short s)
	{
		s = getShort();
		
		return this;
	}
	
	public typeof(this) get(out float f)
	{
		f = getFloat();
		
		return this;
	}
	
	public typeof(this) get(out double d)
	{
		d = getDouble();
		
		return this;
	}
	
	public alias get opOr;
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
	
	public int x()
	{
		return _x;
	}
	
	public int y()
	{
		return _y;
	}
	
	public int z()
	{
		return _z;
	}
}

class UseEntity : Sendable, Receivable
{
	static this()
	{
		addHandler(UseEntity.classinfo);
	}
	
	public size_t minSize()
	{
		return 10;
	}
	
	public PacketID packetID()
	{
		return PacketID.UseEntity;
	}
	
	private int _user, _target;
	private bool _leftClick;
	
	public this(int user, int target, bool leftClick)
	{
		this._user = user;
		this._target = target;
		this._leftClick = leftClick;
	}
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		_user = input.getInt();
		_target = input.getInt();
		_leftClick = input.getBool();
		
		return minSize;
	}
	
	public void send(MinecraftDataOutput output)
	{
		output.putByte(packetID);
		output.putInt(_user);
		output.putInt(_target);
		output.putBool(_leftClick);
	}
	
	public int user()
	{
		return _user;
	}
	
	public int target()
	{
		return _target;
	}
	
	public bool leftClick()
	{
		return _leftClick;
	}
}

class UpdateHealth : Receivable
{
	static this()
	{
		addHandler(UpdateHealth.classinfo);
	}
	
	public PacketID packetID()
	{
		return PacketID.UpdateHealth;
	}
	
	public size_t minSize()
	{
		return 3;
	}
	
	private short _health;
	
	public int receive(MinecraftDataInput input)
	{
		_health = input.getShort();
		
		return minSize;
	}
	
	public short health()
	{
		return _health;
	}
}

class Respawn : Sendable, Receivable
{
	static this()
	{
		addHandler(Respawn.classinfo);
	}
	
	public size_t minSize()
	{
		return 1;
	}
	
	public PacketID packetID()
	{
		return PacketID.Respawn;
	}
	
	public int receive(MinecraftDataInput input)
	{
		return minSize;
	}
	
	public void send(MinecraftDataOutput output)
	{
		output.putByte(packetID);
	}
}

class Player : Sendable
{	
	private bool _onGround;
	
	public PacketID packetID()
	{
		return PacketID.Player;
	}
	
	public this(bool onGround)
	{
		_onGround = onGround;
	}
	
	public void send(MinecraftDataOutput output)
	{
		output.putByte(packetID);
		output.putBool(_onGround);
	}
}

class PlayerPosition : Sendable
{	
	public PacketID packetID()
	{
		return PacketID.PlayerPosition;
	}
	
	private double _x, _y, _z, _stance;
	private bool _onGround;
	
	public this(double x, double y, double z, double stance, bool onGround)
	{
		this._x = x;
		this._y = y;
		this._z = z;
		this._x = x;
		this._stance = stance;
		this._onGround = onGround;
	}
	
	public void send(MinecraftDataOutput output)
	{
		output.putByte(packetID);
		output.putFloat(_x);
		output.putFloat(_y);
		output.putFloat(_stance);
		output.putFloat(_z);
		output.putBool(_onGround);
	}
}

class PlayerLook : Sendable
{	
	public PacketID packetID()
	{
		return PacketID.PlayerLook;
	}
	
	private float _yaw, _pitch;
	private bool _onGround;
	
	public this(float yaw, float pitch, bool onGround)
	{
		this._yaw = yaw;
		this._pitch = pitch;
		this._onGround = onGround;
	}
	
	public void send(MinecraftDataOutput output)
	{
		output.putByte(packetID);
		output.putFloat(_yaw);
		output.putFloat(_pitch);
		output.putBool(_onGround);
	}
}

class PlayerPositionLook : Sendable, Receivable
{
	static this()
	{
		addHandler(PlayerPositionLook.classinfo);
	}
	
	private double _x, _y, _z, _stance;
	private float _yaw, _pitch;
	private bool _onGround;
	
	public size_t minSize()
	{
		return 42;
	}
	
	public PacketID packetID()
	{
		return PacketID.PlayerPositionLook;
	}
	
	public this()
	{
	}
	
	public this(double x, double y, double z, double stance, float yaw, float pitch, bool onGround)
	{
		this._x = x;
		this._y = y;
		this._z = z;
		this._stance = stance;
		this._yaw = yaw;
		this._pitch = pitch;
		this._onGround = onGround;
	}
	
	public double x()
	{
		return _x;
	}
	
	public double y()
	{
		return _y;
	}
	
	public double z()
	{
		return _z;
	}
	
	public double stance()
	{
		return _stance;
	}
	
	public float yaw()
	{
		return _yaw;
	}
	
	public float pitch()
	{
		return _pitch;
	}
	
	public bool onGround()
	{
		return _onGround;
	}
	
	public void send(MinecraftDataOutput output)
	{
		output.putByte(packetID);
		output.putFloat(_x);
		output.putFloat(_stance);
		output.putFloat(_y);
		output.putFloat(_z);
		output.putFloat(_yaw);
		output.putFloat(_pitch);
		output.putBool(_onGround);
	}
	
	public int receive(MinecraftDataInput input)
	{
		_x = input.getDouble();
		_y = input.getDouble();
		_stance = input.getDouble();
		_z = input.getDouble();
		_yaw = input.getFloat();
		_pitch = input.getFloat();
		_onGround = input.getBool();
		
		return minSize;
	}
}

class PlayerDigging : Sendable
{
	private byte _status, _face, _z;
	private int _x, _y;
	
	public PacketID packetID()
	{
		return PacketID.PlayerDigging;
	}
	
	public this(byte status, int x, byte y, int z, byte face)
	{
		this._status = status;
		this._x = x;
		this._y = y;
		this._z = z;
		this._face = face;
	}
	
	public void send(MinecraftDataOutput output)
	{
		output.putByte(packetID);
		output.putByte(_status);
		output.putInt(_x);
		output.putByte(_y);
		output.putInt(_z);
		output.putByte(_face);
	}
}

class PlayerBlockPlacement : Sendable, Receivable
{
	static this()
	{
		addHandler(PlayerBlockPlacement.classinfo);
	}
	
	public size_t minSize()
	{
		return 13;
	}
	
	public PacketID packetID()
	{
		return PacketID.PlayerBlockPlacement;
	}
	
	private int _x, _z;
	private byte _y, _direction, _amount;
	private short _block;
	private alias _block _itemID;
	private short _damage;
	
	public this()
	{
	}
	
	public this(int x, byte y, int z, byte direction, short blockOrItem, byte amount = 0, short damage = 0)
	{
		this._x = x;
		this._y = y;
		this._z = z;
		this._direction = direction;
		this._block = blockOrItem;
		this._amount = amount;
		this._damage = damage;
	}
	
	public int receive(MinecraftDataInput input)
	{
		_x = input.getInt();
		_y = input.getByte();
		_z = input.getInt();
		_direction = input.getByte();
		_block = input.getShort();
		if(_block >= 0)
		{
			_amount = input.getByte();
			_damage = input.getShort();
		}
		
		return (_block >= 0) ? minSize + 2 : minSize;
	}
	
	public void send(MinecraftDataOutput output)
	{
		output.putByte(packetID);
		output.putInt(_x);
		output.putByte(_y);
		output.putInt(_z);
		output.putByte(_direction);
		output.putShort(_block);
		if(_block >= 0)
		{
			output.putByte(_amount);
			output.putShort(_damage);
		}
	}
	
	public int x()
	{
		return _x;
	}
	
	public byte y()
	{
		return _y;
	}
	
	public int z()
	{
		return _z;
	}
	
	public byte direction()
	{
		return _direction;
	}
	
	public alias block itemID;
	public byte block()
	{
		return _block;
	}
}

class HoldingChange : Sendable
{
	private short _slotID;
	
	public PacketID packetID()
	{
		return PacketID.HoldingChange;
	}
	
	public this(short slotID)
	{
		_slotID = slotID;
	}
	
	public void send(MinecraftDataOutput output)
	{
		output.putByte(packetID);
		output.putShort(_slotID);
	}
}

class UseBed : Receivable
{
	static this()
	{
		addHandler(UseBed.classinfo);
	}
	
	public PacketID packetID()
	{
		return PacketID.UseBed;
	}
	
	public size_t minSize()
	{
		return 15;
	}
	
	private int _entityID, _x, _z;
	private byte _unknown, _y;
	
	public int receive(MinecraftDataInput input)
	{
		_entityID = input.getInt();
		_unknown = input.getByte();
		_x = input.getInt();
		_y = input.getByte();
		_z = input.getInt();
		
		return minSize;
	}
	
	public int entityID()
	{
		return _entityID;
	}
	
	public int x()
	{
		return _x;
	}
	
	public byte y()
	{
		return _y;
	}
	
	public int z()
	{
		return _z;
	}
}

class Animation : Sendable, Receivable
{
	static this()
	{
		addHandler(Animation.classinfo);
	}
	
	private int _EID;
	private byte _animate;
	
	public size_t minSize()
	{
		return 6;
	}
	
	public PacketID packetID()
	{
		return PacketID.Animation;
	}
	
	public this(int EID, byte animate)
	{
		this._EID = EID;
		this._animate = animate;
	}
	
	public this()
	{
		
	}
	
	public int receive(MinecraftDataInput input)
	{
		_EID = input.getInt();
		_animate = input.getByte();
		
		return minSize;
	}
	
	public void send(MinecraftDataOutput output)
	{
		output
		|packetID
		|_EID
		|_animate;
	}
	
	public int EID()
	{
		return _EID;
	}
	
	public byte animate()
	{
		return _animate;
	}
}

class EntityAction : Receivable, Sendable
{
	static this()
	{
		addHandler(EntityAction.classinfo);
	}
	
	public size_t minSize()
	{
		return 6;
	}
	
	public PacketID packetID()
	{
		return PacketID.EntityAction;
	}
	
	private int _entityID;
	private byte _action;
	
	mixin(getter!("entityID"));
	mixin(getter!("action"));
	
	public this()
	{
	}
	
	public this(int entityID, byte action)
	{
		this._entityID = entityID;
		this._action = action;
	}
	
	public void send(MinecraftDataOutput output)
	{
		output
		|packetID
		|_entityID
		|_action;
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_entityID
		|_action;
		
		return minSize;
	}
}