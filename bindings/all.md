module all

global classes = 
{
	KeepAlive = 
	{
		
	}
	Login = 
	{
		properties = ["EID", "mapSeed", "dimension"]
		constructor = ["char[]", "char[]"]
	}
	Handshake =
	{
		properties = ["username", "connectionHash"]
		constructor = ["char[]"]
	}
	Chat = 
	{
		properties = ["message"]
		constructor = ["char[]"]
	}
	TimeUpdate =
	{
		properties = ["time"]
	}
	EntityEquipment = 
	{
		properties = ["EID", "slot", "itemID", "damage"]
	}
	SpawnPosition =
	{
		properties = ["x", "y", "z"]
	}
	UseEntity =
	{
		properties = ["user", "target", "leftClick"]
		constructor = ["int", "int", "bool"]
	}
	UpdateHealth =
	{
		properties = ["health"]
	}
	Respawn =
	{
		
	}
	Player =
	{
		constructor = ["bool"]
	}
	PlayerPosition =
	{
		constructor = ["double", "double", "double", "double", "bool"]
	}
	PlayerLook = 
	{
		constructor = ["float", "float", "bool"]
	}
	PlayerPositionLook =
	{
		properties = ["x", "y", "z", "stance", "yaw", "pitch", "onGround"]
		constructor = ["double", "double", "double", "double", "float", "float", "bool"]
	}
	DropItem =
	{
		
	}
	PlayerDigging = 
	{
		constructor = ["byte", "int", "byte", "int", "byte"]
	}
	PlayerBlockPlacement =
	{
		properties = ["x", "y", "z", "direction", "amount", "block", "itemID", "damage"]
		constructor = ["int", "byte", "int", "byte", "short", "byte", "short"]
	}
	HoldingChange =
	{
		constructor = ["short"]
	}
	UseBed =
	{
		properties = ["EID", "x", "y", "z"]
	}
	Animation =
	{
		constructor = ["int", "byte"]
		properties = ["EID", "animate"]
	}
	EntityAction =
	{
		constructor = ["int", "byte"]
		properties = ["EID", "action"]
	}
	NamedEntitySpawn =
	{
		properties = ["EID", "x", "y", "z", "name", "rotation", "pitch", "currentItem"]
	}
	PickupSpawn =
	{
		properties = ["EID", "x", "y", "z", "count", "rotation", "pitch", "roll", "itemID", "damage"]
	}
	CollectItem =
	{
		properties = ["collected", "collector"]
	}
	AddObject =
	{
		properties = ["EID", "x", "y", "z", "type"]
	}
	MobSpawn =
	{
		properties = ["EID", "x", "y", "z", "type", "yaw", "pitch"]
	}
	EntityPainting =
	{
		properties = ["EID", "x", "y", "z", "type", "title"]
	}
	EntityVelocity =
	{
		properties = ["EID", "x", "y", "z"]
	}
	DestroyEntity =
	{
		properties = ["EID"]
	}
	Entity =
	{
		properties = ["EID"]
	}
	EntityRelativeMove =
	{
		properties = ["EID", "dX", "dY", "dZ"]
	}
	EntityLook = 
	{
		properties = ["EID", "yaw", "pitch"]
	}
	EntityLookRelativeMove =
	{
		properties = ["EID", "dX", "dY", "dZ", "yaw", "pitch"]
	}
	EntityTeleport = 
	{
		properties = ["EID", "x", "y", "z", "yaw", "pitch"]
	}
	EntityStatus =
	{
		properties = ["EID", "status"]
	}
	AttachEntity = 
	{
		properties = ["EID", "vehicle"]
	}
	EntityMetadata = 
	{
		properties = ["EID"]
	}
	PreChunk = 
	{
		properties = ["x", "y", "mode"]
	}
	MapChunk = 
	{
		properties = ["x", "y", "z", "sizeX", "sizeY", "sizeZ", "data", "size"]
	}
	MultiBlockChange =
	{
		properties = ["length", "coordinates", "types", "metadata"]
	}
	BlockChange = 
	{
		properties = ["x", "y", "z", "type", "metadata"]
	}
	PlayNoteBlock =
	{
		properties = ["x", "y", "z", "type", "pitch"]
	}

	Explosion = 
	{
		properties = ["x", "y", "z", "recordCount", "records"]
	}

	OpenWindow = 
	{
		properties = ["id", "type", "slots", "title"]
	}
	CloseWindow = 
	{
		properties = ["id"]
		constructor = ["byte"]
	}
	WindowClick = 
	{
		constructor = ["byte", "short", "byte", "short", "short", "byte", "short"]
	}
	SetSlot = 
	{
		properties = ["id", "count", "slot", "itemID", "uses"]
	}
	
	WindowItems =
	{
		properties = ["id", "count", "items"]
	}

	UpdateProgress =
	{
		properties = ["id", "bar", "value"]
	}
	Transaction = 
	{
		properties = ["id", "transactionID", "accepted"]
	}
	UpdateSign = 
	{
		properties = ["x", "y", "z", "line1", "line2", "line3", "line4"]
	}
	Disconnect = 
	{
		constructor = ["char[]"]
		properties = ["reason"]
	}
}

global enums =
{
	DiggingStatus =
		"
			StartedDigging = 0x00,
			FinishedDigging = 0x02,
			DropItem = 0x04
		"
		
	Face =
		"
			BottomY = 0x00,
			TopY = 0x01,
			BottomZ = 0x02,
			TopZ = 0x03,
			BottomX = 0x04,
			TopX = 0x05
		"
		
	ObjectType =
		"
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
		"
		
	MobType =
		"
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
		"
		
	WoolColor =
		"
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
		"
	
	PacketID = 
		"
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
		"
		
	InventoryType = 
		"
			Chest = 0x00,
			Workbench = 0x01,
			Furnace = 0x02,
			Dispenser = 0x03
		"
		
	InstrumentType = 
		"
			Harp = 0x00,
			DoubleBass = 0x01,
			SnareDrum = 0x02,
			Sticks = 0x03,
			BassDrum = 0x04
		"
	EntityType =
		"
			Mob = 0x00,
			Object = 0x01,
			Player = 0x02,
			Pickup = 0x03
		"
	EntAction =
		"
			Crouch = 0x01,
			Uncrouch = 0x02,
			LeaveBed = 0x03
		"
}
