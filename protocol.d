module protocol;

static const int ProtocolVersion = 9;

enum : byte
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

class Packet
{
	public abstract byte id;
	public abstract bool valid;
}

class LoginRequest
{
}