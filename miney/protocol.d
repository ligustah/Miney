module miney.protocol;

import tango.core.ByteSwap;

import tango.io.stream.Data;

import Integer = tango.text.convert.Integer;
import UTF = tango.text.convert.Utf;

import tango.core.Traits;
import tango.core.Variant;

import tango.io.Stdout;
import tango.io.compress.ZlibStream;
import tango.io.device.Array;

import miney.util;

interface Sendable
{
	public void send(MinecraftDataOutput);
	public PacketID packetID();
}

interface Receivable
{
	public PacketID packetID();
	
	/**
		the number of bytes this packet contains _excluding_ the packet id
	*/
	public size_t minSize();
	
	public int receive(MinecraftDataInput);
}

interface MetadataPacket
{
	public Metadata[] metadata();
}

class Metadata
{
	private byte _key;
	private Variant _value;
	
	mixin(_getter!("key", "value"));
	
	this(byte key, Variant value)
	{
		this._key = key;
		this._value = value;
	}
}

class MinecraftDataOutput : DataOutput
{
	this(OutputStream outs)
	{
		super(outs);
		endian(Network);
	}
		
	public size_t string8(char[] str)
	{
		int16(str.length);
		return write(str);
	}
	
	public size_t string16(wchar[] str)
	{
		int16(str.length);
		version(LittleEndian) ByteSwap.swap16(str);
		return write(str);
	}
	
	public typeof(this) put(char[] str)
	{
		put(UTF.toString16(str));
		
		return this;
	}
	
	public typeof(this) put(wchar[] str)
	{
		string16(str);
		
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
	
	public typeof(this) put(Sendable s)
	{
		put(s.packetID);
		s.send(this);
		
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

	public char[] string8()
	{
		return UTF.toString(string16());
	}

	public wchar[] string16()
	{
		short len = int16;
		wchar[] str = new wchar[len];
		read(cast(void[])str);
		version(LittleEndian) ByteSwap.swap16(str);
		
		return str;
	}
	
	public typeof(this) get(out char[] str)
	{
		str = string8();
		
		return this;
	}
	
	public typeof(this) get(out wchar[] str)
	{
		str = string16();
		
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
	
	public typeof(this) get(out ubyte b)
	{
		b = cast(ubyte)getByte();
		
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
	
	public Metadata[] metadata()
	{
		Metadata[] vars;
		ubyte x;
		int n = 0;
		byte[] data;
		
		while(true)
		{
			this|x;
			
			data ~= x;
			
			if(x == 0x7F) // end of metadata
				break;
				
			//Stdout.format("{}: ", n++);
				
			byte y = x >> 5;
			byte key = x & 0x1E;
			
			switch(y)
			{
				case 0:
					vars ~= new Metadata(key, Variant(getByte));
					break;
				case 1:
					vars ~= new Metadata(key, Variant(getShort));
					break;
				case 2:
					vars ~= new Metadata(key, Variant(getInt));
					break;
				case 3:
					vars ~= new Metadata(key, Variant(getFloat));
					break;
				case 4:
					vars ~= new Metadata(key, Variant(string8));
					break;
				case 5:
					vars ~= new Metadata(key, Variant([Variant(getShort), Variant(getByte), Variant(getShort)]));
					break;
				case 6:
					vars ~= new Metadata(key, Variant([Variant(getInt), Variant(getInt), Variant(getInt)]));
					break;
				default:
					Stdout.formatln("data: {}", data);
					assert(0, "invalid metadata " ~ Integer.toString(y));
			}
		}
		
		return vars;
	}
}

pragma(lib, "zlib.lib");

static const int ProtocolVersion = 17;

static char[] moduleName = "miney.protocol";

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
	PacketHandlers.rehash;
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
		//Stdout.formatln("adding handler for packet 0x{:x} \"{}\"", o.packetID, ci.name);
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
	ExperienceOrb = 0x1A,
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
	EntityEffect = 0x29,
	RemoveEntityEffect = 0x2A,
	Experience = 0x2B,
	PreChunk = 0x32,
	MapChunk = 0x33,
	MultiBlockChange = 0x34,
	BlockChange = 0x35,
	BlockAction = 0x36,
	Explosion = 0x3C,
	SoundEffect = 0x3D,
	NewState = 0x46,
	Thunderbolt = 0x47,
	OpenWindow = 0x64,
	CloseWindow = 0x65,
	WindowClick = 0x66,
	SetSlot = 0x67,
	WindowItems = 0x68,
	UpdateProgress = 0x69,
	Transaction = 0x6A,
	CreativeInventoryAction = 0x6B,
	UpdateSign = 0x82,
	ItemData = 0x83,
	IncrementStatistic = 0xC8,
	PlayerListItem = 0xC9,
	ServerListPing = 0xFE,
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
	Squid = 0x5e,
	Wolf = 0x5f
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

enum EntityType : byte
{
	Mob = 0x00,
	Object = 0x01,
	Player = 0x02,
	Pickup = 0x03
}

enum EntAction : byte
{
	Crouch = 0x01,
	Uncrouch = 0x02,
	LeaveBed = 0x03,
	StartSprinting = 0x04,
	StopSprinting = 0x05
}

enum ItemType : short
{
	Air = 0x00,
	Stone = 0x01,
	Grass = 0x02,
	Dirt = 0x03,
	Cobblestone = 0x04,
	WoodenPlank = 0x05,
	Sapling = 0x06,
	Bedrock = 0x07,
	Water = 0x08,
	StationaryWater = 0x09,
	Lava = 0x0A,
	StationaryLava = 0x0B,
	Sand = 0x0C,
	Gravel = 0x0D,
	GoldOre = 0x0E,
	IronOre = 0x0F,
	CoalOre = 0x10,
	Wood = 0x11,
	Leaves = 0x12,
	Sponge = 0x13,
	Glass = 0x14,
	LapisLazuliOre = 0x15,
	LapisLazuliBlock = 0x16,
	Dispenser = 0x17,
	Sandstone = 0x18,
	NoteBlock = 0x19,
	Bed_placed = 0x1A,
	PoweredRail = 0x1B,
	DetectorRail = 0x1C,
	StickyPiston = 0x1D,
	Cobweb = 0x1E,
	TallGrass = 0x1F,
	DeadShrub = 0x20,
	Piston = 0x21,
	PistonHead = 0x22,
	Wool = 0x23,
	Block36 = 0x24,
	YellowFlower = 0x25,
	RedRose = 0x26,
	BrownMushroom = 0x27,
	RedMushroom = 0x28,
	GoldBlock = 0x29,
	IronBlock = 0x2A,
	DoubleSlab = 0x2B,
	Slab = 0x2C,
	Brick = 0x2D,
	Tnt = 0x2E,
	Bookshelf = 0x2F,
	MossStone = 0x30,
	Obsidian = 0x31,
	Torch = 0x32,
	Fire = 0x33,
	MonsterSpawner = 0x34,
	WoodenStairs = 0x35,
	Chest = 0x36,
	RedstoneWire_placed = 0x37,
	DiamondOre = 0x38,
	DiamondBlock = 0x39,
	CraftingTable = 0x3A,
	Crops = 0x3B,
	Farmland = 0x3C,
	Furnace = 0x3D,
	BurningFurnace = 0x3E,
	SignPost_placed = 0x3F,
	WoodenDoor_placed = 0x40,
	Ladder = 0x41,
	MinecartTracks = 0x42,
	CobblestoneStairs = 0x43,
	WallSign_placed = 0x44,
	Lever = 0x45,
	StonePressurePlate = 0x46,
	IronDoor_placed = 0x47,
	WoodenPressurePlate = 0x48,
	RedstoneOre = 0x49,
	GlowingRedstoneOre = 0x4A,
	RedstoneTorchOff_placed = 0x4B,
	RedstoneTorchOn = 0x4C,
	StoneButton = 0x4D,
	Snow = 0x4E,
	Ice = 0x4F,
	SnowBlock = 0x50,
	Cactus = 0x51,
	Clay = 0x52,
	SugarCane_placed = 0x53,
	Jukebox = 0x54,
	Fence = 0x55,
	Pumpkin = 0x56,
	Netherrack = 0x57,
	SoulSand = 0x58,
	Glowstone = 0x59,
	Portal = 0x5A,
	JackOLantern = 0x5B,
	Cake_placed = 0x5C,
	RedstoneRepeaterOff_placed = 0x5D,
	RedstoneRepeaterOn_placed = 0x5E,
	LockedChest = 0x5F,
	Trapdoor = 0x60,
	HiddenSilverfish = 0x61,
	StoneBricks = 0x62,
	HugeBrownMushroom = 0x63,
	HugeRedMushroom = 0x64,
	IronBars = 0x65,
	GlassPane = 0x66,
	Melon = 0x67,
	PumpkinStem = 0x68,
	MelonStem = 0x69,
	Vines = 0x6A,
	FenceGate = 0x6B,
	BrickStairs = 0x6C,
	StoneBrickStairs = 0x6D,
	Mycelium = 0x6E,
	LilyPad = 0x6F,
	NetherBrick = 0x70,
	NetherBrickFence = 0x71,
	NetherBrickStairs = 0x72,
	NetherWart_placed = 0x73,
	EnchantmentTable_placed = 0x74,
	BrewingStand_placed = 0x75,
	Cauldron_placed = 0x76,
	EndPortal = 0x77,
	EndPortalFrame = 0x78,
	EndStone = 0x79,
	IronShovel = 0x100,
	IronPickaxe = 0x101,
	IronAxe = 0x102,
	FlintAndSteel = 0x103,
	Apple = 0x104,
	Bow = 0x105,
	Arrow = 0x106,
	Coal = 0x107,
	Diamond = 0x108,
	IronIngot = 0x109,
	GoldIngot = 0x10A,
	IronSword = 0x10B,
	WoodenSword = 0x10C,
	WoodenShovel = 0x10D,
	WoodenPickaxe = 0x10E,
	WoodenAxe = 0x10F,
	StoneSword = 0x110,
	StoneShovel = 0x111,
	StonePickaxe = 0x112,
	StoneAxe = 0x113,
	DiamondSword = 0x114,
	DiamondShovel = 0x115,
	DiamondPickaxe = 0x116,
	DiamondAxe = 0x117,
	Stick = 0x118,
	Bowl = 0x119,
	MushroomStew = 0x11A,
	GoldSword = 0x11B,
	GoldShovel = 0x11C,
	GoldPickaxe = 0x11D,
	GoldAxe = 0x11E,
	String = 0x11F,
	Feather = 0x120,
	Gunpowder = 0x121,
	WoodenHoe = 0x122,
	StoneHoe = 0x123,
	IronHoe = 0x124,
	DiamondHoe = 0x125,
	GoldHoe = 0x126,
	Seeds = 0x127,
	Wheat = 0x128,
	Bread = 0x129,
	LeatherHelmet = 0x12A,
	LeatherChestplate = 0x12B,
	LeatherLeggings = 0x12C,
	LeatherBoots = 0x12D,
	ChainmailHelmet = 0x12E,
	ChainmailChestplate = 0x12F,
	ChainmailLeggings = 0x130,
	ChainmailBoots = 0x131,
	IronHelmet = 0x132,
	IronChestplate = 0x133,
	IronLeggings = 0x134,
	IronBoots = 0x135,
	DiamondHelmet = 0x136,
	DiamondChestplate = 0x137,
	DiamondLeggings = 0x138,
	DiamondBoots = 0x139,
	GoldHelmet = 0x13A,
	GoldChestplate = 0x13B,
	GoldLeggings = 0x13C,
	GoldBoots = 0x13D,
	Flint = 0x13E,
	RawPorkchop = 0x13F,
	CookedPorkchop = 0x140,
	Painting = 0x141,
	GoldenApple = 0x142,
	Sign = 0x143,
	WoodenDoor = 0x144,
	Bucket = 0x145,
	WaterBucket = 0x146,
	LavaBucket = 0x147,
	Minecart = 0x148,
	Saddle = 0x149,
	IronDoor = 0x14A,
	Redstone = 0x14B,
	Snowball = 0x14C,
	Boat = 0x14D,
	Leather = 0x14E,
	MilkBucket = 0x14F,
	ClayBrick = 0x150,
	ClayBall = 0x151,
	SugarCane = 0x152,
	Paper = 0x153,
	Book = 0x154,
	Slimeball = 0x155,
	StorageMinecart = 0x156,
	PoweredMinecart = 0x157,
	Egg = 0x158,
	Compass = 0x159,
	FishingRod = 0x15A,
	Clock = 0x15B,
	GlowstoneDust = 0x15C,
	RawFish = 0x15D,
	CookedFish = 0x15E,
	InkSac = 0x15F,
	Bone = 0x160,
	Sugar = 0x161,
	Cake = 0x162,
	Bed = 0x163,
	RedstoneRepeater = 0x164,
	Cookie = 0x165,
	Map = 0x166,
	Shears = 0x167,
	MelonSlice = 0x168,
	PumpkinSeeds = 0x169,
	MelonSeeds = 0x16A,
	RawBeef = 0x16B,
	Steak = 0x16C,
	RawChicken = 0x16D,
	CookedChicken = 0x16E,
	RottenFlesh = 0x16F,
	EnderPearl = 0x170,
	BlazeRod = 0x171,
	GhastTear = 0x172,
	GoldNugget = 0x173,
	NetherWart = 0x174,
	Potions = 0x175,
	GlassBottle = 0x176,
	SpiderEye = 0x177,
	FermentedSpiderEye = 0x178,
	BlazePowder = 0x179,
	MagmaCream = 0x17A,
	BrewingStand = 0x17B,
	Cauldron = 0x17C,
	EyeOfEnder = 0x17D,
	GlisteringMelon = 0x17E,
	Disc_13 = 0x8D0,
	CatDisc = 0x8D1,
	BlocksDisc = 0x8D2,
	ChirpDisc = 0x8D3,
	FarDisc = 0x8D4,
	MallDisc = 0x8D5,
	MellohiDisc = 0x8D6,
	StalDisc = 0x8D7,
	StradDisc = 0x8D8,
	WardDisc = 0x8D9,
	Disc_11 = 0x8DA,
}

/*
enum AuthCode
{
	None = "-",
	Password = "+"
}
*/
class KeepAlive : Sendable, Receivable
{	
	mixin(_packetID!("KeepAlive"));
	mixin(_minSize!(4));
	
	private int _id;
	
	mixin(_getter!("id"));
	
	public this()
	{
		this(0);
	}
	
	public this(int id)
	{
		this._id = id;
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

class Login : Sendable, Receivable
{
	mixin(_packetID!("Login"));
	mixin(_minSize!(22));
	
	union
	{
		private int _protocolVersion;
		private int _EID;
	}
	private char[] _username;
	private long _mapSeed;
	private int _mode;
	private byte _dimension, _difficulty;
	private ubyte _height, _maxPlayers;
		
	mixin(_getter!("EID", "mapSeed", "dimension", "difficulty", "mode", "height", "maxPlayers"));
	
	public this(char[] username)
	{
		this._protocolVersion = ProtocolVersion;
		this._username = username;
	}
	
	public this()
	{
		
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_EID
		|_username
		|_mapSeed
		|_mode
		|_dimension
		|_difficulty
		|_height
		|_maxPlayers;
		
		return minSize + 2 * _username.length;
	}
	
	public void send(MinecraftDataOutput output)
	{
		output
		|_protocolVersion
		|_username;
		
		output.putLong(0);
		output.putInt(0);
		output.putByte(0);
		output.putByte(0);
		output.putByte(0);
		output.putByte(0);
	}
}

class Handshake : Sendable, Receivable
{
	mixin(_packetID!("Handshake"));
	mixin(_minSize!(2));
	
	union
	{
		private char[] _username;
		private char[] _connectionHash;
	}
	
	mixin(_getter!("username", "connectionHash"));
	
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
		
		return minSize + 2 * _connectionHash.length;
	}
}

class Chat : Sendable, Receivable
{
	mixin(_packetID!("Chat"));
	mixin(_minSize!(2));

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
		
		return minSize + 2 * _message.length;
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
	mixin(_minSize!(8));

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
	mixin(_minSize!(10));
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
	mixin(_minSize!(12));
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
	mixin(_minSize!(9));
	
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
	mixin(_minSize!(8));
	
	private short _health, _food;
	private float _saturation;
	
	mixin(_getter!("health", "food", "saturation"));
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_health
		|_food
		|_saturation;
		
		return minSize;
	}
}

class Respawn : Sendable, Receivable
{
	mixin(_minSize!(13));
	mixin(_packetID!("Respawn"));
	
	private byte  _world, _difficulty, _creative;
	private short _height;
	private long  _seed;
	
	mixin(_getter!("world", "difficulty", "creative", "height", "seed"));
	
	public this()
	{
	}
	
	public this(byte world, byte difficulty, byte creative, short height, long seed)
	{
		this._world = world;
		this._difficulty = difficulty;
		this._creative = creative;
		this._height = height;
		this._seed = seed;
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_world
		|_difficulty
		|_creative
		|_height
		|_seed;
		
		return minSize;
	}
	
	public void send(MinecraftDataOutput output)
	{		
		output
		|_world
		|_difficulty
		|_creative
		|_height
		|_seed;
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
	mixin(_minSize!(41));

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
	mixin(_minSize!(12));
	
	private int _x, _z;
	private byte _y, _direction, _amount;
	private short _block;
	private alias _block _itemID;
	private short _damage;
	
	mixin(_getter!("x", "y", "z", "direction", "amount", "block", "itemID", "damage"));
	
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
	mixin(_packetID!("HoldingChange"));

	private short _slotID;
	
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
	mixin(_minSize!(14));
	
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
	mixin(_minSize!(5));
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

class EntityAction : Sendable, Receivable
{
	mixin(_minSize!(5));
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
	mixin(_minSize!(22));
	
	private int _EID, _x, _y, _z;
	private char[] _name;
	private byte _rotation, _pitch;
	private short _currentItem;
	
	mixin(_getter!("EID", "x", "y", "z", "name", "rotation", "pitch", "currentItem"));
	
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
		
		return minSize + 2 * _name.length;
	}
}

class PickupSpawn : Receivable
{
	mixin(_packetID!("PickupSpawn"));
	mixin(_minSize!(24));
	
	private int _EID, _x, _y, _z;
	private byte _count, _rotation, _pitch, _roll;
	private short _itemID, _damage;
	
	mixin(_getter!("EID", "x", "y", "z", "count", "rotation", "pitch", "roll", "itemID", "damage"));
	
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
	mixin(_minSize!(8));
	
	private int _collected, _collector;
	
	mixin(_getter!("collected", "collector"));
	
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
	mixin(_minSize!(21));
	
	private int _EID, _x, _y, _z, _thrower;
	private short _tx, _ty, _tz;
	private byte _type;
	
	mixin(_getter!("EID", "x", "y", "z", "type", "thrower", "tx", "ty", "tz"));
	
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
		|_thrower;
		
		if(_thrower > 0)
		{
			input
			|_tx
			|_ty
			|_tz;
			
			return minSize + 6; // (3 * short = 6 bytes)
		}
		
		return minSize;
	}
}

class MobSpawn : MetadataPacket, Receivable
{
	mixin(_packetID!("MobSpawn"));
	mixin(_minSize!(20));
	
	int _EID, _x, _y, _z;
	byte _type, _yaw, _pitch;
	
	mixin(_getter!("EID", "x", "y", "z", "type", "yaw", "pitch"));
	
	Metadata[] _metadata;
	mixin(_getter!("metadata"));
	
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
		
		_metadata = input.metadata();
		
		return minSize;
	}
}

class EntityPainting : Receivable
{
	mixin(_packetID!("EntityPainting"));
	mixin(_minSize!(22));
	
	private int _EID, _x, _y, _z, _type;
	private char[] _title;
	
	mixin(_getter!("EID", "x", "y", "z", "type", "title"));
	
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

class ExperienceOrb : Receivable
{
	mixin(_packetID!("ExperienceOrb"));
	mixin(_minSize!(18));
	
	private int _EID, _x, _y, _z;
	private short _count;
	
	mixin(_getter!("EID", "x", "y", "z", "count"));
	
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
		|_count;
		
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
	mixin(_minSize!(10));
	
	private int _EID;
	private short _x, _y, _z;
	
	mixin(_getter!("EID", "x", "y", "z"));
	
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
	mixin(_minSize!(4));
	
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
	mixin(_minSize!(4));
	
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
	mixin(_minSize!(7));
	
	private int _EID;
	byte _dX, _dY, _dZ;
	
	mixin(_getter!("EID", "dX", "dY", "dZ"));
	
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
	mixin(_minSize!(6));
	
	private int _EID;
	private byte _yaw, _pitch;
	
	mixin(_getter!("EID", "yaw", "pitch"));
	
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
	mixin(_minSize!(9));
	
	private int _EID;
	private byte _dX, _dY, _dZ, _yaw, _pitch;
	
	mixin(_getter!("EID", "dX", "dY", "dZ", "yaw", "pitch"));
	
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
	mixin(_minSize!(18));
	
	private int _EID, _x, _y, _z;
	private byte _yaw, _pitch;
	
	mixin(_getter!("EID", "x", "y", "z", "yaw", "pitch"));
	
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
	mixin(_minSize!(5));

	private int _EID;
	private byte _status;
	
	mixin(_getter!("EID", "status"));
	
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
	mixin(_minSize!(8));
	
	private int _EID, _vehicle;
	
	mixin(_getter!("EID", "vehicle"));
	
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

class EntityMetadata : MetadataPacket, Receivable
{
	mixin(_packetID!("EntityMetadata"));
	mixin(_minSize!(4));
	
	private int _EID;
	
	mixin(_getter!("EID"));
	
	Metadata[] _metadata;
	mixin(_getter!("metadata"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_EID;
		
		_metadata = input.metadata();
		
		return minSize;
	}
}

class EntityEffect : Receivable
{
	mixin(_packetID!("EntityEffect"));
	mixin(_minSize!(8));
	
	private int _EID;
	private byte _effect, _amplifier;
	private short _duration;
	
	mixin(_getter!("EID", "effect", "amplifier", "duration"));
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_EID
		|_effect
		|_amplifier
		|_duration;
		
		return minSize;
	}
}

class RemoveEntityEffect : Receivable
{
	mixin(_packetID!("RemoveEntityEffect"));
	mixin(_minSize!(5));
	
	private int _EID;
	private byte _effect;
	
	mixin(_getter!("EID", "effect"));
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_EID
		|_effect;
		
		return minSize;
	}
}

class Experience : Receivable
{
	mixin(_packetID!("Experience"));
	mixin(_minSize!(4));
	
	private byte _current, _level;
	private short _total;
	
	mixin(_getter!("current", "level", "total"));
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_current
		|_level
		|_total;
		
		return minSize;
	}
}

class PreChunk : Receivable
{
	mixin(_packetID!("PreChunk"));
	mixin(_minSize!(9));
	
	private int _x, _z;
	private bool _mode;
	
	mixin(_getter!("x", "z", "mode"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_x
		|_z
		|_mode;
		
		return minSize;
	}
}


//TODO : maybe uncompress map chunk data here
class MapChunk : Receivable
{
	mixin(_packetID!("MapChunk"));
	//mixin(_minSize!(18));
	
	public size_t minSize()
	{
		return 18 + _size;
	}
	
	private int _x, _z, _size = 0;
	private short _y;
	private ubyte _sizeX, _sizeY, _sizeZ;
	private byte[] _data;
	
	mixin(_getter!("x", "y", "z", "sizeX", "sizeY", "sizeZ", "data", "size"));
	
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
		
		_sizeX++;
		_sizeY++;
		_sizeZ++;
		
		byte[] compressed = new byte[_size];
		
		input.read(compressed);
		
		scope stream = new Array(compressed);
		
		//Stdout.formatln("mapchunk {}/{}/{} {} * {} * {} compressed: {}", x, y, z, _sizeX, _sizeY, _sizeZ, _size);
				
		_data = new byte[cast(uint)((_sizeX) * (_sizeY) * (_sizeZ) * 2.5)];
		scope zip = new ZlibInput(stream);
		zip.read(_data);
		
		return minSize;
	}
}

class MultiBlockChange : Receivable
{
	mixin(_packetID!("MultiBlockChange"));
	
	public size_t minSize()
	{
		return 10 + (4 * _length);
	}
	
	private int _x, _z;
	private short _length = 0;
	private short[] _coordinates;
	private byte[] _types, _metadata;
	
	mixin(_getter!("length", "coordinates", "types", "metadata"));
	
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
		
		return minSize; 
	}
}

class BlockChange : Receivable
{
	mixin(_packetID!("BlockChange"));
	mixin(_minSize!(11));
	
	private int _x, _z;
	private byte _y, _type, _metadata;
	
	mixin(_getter!("x", "y", "z", "type", "metadata"));
	
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

class BlockAction : Receivable
{
	mixin(_packetID!("BlockAction"));
	mixin(_minSize!(12));
	
	private int _x, _z;
	private short _y;
	private byte _arg1, _arg2;
	
	mixin(_getter!("x", "y", "z", "arg1", "arg2"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_x
		|_y
		|_z
		|_arg1
		|_arg2;
		
		return minSize;
	}
}
struct Record
{
	byte x, y, z;
}
	
class Explosion : Receivable
{
	mixin(_packetID!("Explosion"));
	
	public size_t minSize()
	{
		return 32 + (3 * _recordCount);
	}
	
	private double _x, _y, _z;
	private float _unknown;
	private int _recordCount = 0;
	private Record[] _records;
	
	mixin(_getter!("x", "y", "z", "recordCount", "records"));
	
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
		
		return minSize;
	}
}

class SoundEffect : Receivable
{
	mixin(_packetID!("SoundEffect"));
	mixin(_minSize!(17));
	
	private int _id, _x, _z, _data;
	private byte _y;
	
	mixin(_getter!("id", "x", "y", "z", "data"));
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_id
		|_x
		|_y
		|_z
		|_data;
		
		return minSize;
	}
}

class NewState : Receivable
{
	mixin(_packetID!("NewState"));
	mixin(_minSize!(1));
	
	private byte _reason, _mode;
	
	mixin(_getter!("reason", "mode"));
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_reason
		|_mode;
		
		return minSize;
	}
}

class Thunderbolt : Receivable
{
	mixin(_packetID!("Thunderbolt"));
	mixin(_minSize!(17));
	
	private int _EID, _x, _y, _z;
	private bool _unknown;
	
	mixin(_getter!("EID", "x", "y", "z"));
	
	public this()
	{
	}
	
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

class OpenWindow : Receivable
{
	mixin(_packetID!("OpenWindow"));
	
	public size_t minSize()
	{
		return 5 + 2 * _title.length;
	}
	
	private byte _id, _type, _slots;
	private char[] _title;
	
	mixin(_getter!("id", "type", "slots", "title"));
	
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
		
		return minSize;
	}
}

class CloseWindow : Sendable, Receivable
{
	mixin(_packetID!("CloseWindow"));
	mixin(_minSize!(1));
	
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
	mixin(_minSize!(5));
	
	private byte _id, _count;
	private short _slot, _itemID, _uses;
	
	mixin(_getter!("id", "count", "slot", "itemID", "uses"));
	
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
			
			return minSize + 3; //byte + short
		}
		
		return minSize;
	}
}

struct Item
{
	short id;
	byte count;
	short uses;
}

class WindowItems : Receivable
{
	mixin(_packetID!("WindowItems"));
	
	public size_t minSize()
	{
		return 3 + (2 * _count);
	}
		
	private byte _id;
	private short _count = 0;
	private Item[] _items;
	
	private int _size;

	mixin(_getter!("id", "count", "items"));
	
	public this()
	{
	}
	
	public int receive(MinecraftDataInput input)
	{
		_size = 0;
		
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
				_size += 3;
			}
			else
			{
				_size += 1;
			}
			_items[n] = i;
		}
		
		return 3 + _size;
	}
}

class UpdateProgress : Receivable
{
	mixin(_packetID!("UpdateProgress"));
	mixin(_minSize!(5));
	
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
	mixin(_minSize!(4));
	
	private byte _id;
	private short _transactionID;
	private bool _accepted;
	
	mixin(_getter!("id", "transactionID", "accepted"));
	
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

class CreativeInventoryAction : Receivable
{
	mixin(_packetID!("CreativeInventoryAction"));
	mixin(_minSize!(8));
	
	private short _slot, _id, _count, _uses;
	
	mixin(_getter!("slot", "id", "count", "uses"));
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_slot
		|_id
		|_count
		|_uses;
		
		return minSize;
	}
}

class UpdateSign : Receivable
{
	mixin(_packetID!("UpdateSign"));
	mixin(_minSize!(18));
	
	private int _x, _z;
	private short _y;
	private char[] _line1, _line2, _line3, _line4;
	
	mixin(_getter!("x", "y", "z", "line1", "line2", "line3", "line4"));
	
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
		
		return minSize + 2 * (_line1.length + _line2.length + _line3.length + _line4.length);
	}
}

class ItemData : Receivable
{
	mixin(_packetID!("ItemData"));
	
	public size_t minSize()
	{
		return 5 + _len;
	}
	
	private short _type, _id;
	private ubyte _len = 0;
	private byte[] _data;
	
	mixin(_getter!("type", "id", "len", "data"));
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_type
		|_id
		|_len;
		
		_data = new byte[_len];
		
		input.read(data);
		
		return minSize;
	}
}

class IncrementStatistic : Receivable
{
	mixin(_packetID!("IncrementStatistic"));
	mixin(_minSize!(5));
	
	private int _id;
	private byte _amount;
	
	mixin(_getter!("id", "amount"));
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_id
		|_amount;
		
		return minSize;
	}
}

class PlayerListItem : Receivable
{
	mixin(_packetID!("PlayerListItem"));
	mixin(_minSize!(5));
	
	private char[] _name;
	private bool _online;
	private short _ping;
	
	mixin(_getter!("name", "online", "ping"));
	
	public int receive(MinecraftDataInput input)
	{
		input
		|_name
		|_online
		|_ping;
		
		return minSize + 2 * _name.length;
	}
}

class ServerListPing : Sendable
{
	mixin(_packetID!("ServerListPing"));
	
	this()
	{
	}
	
	public void send(MinecraftDataOutput output)
	{
		//nothing to send
	}
}

class Disconnect : Sendable, Receivable
{
	mixin(_packetID!("Disconnect"));
	mixin(_minSize!(2));
	
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
		
		return minSize + 2 * _reason.length;
	}
}