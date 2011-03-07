module protocol;

import tango.io.stream.Data;
import tango.io.device.Conduit;

import tango.core.Traits;

import tango.io.Stdout;

static const int ProtocolVersion = 9;

static char[] moduleName = __FILE__;

static ClassInfo[PacketID] PacketHandlers;

static this()
{
	moduleName = moduleName[0..$-2];
	foreach(mod; ModuleInfo)
	{
		if(mod.name == moduleName)
		{
			findHandlers(mod);
		}
	}
}

static void findHandlers(ModuleInfo mod)
{
	foreach(cl; mod.localClasses)
	{
		if(implements(cl, Receivable.classinfo))
			addHandler(cl);
	}
}

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
	if(!implements(ci, Receivable.classinfo))
		return;
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

template _getter(char[] name)
{
	const char[] _getter = "public typeof(_" ~ name ~ ") " ~ name ~ "(){ return _" ~ name ~ ";}";
}

template _minSize(size_t i)
{
	const char[] _minSize = "public size_t minSize(){ return " ~ ctfe_i2a(i) ~ "; }";
}

template _packetID(char[] id)
{
	const char[] _packetID = "public PacketID packetID(){ return PacketID." ~ id ~ "; }";
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
	
	public typeof(this) put(long l)
	{
		putLong(l);
		
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
	
	public typeof(this) get(out long l)
	{
		l = getLong();
		
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
	mixin(_packetID!("KeepAlive"));
	mixin(_minSize!(1));
	
	public int receive(MinecraftDataInput input)
	{
		return minSize;
	}
	
	public void send(MinecraftDataOutput output)
	{
		output
		|packetID;
	}
	
	public this()
	{
	}
}

class Login : Sendable, Receivable
{
	mixin(_packetID!("Login"));
	mixin(_minSize!(18));
	
	union
	{
		private int _protocolVersion;
		private int _entityID;
	}
	private char[] _username;
	private char[] _password;
	private long _mapSeed;
	private byte _dimension;
	
	mixin(_getter!("entityID"));
	mixin(_getter!("username"));
	mixin(_getter!("password"));
	mixin(_getter!("mapSeed"));
	mixin(_getter!("dimension"));
	
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
		input
		|_entityID
		|_username
		|_password
		|_mapSeed
		|_dimension;
		
		return minSize + _username.length + _password.length;
	}
	
	public void send(MinecraftDataOutput output)
	{
		output
		|packetID
		|_protocolVersion
		|_username
		|_password
		|0	//map seed
		|0;	//dimension
	}
}

class Handshake : Sendable, Receivable
{
	mixin(_packetID!("Handshake"));
	mixin(_minSize!(3));
	
	union
	{
		private char[] _username;
		private char[] _connectionHash;
	}
	
	mixin(_getter!("username"));
	mixin(_getter!("connectionHash"));
	
	public static const char[] AUTH_NONE = "-";
	public static const char[] AUTH_PASSWORD = "+";
	
	public this(char[] username)
	{
		this._username = username;
	}
	
	public this()
	{
	}
	
	public void send(MinecraftDataOutput output)
	{
		output
		|packetID
		|_username;
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_connectionHash;
		
		return minSize + _connectionHash.length;
	}
}

class Chat : Sendable, Receivable
{
	mixin(_packetID!("Chat"));
	mixin(_minSize!(3));

	char[] _message;
	
	mixin(_getter!("message"));
	
	public this(char[] message)
	{
		this._message = message;
	}
	
	public this()
	{
		
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_message;
		
		return minSize + _message.length;
	}
	
	public void send(MinecraftDataOutput output)
	{
		output
		|packetID
		|_message;
	}
}

class TimeUpdate : Receivable
{
	mixin(_packetID!("TimeUpdate"));
	mixin(_minSize!(9));

	private long _time;
	
	mixin(_getter!("time"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_time;
		
		return minSize;
	}
}

class SpawnPosition : Receivable
{
	mixin(_minSize!(13));
	mixin(_packetID!("SpawnPosition"));
	
	private int _x, _y, _z;
	
	mixin(_getter!("x"));
	mixin(_getter!("y"));
	mixin(_getter!("z"));
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_x
		|_y
		|_z;
		
		return minSize;
	}
}

class UseEntity : Sendable, Receivable
{
	mixin(_packetID!("UseEntity"));
	mixin(_minSize!(10));
	
	private int _user, _target;
	private bool _leftClick;
	
	mixin(_getter!("user"));
	mixin(_getter!("target"));
	mixin(_getter!("leftClick"));
	
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
		input
		|_user
		|_target
		|_leftClick;
		
		return minSize;
	}
	
	public void send(MinecraftDataOutput output)
	{
		output
		|packetID
		|_user
		|_target
		|_leftClick;
	}
}

class UpdateHealth : Receivable
{	
	mixin(_packetID!("UpdateHealth"));
	mixin(_minSize!(3));
	
	private short _health;
	
	mixin(_getter!("health"));
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_health;
		
		return minSize;
	}
}

class Respawn : Sendable, Receivable
{
	mixin(_minSize!(1));
	mixin(_packetID!("Respawn"));
	
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
	mixin(_packetID!("Player"));

	private bool _onGround;
	
	public this(bool onGround)
	{
		_onGround = onGround;
	}
	
	public void send(MinecraftDataOutput output)
	{
		output
		|packetID
		|_onGround;
	}
}

class PlayerPosition : Sendable
{
	mixin(_packetID!("PlayerPosition"));
	
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
		output
		|packetID
		|_x
		|_y
		|_stance
		|_z
		|_onGround;
	}
}

class PlayerLook : Sendable
{
	mixin(_packetID!("PlayerLook"));
	
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
		output
		|packetID
		|_yaw
		|_pitch
		|_onGround;
	}
}

class PlayerPositionLook : Sendable, Receivable
{
	mixin(_packetID!("PlayerPositionLook"));
	mixin(_minSize!(42));

	private double _x, _y, _z, _stance;
	private float _yaw, _pitch;
	private bool _onGround;
	
	mixin(_getter!("x"));
	mixin(_getter!("y"));
	mixin(_getter!("z"));
	mixin(_getter!("stance"));
	mixin(_getter!("yaw"));
	mixin(_getter!("pitch"));
	mixin(_getter!("onGround"));
	
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
	
	public void send(MinecraftDataOutput output)
	{
		output
		|packetID
		|_x
		|_stance
		|_y
		|_z
		|_yaw
		|_pitch
		|_onGround;
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_x
		|_y
		|_stance
		|_z
		|_yaw
		|_pitch
		|_onGround;
		
		return minSize;
	}
}

class PlayerDigging : Sendable
{
	mixin(_packetID!("PlayerDigging"));

	private byte _status, _face, _z;
	private int _x, _y;
	
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
		output
		|packetID
		|_status
		|_x
		|_y
		|_z
		|_face;
	}
}

class PlayerBlockPlacement : Sendable, Receivable
{
	mixin(_packetID!("PlayerBlockPlacement"));
	mixin(_minSize!(13));
	
	private int _x, _z;
	private byte _y, _direction, _amount;
	private short _block;
	private alias _block _itemID;
	private short _damage;
	
	mixin(_getter!("x"));
	mixin(_getter!("y"));
	mixin(_getter!("z"));
	mixin(_getter!("direction"));
	mixin(_getter!("amount"));
	mixin(_getter!("block"));
	mixin(_getter!("itemID"));
	mixin(_getter!("damage"));
	
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
		input
		|_x
		|_y
		|_z
		|_direction
		|_block;
		
		if(_block >= 0)
		{
			input|_amount|_damage;
		}
		
		return (_block >= 0) ? minSize + 2 : minSize;
	}
	
	public void send(MinecraftDataOutput output)
	{
		output
		|packetID
		|_x
		|_y
		|z
		|direction
		|_block;
		
		if(_block >= 0)
			output|_amount|_damage;
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
		output
		|packetID
		|_slotID;
	}
}

class UseBed : Receivable
{
	mixin(_packetID!("UseBed"));
	mixin(_minSize!(15));
	
	private int _entityID, _x, _z;
	private byte _unknown, _y;
	
	mixin(_getter!("entityID"));
	mixin(_getter!("x"));
	mixin(_getter!("y"));
	mixin(_getter!("z"));
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_entityID
		|_unknown
		|_x
		|_y
		|_z;
		
		return minSize;
	}
}

class Animation : Sendable, Receivable
{
	mixin(_minSize!(6));
	mixin(_packetID!("Animation"));
	
	private int _EID;
	private byte _animate;
	
	mixin(_getter!("animate"));
	mixin(_getter!("EID"));
	
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
		input
		|_EID
		|_animate;
		
		return minSize;
	}
	
	public void send(MinecraftDataOutput output)
	{
		output
		|packetID
		|_EID
		|_animate;
	}
}

class EntityAction : Receivable, Sendable
{
	mixin(_minSize!(6));
	mixin(_packetID!("EntityAction"));
	
	private int _entityID;
	private byte _action;
	
	mixin(_getter!("entityID"));
	mixin(_getter!("action"));
	
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

