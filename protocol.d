module protocol;

import tango.core.Traits;

import tango.io.Stdout;

import network;
import util;


static const int ProtocolVersion = 9;

static char[] moduleName = __FILE__[0..$-2];

static ClassInfo[PacketID] PacketHandlers;

static this()
{
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

static char[] packetID2Name(ubyte id)
{
	return getHandler(id).name;
}

static ClassInfo getHandler(ubyte id)
{
	ClassInfo* info = (cast(PacketID)id) in PacketHandlers;
	
	if(info)
	{
		return *info;
	}
	return null;
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
	CloseWindow = 0x65,
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
	//Digging = 0x01,
	FinishedDigging = 0x02,
	//BlockBroken = 0x03,
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

enum ObjectType : byte
{
	Boat = 0x01,
	Minecart = 0x10,
	StorageCart = 0x11,
	PoweredCart = 0x12,
	TNT = 0x32,
	Arrow = 0x3c,
	SnowBall = 0x3d,
	Egg = 0x3e,
	Sand = 0x46,
	Gravel = 0x47,
	FishingFloat = 0x5a
}

enum MobType : byte
{
	Creeper = 0x32,
	Skeleton = 0x33,
	Spider = 0x34,
	GiantZombie = 0x35,
	Zombie = 0x36,
	Slime = 0x37,
	Ghast = 0x38,
	ZombiePigman = 0x39,
	Pig = 0x5a,
	Sheep = 0x5b,
	Cow = 0x5c,
	Hen = 0x5d,
	Squid = 0x5e
}

enum WoolColor : byte
{
	White = 0x00,
	Orange = 0x01,
	Magenta = 0x02,
	LightBlue = 0x03,
	Yellow = 0x04,
	Lime = 0x05,
	Pink = 0x06,
	Gray = 0x07,
	Silver = 0x08,
	Cyan = 0x09,
	Purple = 0x0a,
	Blue = 0x0b,
	Brown = 0x0c,
	Green = 0x0d,
	Red = 0x0e,
	Black = 0x0f
}

enum InstrumentType : byte
{
	Harp = 0x00,
	DoubleBass = 0x01,
	SnareDrum = 0x02,
	Sticks = 0x03,
	BassDrum = 0x04
}

enum InventoryType : byte
{
	Chest = 0x00,
	Workbench = 0x01,
	Furnace = 0x02,
	Dispenser = 0x03
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
		//nothing to do here
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
		private int _EID;
	}
	private char[] _username;
	private char[] _password;
	private long _mapSeed;
	private byte _dimension;
		
	mixin(_getter!("EID", "username", "password", "mapSeed", "dimension"));
	
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
		|_EID
		|_username
		|_password
		|_mapSeed
		|_dimension;
		
		return minSize + _username.length + _password.length;
	}
	
	public void send(MinecraftDataOutput output)
	{
		output
		|_protocolVersion
		|_username
		|_password;
		
		output.putLong(0);
		output.putByte(0);
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
	
	mixin(_getter!("username", "connectionHash"));
	
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

class EntityEquipment : Receivable
{
	mixin(_minSize!(11));
	mixin(_packetID!("EntityEquipment"));
	
	private int _EID;
	private short _slot, _itemID, _damage;
	
	mixin(_getter!("EID", "slot", "itemID", "damage"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_EID
		|_slot
		|_itemID
		|_damage;
		
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
		// nothing to do here
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

class DropItem : PlayerDigging
{
	this()
	{
		super(DiggingStatus.DropItem, 0, 0, 0, 0);
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
		|_slotID;
	}
}

class UseBed : Receivable
{
	mixin(_packetID!("UseBed"));
	mixin(_minSize!(15));
	
	private int _EID, _x, _z;
	private byte _unknown, _y;
	
	mixin(_getter!("EID"));
	mixin(_getter!("x"));
	mixin(_getter!("y"));
	mixin(_getter!("z"));
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_EID
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
		|_EID
		|_animate;
	}
}

class EntityAction : Receivable, Sendable
{
	mixin(_minSize!(6));
	mixin(_packetID!("EntityAction"));
	
	private int _EID;
	private byte _action;
	
	mixin(_getter!("EID"));
	mixin(_getter!("action"));
	
	public this()
	{
	}
	
	public this(int EID, byte action)
	{
		this._EID = EID;
		this._action = action;
	}
	
	public void send(MinecraftDataOutput output)
	{
		output
		|_EID
		|_action;
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_EID
		|_action;
		
		return minSize;
	}
}

class NamedEntitySpawn : Receivable
{
	mixin(_packetID!("NamedEntitySpawn"));
	mixin(_minSize!(23));
	
	private int _EID, _x, _y, _z;
	private char[] _name;
	private byte _rotation, _pitch;
	private short _currentItem;
	
	mixin(_getter!("EID"));
	mixin(_getter!("x"));
	mixin(_getter!("y"));
	mixin(_getter!("z"));
	mixin(_getter!("name"));
	mixin(_getter!("rotation"));
	mixin(_getter!("pitch"));
	mixin(_getter!("currentItem"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_EID
		|_name
		|_x
		|_y
		|_z
		|_rotation
		|_pitch
		|_currentItem;
		
		return minSize + _name.length;
	}
}

class PickupSpawn : Receivable
{
	mixin(_packetID!("PickupSpawn"));
	mixin(_minSize!(25));
	
	private int _EID, _x, _y, _z;
	private byte _count, _rotation, _pitch, _roll;
	private short _itemID, _damage;
	
	mixin(_getter!("EID"));
	mixin(_getter!("x"));
	mixin(_getter!("y"));
	mixin(_getter!("z"));
	mixin(_getter!("count"));
	mixin(_getter!("rotation"));
	mixin(_getter!("pitch"));
	mixin(_getter!("roll"));
	mixin(_getter!("itemID"));
	mixin(_getter!("damage"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_EID
		|_x
		|_y
		|_z
		|_count
		|_rotation
		|_pitch
		|_roll
		|_itemID
		|_damage;
		
		return minSize;
	}
}

class CollectItem : Receivable
{
	mixin(_packetID!("CollectItem"));
	mixin(_minSize!(9));
	
	private int _collected, _collector;
	
	mixin(_getter!("collected"));
	mixin(_getter!("collector"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_collected
		|_collector;
		
		return minSize;
	}
}

class AddObject : Receivable
{
	mixin(_packetID!("AddObject"));
	mixin(_minSize!(18));
	
	private int _EID, _x, _y, _z;
	private byte _type;
	
	mixin(_getter!("EID"));
	mixin(_getter!("x"));
	mixin(_getter!("y"));
	mixin(_getter!("z"));
	mixin(_getter!("type"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_EID
		|_type
		|_x
		|_y
		|_z;
		
		return minSize;
	}
}


// TODO metadata
class MobSpawn : Receivable
{
	mixin(_packetID!("MobSpawn"));
	mixin(_minSize!(20));
	
	int _EID, _x, _y, _z;
	byte _type, _yaw, _pitch;
	
	mixin(_getter!("EID"));
	mixin(_getter!("x"));
	mixin(_getter!("y"));
	mixin(_getter!("z"));
	mixin(_getter!("type"));
	mixin(_getter!("yaw"));
	mixin(_getter!("pitch"));
	
	public this()
	{
		
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_EID
		|_type
		|_x
		|_y
		|_z
		|_yaw
		|_pitch;
		
		input.metadata();
		
		return minSize;
	}
}

class EntityPainting : Receivable
{
	mixin(_packetID!("EntityPainting"));
	mixin(_minSize!(23));
	
	private int _EID, _x, _y, _z, _type;
	private char[] _title;
	
	mixin(_getter!("EID"));
	mixin(_getter!("x"));
	mixin(_getter!("y"));
	mixin(_getter!("z"));
	mixin(_getter!("type"));
	mixin(_getter!("title"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_EID
		|_title
		|_x
		|_y
		|_z
		|_type;
		
		return minSize;
	}
}

class Unknown : Receivable
{
	mixin(_packetID!("Unknown"));
	mixin(_minSize!(19));

	private float _u1, _u2, _u3, _u4;
	private bool _u5, _u6;
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_u1
		|_u2
		|_u3
		|_u4
		|_u5
		|_u6;
		
		return minSize;
	}
}

class EntityVelocity : Receivable
{
	mixin(_packetID!("EntityVelocity"));
	mixin(_minSize!(11));
	
	private int _EID;
	private short _x, _y, _z;
	
	mixin(_getter!("EID"));
	mixin(_getter!("x"));
	mixin(_getter!("y"));
	mixin(_getter!("z"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_EID
		|_x
		|_y
		|_z;
		
		return minSize;
	}
}

class DestroyEntity : Receivable
{
	mixin(_packetID!("DestroyEntity"));
	mixin(_minSize!(5));
	
	private int _EID;
	
	mixin(_getter!("EID"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_EID;
		
		return minSize;
	}
}

class Entity : Receivable
{
	mixin(_packetID!("Entity"));
	mixin(_minSize!(5));
	
	private int _EID;
	
	mixin(_getter!("EID"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_EID;
		
		return minSize;
	}
}

class EntityRelativeMove : Receivable
{
	mixin(_packetID!("EntityRelativeMove"));
	mixin(_minSize!(8));
	
	private int _EID;
	byte _dX, _dY, _dZ;
	
	mixin(_getter!("EID"));
	mixin(_getter!("dX"));
	mixin(_getter!("dY"));
	mixin(_getter!("dZ"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_EID
		|_dX
		|_dY
		|_dZ;
	
		return minSize;
	}
}

class EntityLook : Receivable
{
	mixin(_packetID!("EntityLook"));
	mixin(_minSize!(7));
	
	private int _EID;
	private byte _yaw, _pitch;
	
	mixin(_getter!("EID"));
	mixin(_getter!("yaw"));
	mixin(_getter!("pitch"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_EID
		|_yaw
		|_pitch;
		
		return minSize;
	}
}

class EntityLookRelativeMove : Receivable
{
	mixin(_packetID!("EntityLookRelativeMove"));
	mixin(_minSize!(10));
	
	private int _EID;
	private byte _dX, _dY, _dZ, _yaw, _pitch;
	
	mixin(_getter!("EID"));
	mixin(_getter!("dX"));
	mixin(_getter!("dY"));
	mixin(_getter!("dZ"));
	mixin(_getter!("yaw"));
	mixin(_getter!("pitch"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_EID
		|_dX
		|_dY
		|_dZ
		|_yaw
		|_pitch;
	
		return minSize;
	}
}

class EntityTeleport : Receivable
{
	mixin(_packetID!("EntityTeleport"));
	mixin(_minSize!(19));
	
	private int _EID, _x, _y, _z;
	private byte _yaw, _pitch;
	
	mixin(_getter!("EID"));
	mixin(_getter!("x"));
	mixin(_getter!("y"));
	mixin(_getter!("z"));
	mixin(_getter!("yaw"));
	mixin(_getter!("pitch"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_EID
		|_x
		|_y
		|_z
		|_yaw
		|_pitch;
	
		return minSize;
	}
}

class EntityStatus : Receivable
{
	mixin(_packetID!("EntityStatus"));
	mixin(_minSize!(6));

	private int _EID;
	private byte _status;
	
	mixin(_getter!("EID"));
	mixin(_getter!("status"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_EID
		|_status;
		
		return minSize;
	}
}

class AttachEntity : Receivable
{
	mixin(_packetID!("AttachEntity"));
	mixin(_minSize!(9));
	
	private int _EID, _vehicle;
	
	mixin(_getter!("EID"));
	mixin(_getter!("vehicle"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_EID
		|_vehicle;
		
		return minSize;
	}
}

class EntityMetadata : Receivable
{
	mixin(_packetID!("EntityMetadata"));
	mixin(_minSize!(5));
	
	private int _EID;
	
	mixin(_getter!("EID"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_EID;
		
		input.metadata();
		
		return minSize;
	}
}

class PreChunk : Receivable
{
	mixin(_packetID!("PreChunk"));
	mixin(_minSize!(10));
	
	private int _x, _y;
	private bool _mode;
	
	mixin(_getter!("x"));
	mixin(_getter!("y"));
	mixin(_getter!("mode"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_x
		|_y
		|_mode;
		
		return minSize;
	}
}


//TODO : maybe compress map chunk data here
class MapChunk : Receivable
{
	mixin(_packetID!("MapChunk"));
	mixin(_minSize!(18));
	
	private int _x, _z, _size;
	private short _y;
	private byte _sizeX, _sizeY, _sizeZ;
	private byte[] _data;
	
	mixin(_getter!("x"));
	mixin(_getter!("y"));
	mixin(_getter!("z"));
	mixin(_getter!("sizeX"));
	mixin(_getter!("sizeY"));
	mixin(_getter!("sizeZ"));
	mixin(_getter!("data", "size"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_x
		|_y
		|_z
		|_sizeX
		|_sizeY
		|_sizeZ
		|_size;
		
		_data = new byte[_size];
		input.read(_data);
		
		return minSize + _size;
	}
}

class MultiBlockChange : Receivable
{
	mixin(_packetID!("MultiBlockChange"));
	mixin(_minSize!(11));
	
	private int _x, _z;
	private short _length;
	private short[] _coordinates;
	private byte[] _types, _metadata;
	
	mixin(_getter!("length"));
	mixin(_getter!("coordinates"));
	mixin(_getter!("types"));
	mixin(_getter!("metadata"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_x
		|_z
		|_length;
		
		_coordinates = new short[_length];
		_types = new byte[_length];
		_metadata = new byte[_length];
		
		input.read(_coordinates);
		input.read(_types);
		input.read(_metadata);
		
		return minSize + (4 * _length); 
	}
}

class BlockChange : Receivable
{
	mixin(_packetID!("BlockChange"));
	mixin(_minSize!(12));
	
	private int _x, _z;
	private byte _y, _type, _metadata;
	
	mixin(_getter!("x"));
	mixin(_getter!("y"));
	mixin(_getter!("z"));
	mixin(_getter!("type"));
	mixin(_getter!("metadata"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_x
		|_y
		|_z
		|_type
		|_metadata;
		
		return minSize;
	}
}

class PlayNoteBlock : Receivable
{
	mixin(_packetID!("PlayNoteBlock"));
	mixin(_minSize!(13));
	
	private int _x, _z;
	private short _y;
	private byte _type, _pitch;
	
	mixin(_getter!("x"));
	mixin(_getter!("y"));
	mixin(_getter!("z"));
	mixin(_getter!("type"));
	mixin(_getter!("pitch"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_x
		|_y
		|_z
		|_type
		|_pitch;
		
		return minSize;
	}
}

class Explosion : Receivable
{
	mixin(_packetID!("Explosion"));
	mixin(_minSize!(33));
	
	struct Record
	{
		byte x, y, z;
	}
		
	private double _x, _y, _z;
	private float _unknown;
	private int _recordCount;
	private Record[] _records;
	
	mixin(_getter!("x"));
	mixin(_getter!("y"));
	mixin(_getter!("z"));
	mixin(_getter!("recordCount"));
	mixin(_getter!("records"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_x
		|_y
		|_z
		|_unknown
		|_recordCount;
		
		_records = new Record[_recordCount];
		
		for(int i = 0; i < _recordCount; i++)
		{
			Record r;
			input|r.x|r.y|r.z;
			
			_records[i] = r;
		}
		
		return minSize + 3 * _recordCount;
	}
}

class OpenWindow : Receivable
{
	mixin(_packetID!("OpenWindow"));
	mixin(_minSize!(6));
	
	private byte _id, _type, _slots;
	private char[] _title;
	
	mixin(_getter!("id"));
	mixin(_getter!("type"));
	mixin(_getter!("slots"));
	mixin(_getter!("title"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_id
		|_type
		|_title
		|_slots;
		
		return minSize + _title.length;
	}
}

class CloseWindow : Receivable, Sendable
{
	mixin(_packetID!("CloseWindow"));
	mixin(_minSize!(2));
	
	private byte _id;
	
	mixin(_getter!("id"));
	
	public this(byte id)
	{
		this._id = id;
	}
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_id;
		
		return minSize;
	}
	
	public void send(MinecraftDataOutput output)
	{
		output
		|_id;
	}
}

class WindowClick : Sendable
{
	mixin(_packetID!("WindowClick"));
	mixin(_minSize!(9));
	
	private byte _id, _rightClick, _count;
	private short _slot, _transactionID, _itemID, _uses;
	
	public this(byte id, short slot, byte rightClick, short transactionID, short itemID, byte count, short uses)
	{
		this._id = id;
		this._slot = slot;
		this._rightClick = rightClick;
		this._transactionID = transactionID;
		this._itemID = itemID;
		this._count = count;
		this._uses = uses;
	}
	
	public void send(MinecraftDataOutput output)
	{
		output
		|_id
		|_slot
		|_rightClick
		|_transactionID
		|_itemID;
		
		if(_itemID != -1)
		{
			output
			|_count
			|_uses;
		}
	}
}

class SetSlot : Receivable
{
	mixin(_packetID!("SetSlot"));
	mixin(_minSize!(6));
	
	private byte _id, _count;
	private short _slot, _itemID, _uses;
	
	mixin(_getter!("id"));
	mixin(_getter!("count"));
	mixin(_getter!("slot"));
	mixin(_getter!("itemID"));
	mixin(_getter!("uses"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_id
		|_slot
		|_itemID;
		
		if(_itemID != -1)
		{
			input
			|_count
			|_uses;
		}
		
		return minSize;
	}
}

class WindowItems : Receivable
{
	mixin(_packetID!("WindowItems"));
	mixin(_minSize!(4));
	
	struct Item
	{
		short id;
		byte count;
		short uses;
	}
	
	private byte _id;
	private short _count;
	private Item[] _items;

	mixin(_getter!("id"));
	mixin(_getter!("count"));
	mixin(_getter!("items"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_id
		|_count;
		
		_items = new Item[_count];
		
		for(int n = 0; n < _count; n++)
		{
			Item i;
			
			input|i.id;
			if(i.id != -1)
			{
				input|i.count|i.uses;
			}
			_items[n] = i;
		}
		
		return minSize;
	}
}

class UpdateProgress : Receivable
{
	mixin(_packetID!("UpdateProgress"));
	mixin(_minSize!(6));
	
	private byte _id;
	private short _bar;
	private short _value;
	
	mixin(_getter!("id"));
	mixin(_getter!("bar"));
	mixin(_getter!("value"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_id
		|_bar
		|_value;
		
		return minSize;
	}
}

class Transaction : Receivable
{
	mixin(_packetID!("Transaction"));
	mixin(_minSize!(5));
	
	private byte _id;
	private short _transactionID;
	private bool _accepted;
	
	mixin(_getter!("id"));
	mixin(_getter!("transactionID"));
	mixin(_getter!("accepted"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_id
		|_transactionID
		|_accepted;
		
		return minSize;
	}
}

class UpdateSign : Receivable
{
	mixin(_packetID!("UpdateSign"));
	mixin(_minSize!(19));
	
	private int _x, _z;
	private short _y;
	private char[] _line1, _line2, _line3, _line4;
	
	mixin(_getter!("x"));
	mixin(_getter!("y"));
	mixin(_getter!("z"));
	mixin(_getter!("line1"));
	mixin(_getter!("line2"));
	mixin(_getter!("line3"));
	mixin(_getter!("line4"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_x
		|_y
		|_z
		|_line1
		|_line2
		|_line3
		|_line4;
		
		return minSize + line1.length + line2.length + line3.length + line4.length;
	}
}

class Disconnect : Receivable, Sendable
{
	mixin(_packetID!("Disconnect"));
	mixin(_minSize!(3));
	
	private char[] _reason;
	
	mixin(_getter!("reason"));
	
	public this()
	{
	}
	
	public this(char[] reason)
	{
		this._reason = reason;
	}
	
	public void send(MinecraftDataOutput output)
	{
		output
		|_reason;
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_reason;
		
		return minSize + _reason.length;
	}
}