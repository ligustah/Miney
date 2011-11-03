module bindings.all;

import tango.core.Variant;

import croc.api;
import croc.ex_bind;

import miney.protocol;
import miney.network;

void init(CrocThread* t)
{
	getRegistry(t);
	pushString(t, "croc.bind.initialized");

	if(!opin(t, -1, -2))
	{
		newTable(t);       fielda(t, -3, "croc.bind.WrappedClasses");
		newTable(t);       fielda(t, -3, "croc.bind.WrappedInstances");
		pushBool(t, true); fielda(t, -3);
		pop(t);
	}
	else
		pop(t, 2);
		
	PacketIDEnum.init(t);
	DiggingStatusEnum.init(t);
	FaceEnum.init(t);
	ObjectTypeEnum.init(t);
	MobTypeEnum.init(t);
	WoolColorEnum.init(t);
	InstrumentTypeEnum.init(t);
	InventoryTypeEnum.init(t);
	EntityTypeEnum.init(t);
	EntActionEnum.init(t);
	KeepAliveObj.init(t);
	LoginObj.init(t);
	HandshakeObj.init(t);
	ChatObj.init(t);
	TimeUpdateObj.init(t);
	EntityEquipmentObj.init(t);
	SpawnPositionObj.init(t);
	UseEntityObj.init(t);
	UpdateHealthObj.init(t);
	RespawnObj.init(t);
	PlayerObj.init(t);
	PlayerPositionObj.init(t);
	PlayerLookObj.init(t);
	PlayerPositionLookObj.init(t);
	DropItemObj.init(t);
	PlayerDiggingObj.init(t);
	PlayerBlockPlacementObj.init(t);
	HoldingChangeObj.init(t);
	UseBedObj.init(t);
	AnimationObj.init(t);
	EntityActionObj.init(t);
	NamedEntitySpawnObj.init(t);
	PickupSpawnObj.init(t);
	CollectItemObj.init(t);
	AddObjectObj.init(t);
	MobSpawnObj.init(t);
	EntityPaintingObj.init(t);
	ExperienceOrbObj.init(t);
	UnknownObj.init(t);
	EntityVelocityObj.init(t);
	DestroyEntityObj.init(t);
	EntityObj.init(t);
	EntityRelativeMoveObj.init(t);
	EntityLookObj.init(t);
	EntityLookRelativeMoveObj.init(t);
	EntityTeleportObj.init(t);
	EntityStatusObj.init(t);
	AttachEntityObj.init(t);
	EntityMetadataObj.init(t);
	EntityEffectObj.init(t);
	RemoveEntityEffectObj.init(t);
	ExperienceObj.init(t);
	PreChunkObj.init(t);
	MapChunkObj.init(t);
	MultiBlockChangeObj.init(t);
	BlockChangeObj.init(t);
	BlockActionObj.init(t);
	ExplosionObj.init(t);
	SoundEffectObj.init(t);
	NewStateObj.init(t);
	ThunderboltObj.init(t);
	OpenWindowObj.init(t);
	CloseWindowObj.init(t);
	WindowClickObj.init(t);
	SetSlotObj.init(t);
	WindowItemsObj.init(t);
	UpdateProgressObj.init(t);
	TransactionObj.init(t);
	CreativeInventoryActionObj.init(t);
	UpdateSignObj.init(t);
	ItemDataObj.init(t);
	IncrementStatisticObj.init(t);
	PlayerListItemObj.init(t);
	ServerListPingObj.init(t);
	DisconnectObj.init(t);
}

struct PacketIDEnum
{
	static:
	void init(CrocThread* t)
	{
		newNamespace(t, "PacketID");
		
		pushInt(t, PacketID.KeepAlive); fielda(t, -2, "KeepAlive");
		pushInt(t, PacketID.Login); fielda(t, -2, "Login");
		pushInt(t, PacketID.Handshake); fielda(t, -2, "Handshake");
		pushInt(t, PacketID.Chat); fielda(t, -2, "Chat");
		pushInt(t, PacketID.TimeUpdate); fielda(t, -2, "TimeUpdate");
		pushInt(t, PacketID.EntityEquipment); fielda(t, -2, "EntityEquipment");
		pushInt(t, PacketID.SpawnPosition); fielda(t, -2, "SpawnPosition");
		pushInt(t, PacketID.UseEntity); fielda(t, -2, "UseEntity");
		pushInt(t, PacketID.UpdateHealth); fielda(t, -2, "UpdateHealth");
		pushInt(t, PacketID.Respawn); fielda(t, -2, "Respawn");
		pushInt(t, PacketID.Player); fielda(t, -2, "Player");
		pushInt(t, PacketID.PlayerPosition); fielda(t, -2, "PlayerPosition");
		pushInt(t, PacketID.PlayerLook); fielda(t, -2, "PlayerLook");
		pushInt(t, PacketID.PlayerPositionLook); fielda(t, -2, "PlayerPositionLook");
		pushInt(t, PacketID.PlayerDigging); fielda(t, -2, "PlayerDigging");
		pushInt(t, PacketID.PlayerBlockPlacement); fielda(t, -2, "PlayerBlockPlacement");
		pushInt(t, PacketID.HoldingChange); fielda(t, -2, "HoldingChange");
		pushInt(t, PacketID.UseBed); fielda(t, -2, "UseBed");
		pushInt(t, PacketID.Animation); fielda(t, -2, "Animation");
		pushInt(t, PacketID.EntityAction); fielda(t, -2, "EntityAction");
		pushInt(t, PacketID.NamedEntitySpawn); fielda(t, -2, "NamedEntitySpawn");
		pushInt(t, PacketID.PickupSpawn); fielda(t, -2, "PickupSpawn");
		pushInt(t, PacketID.CollectItem); fielda(t, -2, "CollectItem");
		pushInt(t, PacketID.AddObject); fielda(t, -2, "AddObject");
		pushInt(t, PacketID.MobSpawn); fielda(t, -2, "MobSpawn");
		pushInt(t, PacketID.EntityPainting); fielda(t, -2, "EntityPainting");
		pushInt(t, PacketID.ExperienceOrb); fielda(t, -2, "ExperienceOrb");
		pushInt(t, PacketID.Unknown); fielda(t, -2, "Unknown");
		pushInt(t, PacketID.EntityVelocity); fielda(t, -2, "EntityVelocity");
		pushInt(t, PacketID.DestroyEntity); fielda(t, -2, "DestroyEntity");
		pushInt(t, PacketID.Entity); fielda(t, -2, "Entity");
		pushInt(t, PacketID.EntityRelativeMove); fielda(t, -2, "EntityRelativeMove");
		pushInt(t, PacketID.EntityLook); fielda(t, -2, "EntityLook");
		pushInt(t, PacketID.EntityLookRelativeMove); fielda(t, -2, "EntityLookRelativeMove");
		pushInt(t, PacketID.EntityTeleport); fielda(t, -2, "EntityTeleport");
		pushInt(t, PacketID.EntityStatus); fielda(t, -2, "EntityStatus");
		pushInt(t, PacketID.AttachEntity); fielda(t, -2, "AttachEntity");
		pushInt(t, PacketID.EntityMetadata); fielda(t, -2, "EntityMetadata");
		pushInt(t, PacketID.EntityEffect); fielda(t, -2, "EntityEffect");
		pushInt(t, PacketID.RemoveEntityEffect); fielda(t, -2, "RemoveEntityEffect");
		pushInt(t, PacketID.Experience); fielda(t, -2, "Experience");
		pushInt(t, PacketID.PreChunk); fielda(t, -2, "PreChunk");
		pushInt(t, PacketID.MapChunk); fielda(t, -2, "MapChunk");
		pushInt(t, PacketID.MultiBlockChange); fielda(t, -2, "MultiBlockChange");
		pushInt(t, PacketID.BlockChange); fielda(t, -2, "BlockChange");
		pushInt(t, PacketID.BlockAction); fielda(t, -2, "BlockAction");
		pushInt(t, PacketID.Explosion); fielda(t, -2, "Explosion");
		pushInt(t, PacketID.SoundEffect); fielda(t, -2, "SoundEffect");
		pushInt(t, PacketID.NewState); fielda(t, -2, "NewState");
		pushInt(t, PacketID.Thunderbolt); fielda(t, -2, "Thunderbolt");
		pushInt(t, PacketID.OpenWindow); fielda(t, -2, "OpenWindow");
		pushInt(t, PacketID.CloseWindow); fielda(t, -2, "CloseWindow");
		pushInt(t, PacketID.WindowClick); fielda(t, -2, "WindowClick");
		pushInt(t, PacketID.SetSlot); fielda(t, -2, "SetSlot");
		pushInt(t, PacketID.WindowItems); fielda(t, -2, "WindowItems");
		pushInt(t, PacketID.UpdateProgress); fielda(t, -2, "UpdateProgress");
		pushInt(t, PacketID.Transaction); fielda(t, -2, "Transaction");
		pushInt(t, PacketID.CreativeInventoryAction); fielda(t, -2, "CreativeInventoryAction");
		pushInt(t, PacketID.UpdateSign); fielda(t, -2, "UpdateSign");
		pushInt(t, PacketID.ItemData); fielda(t, -2, "ItemData");
		pushInt(t, PacketID.IncrementStatistic); fielda(t, -2, "IncrementStatistic");
		pushInt(t, PacketID.PlayerListItem); fielda(t, -2, "PlayerListItem");
		pushInt(t, PacketID.ServerListPing); fielda(t, -2, "ServerListPing");
		pushInt(t, PacketID.Disconnect); fielda(t, -2, "Disconnect");
		
		newGlobal(t, "PacketID");
	}
}

struct DiggingStatusEnum
{
	static:
	void init(CrocThread* t)
	{
		newNamespace(t, "DiggingStatus");
		
		pushInt(t, DiggingStatus.StartedDigging); fielda(t, -2, "StartedDigging");
		pushInt(t, DiggingStatus.FinishedDigging); fielda(t, -2, "FinishedDigging");
		pushInt(t, DiggingStatus.DropItem); fielda(t, -2, "DropItem");
		
		newGlobal(t, "DiggingStatus");
	}
}

struct FaceEnum
{
	static:
	void init(CrocThread* t)
	{
		newNamespace(t, "Face");
		
		pushInt(t, Face.BottomY); fielda(t, -2, "BottomY");
		pushInt(t, Face.TopY); fielda(t, -2, "TopY");
		pushInt(t, Face.BottomZ); fielda(t, -2, "BottomZ");
		pushInt(t, Face.TopZ); fielda(t, -2, "TopZ");
		pushInt(t, Face.BottomX); fielda(t, -2, "BottomX");
		pushInt(t, Face.TopX); fielda(t, -2, "TopX");
		
		newGlobal(t, "Face");
	}
}

struct ObjectTypeEnum
{
	static:
	void init(CrocThread* t)
	{
		newNamespace(t, "ObjectType");
		
		pushInt(t, ObjectType.Boat); fielda(t, -2, "Boat");
		pushInt(t, ObjectType.Minecart); fielda(t, -2, "Minecart");
		pushInt(t, ObjectType.StorageCart); fielda(t, -2, "StorageCart");
		pushInt(t, ObjectType.PoweredCart); fielda(t, -2, "PoweredCart");
		pushInt(t, ObjectType.TNT); fielda(t, -2, "TNT");
		pushInt(t, ObjectType.Arrow); fielda(t, -2, "Arrow");
		pushInt(t, ObjectType.SnowBall); fielda(t, -2, "SnowBall");
		pushInt(t, ObjectType.Egg); fielda(t, -2, "Egg");
		pushInt(t, ObjectType.Sand); fielda(t, -2, "Sand");
		pushInt(t, ObjectType.Gravel); fielda(t, -2, "Gravel");
		pushInt(t, ObjectType.FishingFloat); fielda(t, -2, "FishingFloat");
		
		newGlobal(t, "ObjectType");
	}
}

struct MobTypeEnum
{
	static:
	void init(CrocThread* t)
	{
		newNamespace(t, "MobType");
		
		pushInt(t, MobType.Creeper); fielda(t, -2, "Creeper");
		pushInt(t, MobType.Skeleton); fielda(t, -2, "Skeleton");
		pushInt(t, MobType.Spider); fielda(t, -2, "Spider");
		pushInt(t, MobType.GiantZombie); fielda(t, -2, "GiantZombie");
		pushInt(t, MobType.Zombie); fielda(t, -2, "Zombie");
		pushInt(t, MobType.Slime); fielda(t, -2, "Slime");
		pushInt(t, MobType.Ghast); fielda(t, -2, "Ghast");
		pushInt(t, MobType.ZombiePigman); fielda(t, -2, "ZombiePigman");
		pushInt(t, MobType.Pig); fielda(t, -2, "Pig");
		pushInt(t, MobType.Sheep); fielda(t, -2, "Sheep");
		pushInt(t, MobType.Cow); fielda(t, -2, "Cow");
		pushInt(t, MobType.Hen); fielda(t, -2, "Hen");
		pushInt(t, MobType.Squid); fielda(t, -2, "Squid");
		pushInt(t, MobType.Wolf); fielda(t, -2, "Wolf");
		
		newGlobal(t, "MobType");
	}
}

struct WoolColorEnum
{
	static:
	void init(CrocThread* t)
	{
		newNamespace(t, "WoolColor");
		
		pushInt(t, WoolColor.White); fielda(t, -2, "White");
		pushInt(t, WoolColor.Orange); fielda(t, -2, "Orange");
		pushInt(t, WoolColor.Magenta); fielda(t, -2, "Magenta");
		pushInt(t, WoolColor.LightBlue); fielda(t, -2, "LightBlue");
		pushInt(t, WoolColor.Yellow); fielda(t, -2, "Yellow");
		pushInt(t, WoolColor.Lime); fielda(t, -2, "Lime");
		pushInt(t, WoolColor.Pink); fielda(t, -2, "Pink");
		pushInt(t, WoolColor.Gray); fielda(t, -2, "Gray");
		pushInt(t, WoolColor.Silver); fielda(t, -2, "Silver");
		pushInt(t, WoolColor.Cyan); fielda(t, -2, "Cyan");
		pushInt(t, WoolColor.Purple); fielda(t, -2, "Purple");
		pushInt(t, WoolColor.Blue); fielda(t, -2, "Blue");
		pushInt(t, WoolColor.Brown); fielda(t, -2, "Brown");
		pushInt(t, WoolColor.Green); fielda(t, -2, "Green");
		pushInt(t, WoolColor.Red); fielda(t, -2, "Red");
		pushInt(t, WoolColor.Black); fielda(t, -2, "Black");
		
		newGlobal(t, "WoolColor");
	}
}

struct InstrumentTypeEnum
{
	static:
	void init(CrocThread* t)
	{
		newNamespace(t, "InstrumentType");
		
		pushInt(t, InstrumentType.Harp); fielda(t, -2, "Harp");
		pushInt(t, InstrumentType.DoubleBass); fielda(t, -2, "DoubleBass");
		pushInt(t, InstrumentType.SnareDrum); fielda(t, -2, "SnareDrum");
		pushInt(t, InstrumentType.Sticks); fielda(t, -2, "Sticks");
		pushInt(t, InstrumentType.BassDrum); fielda(t, -2, "BassDrum");
		
		newGlobal(t, "InstrumentType");
	}
}

struct InventoryTypeEnum
{
	static:
	void init(CrocThread* t)
	{
		newNamespace(t, "InventoryType");
		
		pushInt(t, InventoryType.Chest); fielda(t, -2, "Chest");
		pushInt(t, InventoryType.Workbench); fielda(t, -2, "Workbench");
		pushInt(t, InventoryType.Furnace); fielda(t, -2, "Furnace");
		pushInt(t, InventoryType.Dispenser); fielda(t, -2, "Dispenser");
		
		newGlobal(t, "InventoryType");
	}
}

struct EntityTypeEnum
{
	static:
	void init(CrocThread* t)
	{
		newNamespace(t, "EntityType");
		
		pushInt(t, EntityType.Mob); fielda(t, -2, "Mob");
		pushInt(t, EntityType.Object); fielda(t, -2, "Object");
		pushInt(t, EntityType.Player); fielda(t, -2, "Player");
		pushInt(t, EntityType.Pickup); fielda(t, -2, "Pickup");
		
		newGlobal(t, "EntityType");
	}
}

struct EntActionEnum
{
	static:
	void init(CrocThread* t)
	{
		newNamespace(t, "EntAction");
		
		pushInt(t, EntAction.Crouch); fielda(t, -2, "Crouch");
		pushInt(t, EntAction.Uncrouch); fielda(t, -2, "Uncrouch");
		pushInt(t, EntAction.LeaveBed); fielda(t, -2, "LeaveBed");
		pushInt(t, EntAction.StartSprinting); fielda(t, -2, "StartSprinting");
		pushInt(t, EntAction.StopSprinting); fielda(t, -2, "StopSprinting");
		
		newGlobal(t, "EntAction");
	}
}

struct KeepAliveObj
{
	static:
	private KeepAlive getThis(CrocThread* t)
	{
		return cast(KeepAlive)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "KeepAlive");
		KeepAlive inst;
		
		if(numParams == 0)
		{
			inst = new KeepAlive();
		}
		
		if(numParams == 1 && TypesMatch!(int)(t))
		{
			// getting parameters
			int id = superGet!(int)(t, 1);
			
			inst = new KeepAlive(id);
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		KeepAlive inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword send(CrocThread* t)
	{
		KeepAlive inst = getThis(t);
		
		MinecraftDataOutput output = superGet!(MinecraftDataOutput)(t, 1);
		
		//call the function
		inst.send(output);
		return 0;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type KeepAlive`, fieldName);
			
			case "id":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_id`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type KeepAlive`, fieldName);
			
			case "id":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_id`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_id(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		KeepAlive inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.id);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'id' of type 'int'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		KeepAlive inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		KeepAlive inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "KeepAlive", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			c.method("send", &send);
			
			//properties
			c.method("_prop_id", &_prop_id);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "KeepAlive.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(KeepAlive));
		newGlobal(t, "KeepAlive");
	}
}

struct LoginObj
{
	static:
	private Login getThis(CrocThread* t)
	{
		return cast(Login)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "Login");
		Login inst;
		
		if(numParams == 1 && TypesMatch!(char[])(t))
		{
			// getting parameters
			char[] username = superGet!(char[])(t, 1);
			
			inst = new Login(username);
		}
		
		if(numParams == 0)
		{
			inst = new Login();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		Login inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword send(CrocThread* t)
	{
		Login inst = getThis(t);
		
		MinecraftDataOutput output = superGet!(MinecraftDataOutput)(t, 1);
		
		//call the function
		inst.send(output);
		return 0;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type Login`, fieldName);
			
			case "dimension":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_dimension`, 1);
				break;
			
			case "mapSeed":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_mapSeed`, 1);
				break;
			
			case "mode":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_mode`, 1);
				break;
			
			case "height":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_height`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_EID`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "difficulty":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_difficulty`, 1);
				break;
			
			case "maxPlayers":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_maxPlayers`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type Login`, fieldName);
			
			case "dimension":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_dimension`, 0);
				break;
			
			case "mapSeed":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_mapSeed`, 0);
				break;
			
			case "mode":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_mode`, 0);
				break;
			
			case "height":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_height`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_EID`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "difficulty":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_difficulty`, 0);
				break;
			
			case "maxPlayers":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_maxPlayers`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_dimension(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Login inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.dimension);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'dimension' of type 'byte'");
	}
	
	uword _prop_mapSeed(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Login inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.mapSeed);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'mapSeed' of type 'long'");
	}
	
	uword _prop_mode(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Login inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.mode);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'mode' of type 'int'");
	}
	
	uword _prop_height(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Login inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.height);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'height' of type 'ubyte'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Login inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_EID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Login inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.EID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'EID' of type 'int'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Login inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_difficulty(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Login inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.difficulty);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'difficulty' of type 'byte'");
	}
	
	uword _prop_maxPlayers(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Login inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.maxPlayers);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'maxPlayers' of type 'ubyte'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "Login", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			c.method("send", &send);
			
			//properties
			c.method("_prop_dimension", &_prop_dimension);
			c.method("_prop_mapSeed", &_prop_mapSeed);
			c.method("_prop_mode", &_prop_mode);
			c.method("_prop_height", &_prop_height);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_EID", &_prop_EID);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_difficulty", &_prop_difficulty);
			c.method("_prop_maxPlayers", &_prop_maxPlayers);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "Login.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(Login));
		newGlobal(t, "Login");
	}
}

struct HandshakeObj
{
	static:
	private Handshake getThis(CrocThread* t)
	{
		return cast(Handshake)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "Handshake");
		Handshake inst;
		
		if(numParams == 1 && TypesMatch!(char[])(t))
		{
			// getting parameters
			char[] username = superGet!(char[])(t, 1);
			
			inst = new Handshake(username);
		}
		
		if(numParams == 0)
		{
			inst = new Handshake();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword send(CrocThread* t)
	{
		Handshake inst = getThis(t);
		
		MinecraftDataOutput output = superGet!(MinecraftDataOutput)(t, 1);
		
		//call the function
		inst.send(output);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		Handshake inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type Handshake`, fieldName);
			
			case "connectionHash":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_connectionHash`, 1);
				break;
			
			case "username":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_username`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type Handshake`, fieldName);
			
			case "connectionHash":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_connectionHash`, 0);
				break;
			
			case "username":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_username`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_connectionHash(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Handshake inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.connectionHash);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'connectionHash' of type 'char[]'");
	}
	
	uword _prop_username(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Handshake inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.username);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'username' of type 'char[]'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Handshake inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Handshake inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "Handshake", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("send", &send);
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_connectionHash", &_prop_connectionHash);
			c.method("_prop_username", &_prop_username);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "Handshake.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(Handshake));
		newGlobal(t, "Handshake");
	}
}

struct ChatObj
{
	static:
	private Chat getThis(CrocThread* t)
	{
		return cast(Chat)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "Chat");
		Chat inst;
		
		if(numParams == 1 && TypesMatch!(char[])(t))
		{
			// getting parameters
			char[] message = superGet!(char[])(t, 1);
			
			inst = new Chat(message);
		}
		
		if(numParams == 0)
		{
			inst = new Chat();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		Chat inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword send(CrocThread* t)
	{
		Chat inst = getThis(t);
		
		MinecraftDataOutput output = superGet!(MinecraftDataOutput)(t, 1);
		
		//call the function
		inst.send(output);
		return 0;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type Chat`, fieldName);
			
			case "message":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_message`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type Chat`, fieldName);
			
			case "message":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_message`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_message(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Chat inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.message);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'message' of type 'char[]'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Chat inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Chat inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "Chat", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			c.method("send", &send);
			
			//properties
			c.method("_prop_message", &_prop_message);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "Chat.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(Chat));
		newGlobal(t, "Chat");
	}
}

struct TimeUpdateObj
{
	static:
	private TimeUpdate getThis(CrocThread* t)
	{
		return cast(TimeUpdate)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "TimeUpdate");
		TimeUpdate inst;
		
		if(numParams == 0)
		{
			inst = new TimeUpdate();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		TimeUpdate inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type TimeUpdate`, fieldName);
			
			case "time":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_time`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type TimeUpdate`, fieldName);
			
			case "time":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_time`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_time(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		TimeUpdate inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.time);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'time' of type 'long'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		TimeUpdate inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		TimeUpdate inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "TimeUpdate", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_time", &_prop_time);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "TimeUpdate.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(TimeUpdate));
		newGlobal(t, "TimeUpdate");
	}
}

struct EntityEquipmentObj
{
	static:
	private EntityEquipment getThis(CrocThread* t)
	{
		return cast(EntityEquipment)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "EntityEquipment");
		EntityEquipment inst;
		
		if(numParams == 0)
		{
			inst = new EntityEquipment();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		EntityEquipment inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type EntityEquipment`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_EID`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "itemID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_itemID`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "damage":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_damage`, 1);
				break;
			
			case "slot":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_slot`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type EntityEquipment`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_EID`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "itemID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_itemID`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "damage":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_damage`, 0);
				break;
			
			case "slot":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_slot`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_EID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityEquipment inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.EID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'EID' of type 'int'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityEquipment inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_itemID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityEquipment inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.itemID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'itemID' of type 'short'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityEquipment inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_damage(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityEquipment inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.damage);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'damage' of type 'short'");
	}
	
	uword _prop_slot(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityEquipment inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.slot);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'slot' of type 'short'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "EntityEquipment", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_EID", &_prop_EID);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_itemID", &_prop_itemID);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_damage", &_prop_damage);
			c.method("_prop_slot", &_prop_slot);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "EntityEquipment.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(EntityEquipment));
		newGlobal(t, "EntityEquipment");
	}
}

struct SpawnPositionObj
{
	static:
	private SpawnPosition getThis(CrocThread* t)
	{
		return cast(SpawnPosition)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "SpawnPosition");
		SpawnPosition inst;
		
		if(numParams == 0)
		{
			inst = new SpawnPosition();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		SpawnPosition inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type SpawnPosition`, fieldName);
			
			case "y":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_y`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "z":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_z`, 1);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_x`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type SpawnPosition`, fieldName);
			
			case "y":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_y`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "z":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_z`, 0);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_x`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_y(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		SpawnPosition inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.y);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'y' of type 'int'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		SpawnPosition inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_z(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		SpawnPosition inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.z);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'z' of type 'int'");
	}
	
	uword _prop_x(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		SpawnPosition inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.x);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'x' of type 'int'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		SpawnPosition inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "SpawnPosition", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_y", &_prop_y);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_z", &_prop_z);
			c.method("_prop_x", &_prop_x);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "SpawnPosition.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(SpawnPosition));
		newGlobal(t, "SpawnPosition");
	}
}

struct UseEntityObj
{
	static:
	private UseEntity getThis(CrocThread* t)
	{
		return cast(UseEntity)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "UseEntity");
		UseEntity inst;
		
		if(numParams == 3 && TypesMatch!(int, int, bool)(t))
		{
			// getting parameters
			int user = superGet!(int)(t, 1);
			int target = superGet!(int)(t, 2);
			bool leftClick = superGet!(bool)(t, 3);
			
			inst = new UseEntity(user, target, leftClick);
		}
		
		if(numParams == 0)
		{
			inst = new UseEntity();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		UseEntity inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword send(CrocThread* t)
	{
		UseEntity inst = getThis(t);
		
		MinecraftDataOutput output = superGet!(MinecraftDataOutput)(t, 1);
		
		//call the function
		inst.send(output);
		return 0;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type UseEntity`, fieldName);
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "target":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_target`, 1);
				break;
			
			case "leftClick":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_leftClick`, 1);
				break;
			
			case "user":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_user`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type UseEntity`, fieldName);
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "target":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_target`, 0);
				break;
			
			case "leftClick":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_leftClick`, 0);
				break;
			
			case "user":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_user`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		UseEntity inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_target(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		UseEntity inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.target);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'target' of type 'int'");
	}
	
	uword _prop_leftClick(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		UseEntity inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.leftClick);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'leftClick' of type 'bool'");
	}
	
	uword _prop_user(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		UseEntity inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.user);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'user' of type 'int'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		UseEntity inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "UseEntity", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			c.method("send", &send);
			
			//properties
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_target", &_prop_target);
			c.method("_prop_leftClick", &_prop_leftClick);
			c.method("_prop_user", &_prop_user);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "UseEntity.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(UseEntity));
		newGlobal(t, "UseEntity");
	}
}

struct UpdateHealthObj
{
	static:
	private UpdateHealth getThis(CrocThread* t)
	{
		return cast(UpdateHealth)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "UpdateHealth");
		UpdateHealth inst;
		
		if(numParams == 0)
		{
			inst = new UpdateHealth();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		UpdateHealth inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type UpdateHealth`, fieldName);
			
			case "saturation":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_saturation`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "health":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_health`, 1);
				break;
			
			case "food":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_food`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type UpdateHealth`, fieldName);
			
			case "saturation":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_saturation`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "health":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_health`, 0);
				break;
			
			case "food":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_food`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_saturation(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		UpdateHealth inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.saturation);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'saturation' of type 'float'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		UpdateHealth inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		UpdateHealth inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_health(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		UpdateHealth inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.health);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'health' of type 'short'");
	}
	
	uword _prop_food(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		UpdateHealth inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.food);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'food' of type 'short'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "UpdateHealth", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_saturation", &_prop_saturation);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_health", &_prop_health);
			c.method("_prop_food", &_prop_food);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "UpdateHealth.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(UpdateHealth));
		newGlobal(t, "UpdateHealth");
	}
}

struct RespawnObj
{
	static:
	private Respawn getThis(CrocThread* t)
	{
		return cast(Respawn)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "Respawn");
		Respawn inst;
		
		if(numParams == 0)
		{
			inst = new Respawn();
		}
		
		if(numParams == 5 && TypesMatch!(byte, byte, byte, short, long)(t))
		{
			// getting parameters
			byte world = superGet!(byte)(t, 1);
			byte difficulty = superGet!(byte)(t, 2);
			byte creative = superGet!(byte)(t, 3);
			short height = superGet!(short)(t, 4);
			long seed = superGet!(long)(t, 5);
			
			inst = new Respawn(world, difficulty, creative, height, seed);
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		Respawn inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword send(CrocThread* t)
	{
		Respawn inst = getThis(t);
		
		MinecraftDataOutput output = superGet!(MinecraftDataOutput)(t, 1);
		
		//call the function
		inst.send(output);
		return 0;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type Respawn`, fieldName);
			
			case "height":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_height`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "creative":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_creative`, 1);
				break;
			
			case "world":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_world`, 1);
				break;
			
			case "seed":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_seed`, 1);
				break;
			
			case "difficulty":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_difficulty`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type Respawn`, fieldName);
			
			case "height":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_height`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "creative":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_creative`, 0);
				break;
			
			case "world":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_world`, 0);
				break;
			
			case "seed":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_seed`, 0);
				break;
			
			case "difficulty":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_difficulty`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_height(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Respawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.height);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'height' of type 'short'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Respawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_creative(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Respawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.creative);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'creative' of type 'byte'");
	}
	
	uword _prop_world(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Respawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.world);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'world' of type 'byte'");
	}
	
	uword _prop_seed(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Respawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.seed);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'seed' of type 'long'");
	}
	
	uword _prop_difficulty(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Respawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.difficulty);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'difficulty' of type 'byte'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Respawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "Respawn", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			c.method("send", &send);
			
			//properties
			c.method("_prop_height", &_prop_height);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_creative", &_prop_creative);
			c.method("_prop_world", &_prop_world);
			c.method("_prop_seed", &_prop_seed);
			c.method("_prop_difficulty", &_prop_difficulty);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "Respawn.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(Respawn));
		newGlobal(t, "Respawn");
	}
}

struct PlayerObj
{
	static:
	private Player getThis(CrocThread* t)
	{
		return cast(Player)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "Player");
		Player inst;
		
		if(numParams == 1 && TypesMatch!(bool)(t))
		{
			// getting parameters
			bool onGround = superGet!(bool)(t, 1);
			
			inst = new Player(onGround);
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword send(CrocThread* t)
	{
		Player inst = getThis(t);
		
		MinecraftDataOutput output = superGet!(MinecraftDataOutput)(t, 1);
		
		//call the function
		inst.send(output);
		return 0;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type Player`, fieldName);
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type Player`, fieldName);
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Player inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "Player", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("send", &send);
			
			//properties
			c.method("_prop_packetID", &_prop_packetID);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "Player.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(Player));
		newGlobal(t, "Player");
	}
}

struct PlayerPositionObj
{
	static:
	private PlayerPosition getThis(CrocThread* t)
	{
		return cast(PlayerPosition)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "PlayerPosition");
		PlayerPosition inst;
		
		if(numParams == 5 && TypesMatch!(double, double, double, double, bool)(t))
		{
			// getting parameters
			double x = superGet!(double)(t, 1);
			double y = superGet!(double)(t, 2);
			double z = superGet!(double)(t, 3);
			double stance = superGet!(double)(t, 4);
			bool onGround = superGet!(bool)(t, 5);
			
			inst = new PlayerPosition(x, y, z, stance, onGround);
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword send(CrocThread* t)
	{
		PlayerPosition inst = getThis(t);
		
		MinecraftDataOutput output = superGet!(MinecraftDataOutput)(t, 1);
		
		//call the function
		inst.send(output);
		return 0;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type PlayerPosition`, fieldName);
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type PlayerPosition`, fieldName);
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PlayerPosition inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "PlayerPosition", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("send", &send);
			
			//properties
			c.method("_prop_packetID", &_prop_packetID);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "PlayerPosition.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(PlayerPosition));
		newGlobal(t, "PlayerPosition");
	}
}

struct PlayerLookObj
{
	static:
	private PlayerLook getThis(CrocThread* t)
	{
		return cast(PlayerLook)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "PlayerLook");
		PlayerLook inst;
		
		if(numParams == 3 && TypesMatch!(float, float, bool)(t))
		{
			// getting parameters
			float yaw = superGet!(float)(t, 1);
			float pitch = superGet!(float)(t, 2);
			bool onGround = superGet!(bool)(t, 3);
			
			inst = new PlayerLook(yaw, pitch, onGround);
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword send(CrocThread* t)
	{
		PlayerLook inst = getThis(t);
		
		MinecraftDataOutput output = superGet!(MinecraftDataOutput)(t, 1);
		
		//call the function
		inst.send(output);
		return 0;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type PlayerLook`, fieldName);
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type PlayerLook`, fieldName);
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PlayerLook inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "PlayerLook", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("send", &send);
			
			//properties
			c.method("_prop_packetID", &_prop_packetID);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "PlayerLook.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(PlayerLook));
		newGlobal(t, "PlayerLook");
	}
}

struct PlayerPositionLookObj
{
	static:
	private PlayerPositionLook getThis(CrocThread* t)
	{
		return cast(PlayerPositionLook)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "PlayerPositionLook");
		PlayerPositionLook inst;
		
		if(numParams == 0)
		{
			inst = new PlayerPositionLook();
		}
		
		if(numParams == 7 && TypesMatch!(double, double, double, double, float, float, bool)(t))
		{
			// getting parameters
			double x = superGet!(double)(t, 1);
			double y = superGet!(double)(t, 2);
			double z = superGet!(double)(t, 3);
			double stance = superGet!(double)(t, 4);
			float yaw = superGet!(float)(t, 5);
			float pitch = superGet!(float)(t, 6);
			bool onGround = superGet!(bool)(t, 7);
			
			inst = new PlayerPositionLook(x, y, z, stance, yaw, pitch, onGround);
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword send(CrocThread* t)
	{
		PlayerPositionLook inst = getThis(t);
		
		MinecraftDataOutput output = superGet!(MinecraftDataOutput)(t, 1);
		
		//call the function
		inst.send(output);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		PlayerPositionLook inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type PlayerPositionLook`, fieldName);
			
			case "z":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_z`, 1);
				break;
			
			case "stance":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_stance`, 1);
				break;
			
			case "onGround":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_onGround`, 1);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_x`, 1);
				break;
			
			case "pitch":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_pitch`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "y":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_y`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "yaw":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_yaw`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type PlayerPositionLook`, fieldName);
			
			case "z":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_z`, 0);
				break;
			
			case "stance":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_stance`, 0);
				break;
			
			case "onGround":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_onGround`, 0);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_x`, 0);
				break;
			
			case "pitch":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_pitch`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "y":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_y`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "yaw":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_yaw`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_z(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PlayerPositionLook inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.z);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'z' of type 'double'");
	}
	
	uword _prop_stance(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PlayerPositionLook inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.stance);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'stance' of type 'double'");
	}
	
	uword _prop_onGround(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PlayerPositionLook inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.onGround);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'onGround' of type 'bool'");
	}
	
	uword _prop_x(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PlayerPositionLook inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.x);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'x' of type 'double'");
	}
	
	uword _prop_pitch(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PlayerPositionLook inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.pitch);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'pitch' of type 'float'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PlayerPositionLook inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_y(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PlayerPositionLook inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.y);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'y' of type 'double'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PlayerPositionLook inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_yaw(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PlayerPositionLook inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.yaw);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'yaw' of type 'float'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "PlayerPositionLook", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("send", &send);
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_z", &_prop_z);
			c.method("_prop_stance", &_prop_stance);
			c.method("_prop_onGround", &_prop_onGround);
			c.method("_prop_x", &_prop_x);
			c.method("_prop_pitch", &_prop_pitch);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_y", &_prop_y);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_yaw", &_prop_yaw);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "PlayerPositionLook.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(PlayerPositionLook));
		newGlobal(t, "PlayerPositionLook");
	}
}

struct DropItemObj
{
	static:
	private DropItem getThis(CrocThread* t)
	{
		return cast(DropItem)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "DropItem");
		DropItem inst;
		
		if(numParams == 0)
		{
			inst = new DropItem();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type DropItem`, fieldName);
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type DropItem`, fieldName);
		}
		return 0;
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "DropItem", (CreateClass* c)
		{
			c.method("constructor", &constructor);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "DropItem.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(DropItem));
		newGlobal(t, "DropItem");
	}
}

struct PlayerDiggingObj
{
	static:
	private PlayerDigging getThis(CrocThread* t)
	{
		return cast(PlayerDigging)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "PlayerDigging");
		PlayerDigging inst;
		
		if(numParams == 5 && TypesMatch!(byte, int, byte, int, byte)(t))
		{
			// getting parameters
			byte status = superGet!(byte)(t, 1);
			int x = superGet!(int)(t, 2);
			byte y = superGet!(byte)(t, 3);
			int z = superGet!(int)(t, 4);
			byte face = superGet!(byte)(t, 5);
			
			inst = new PlayerDigging(status, x, y, z, face);
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword send(CrocThread* t)
	{
		PlayerDigging inst = getThis(t);
		
		MinecraftDataOutput output = superGet!(MinecraftDataOutput)(t, 1);
		
		//call the function
		inst.send(output);
		return 0;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type PlayerDigging`, fieldName);
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type PlayerDigging`, fieldName);
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PlayerDigging inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "PlayerDigging", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("send", &send);
			
			//properties
			c.method("_prop_packetID", &_prop_packetID);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "PlayerDigging.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(PlayerDigging));
		newGlobal(t, "PlayerDigging");
	}
}

struct PlayerBlockPlacementObj
{
	static:
	private PlayerBlockPlacement getThis(CrocThread* t)
	{
		return cast(PlayerBlockPlacement)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "PlayerBlockPlacement");
		PlayerBlockPlacement inst;
		
		if(numParams == 0)
		{
			inst = new PlayerBlockPlacement();
		}
		
		if(numParams == 7 && TypesMatch!(int, byte, int, byte, short, byte, short)(t))
		{
			// getting parameters
			int x = superGet!(int)(t, 1);
			byte y = superGet!(byte)(t, 2);
			int z = superGet!(int)(t, 3);
			byte direction = superGet!(byte)(t, 4);
			short blockOrItem = superGet!(short)(t, 5);
			byte amount = superGet!(byte)(t, 6);
			short damage = superGet!(short)(t, 7);
			
			inst = new PlayerBlockPlacement(x, y, z, direction, blockOrItem, amount, damage);
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		PlayerBlockPlacement inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword send(CrocThread* t)
	{
		PlayerBlockPlacement inst = getThis(t);
		
		MinecraftDataOutput output = superGet!(MinecraftDataOutput)(t, 1);
		
		//call the function
		inst.send(output);
		return 0;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type PlayerBlockPlacement`, fieldName);
			
			case "z":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_z`, 1);
				break;
			
			case "amount":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_amount`, 1);
				break;
			
			case "itemID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_itemID`, 1);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_x`, 1);
				break;
			
			case "damage":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_damage`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "y":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_y`, 1);
				break;
			
			case "direction":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_direction`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "block":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_block`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type PlayerBlockPlacement`, fieldName);
			
			case "z":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_z`, 0);
				break;
			
			case "amount":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_amount`, 0);
				break;
			
			case "itemID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_itemID`, 0);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_x`, 0);
				break;
			
			case "damage":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_damage`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "y":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_y`, 0);
				break;
			
			case "direction":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_direction`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "block":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_block`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_z(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PlayerBlockPlacement inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.z);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'z' of type 'int'");
	}
	
	uword _prop_amount(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PlayerBlockPlacement inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.amount);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'amount' of type 'byte'");
	}
	
	uword _prop_itemID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PlayerBlockPlacement inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.itemID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'itemID' of type 'short'");
	}
	
	uword _prop_x(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PlayerBlockPlacement inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.x);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'x' of type 'int'");
	}
	
	uword _prop_damage(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PlayerBlockPlacement inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.damage);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'damage' of type 'short'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PlayerBlockPlacement inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_y(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PlayerBlockPlacement inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.y);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'y' of type 'byte'");
	}
	
	uword _prop_direction(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PlayerBlockPlacement inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.direction);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'direction' of type 'byte'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PlayerBlockPlacement inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_block(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PlayerBlockPlacement inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.block);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'block' of type 'short'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "PlayerBlockPlacement", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			c.method("send", &send);
			
			//properties
			c.method("_prop_z", &_prop_z);
			c.method("_prop_amount", &_prop_amount);
			c.method("_prop_itemID", &_prop_itemID);
			c.method("_prop_x", &_prop_x);
			c.method("_prop_damage", &_prop_damage);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_y", &_prop_y);
			c.method("_prop_direction", &_prop_direction);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_block", &_prop_block);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "PlayerBlockPlacement.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(PlayerBlockPlacement));
		newGlobal(t, "PlayerBlockPlacement");
	}
}

struct HoldingChangeObj
{
	static:
	private HoldingChange getThis(CrocThread* t)
	{
		return cast(HoldingChange)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "HoldingChange");
		HoldingChange inst;
		
		if(numParams == 1 && TypesMatch!(short)(t))
		{
			// getting parameters
			short slotID = superGet!(short)(t, 1);
			
			inst = new HoldingChange(slotID);
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword send(CrocThread* t)
	{
		HoldingChange inst = getThis(t);
		
		MinecraftDataOutput output = superGet!(MinecraftDataOutput)(t, 1);
		
		//call the function
		inst.send(output);
		return 0;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type HoldingChange`, fieldName);
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type HoldingChange`, fieldName);
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		HoldingChange inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "HoldingChange", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("send", &send);
			
			//properties
			c.method("_prop_packetID", &_prop_packetID);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "HoldingChange.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(HoldingChange));
		newGlobal(t, "HoldingChange");
	}
}

struct UseBedObj
{
	static:
	private UseBed getThis(CrocThread* t)
	{
		return cast(UseBed)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "UseBed");
		UseBed inst;
		
		if(numParams == 0)
		{
			inst = new UseBed();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		UseBed inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type UseBed`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_EID`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "y":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_y`, 1);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_x`, 1);
				break;
			
			case "z":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_z`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type UseBed`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_EID`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "y":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_y`, 0);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_x`, 0);
				break;
			
			case "z":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_z`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_EID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		UseBed inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.EID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'EID' of type 'int'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		UseBed inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_y(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		UseBed inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.y);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'y' of type 'byte'");
	}
	
	uword _prop_x(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		UseBed inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.x);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'x' of type 'int'");
	}
	
	uword _prop_z(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		UseBed inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.z);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'z' of type 'int'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		UseBed inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "UseBed", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_EID", &_prop_EID);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_y", &_prop_y);
			c.method("_prop_x", &_prop_x);
			c.method("_prop_z", &_prop_z);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "UseBed.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(UseBed));
		newGlobal(t, "UseBed");
	}
}

struct AnimationObj
{
	static:
	private Animation getThis(CrocThread* t)
	{
		return cast(Animation)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "Animation");
		Animation inst;
		
		if(numParams == 2 && TypesMatch!(int, byte)(t))
		{
			// getting parameters
			int EID = superGet!(int)(t, 1);
			byte animate = superGet!(byte)(t, 2);
			
			inst = new Animation(EID, animate);
		}
		
		if(numParams == 0)
		{
			inst = new Animation();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		Animation inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword send(CrocThread* t)
	{
		Animation inst = getThis(t);
		
		MinecraftDataOutput output = superGet!(MinecraftDataOutput)(t, 1);
		
		//call the function
		inst.send(output);
		return 0;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type Animation`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_EID`, 1);
				break;
			
			case "animate":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_animate`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type Animation`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_EID`, 0);
				break;
			
			case "animate":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_animate`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_EID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Animation inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.EID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'EID' of type 'int'");
	}
	
	uword _prop_animate(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Animation inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.animate);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'animate' of type 'byte'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Animation inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Animation inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "Animation", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			c.method("send", &send);
			
			//properties
			c.method("_prop_EID", &_prop_EID);
			c.method("_prop_animate", &_prop_animate);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "Animation.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(Animation));
		newGlobal(t, "Animation");
	}
}

struct EntityActionObj
{
	static:
	private EntityAction getThis(CrocThread* t)
	{
		return cast(EntityAction)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "EntityAction");
		EntityAction inst;
		
		if(numParams == 0)
		{
			inst = new EntityAction();
		}
		
		if(numParams == 2 && TypesMatch!(int, byte)(t))
		{
			// getting parameters
			int EID = superGet!(int)(t, 1);
			byte action = superGet!(byte)(t, 2);
			
			inst = new EntityAction(EID, action);
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword send(CrocThread* t)
	{
		EntityAction inst = getThis(t);
		
		MinecraftDataOutput output = superGet!(MinecraftDataOutput)(t, 1);
		
		//call the function
		inst.send(output);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		EntityAction inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type EntityAction`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_EID`, 1);
				break;
			
			case "action":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_action`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type EntityAction`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_EID`, 0);
				break;
			
			case "action":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_action`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_EID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityAction inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.EID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'EID' of type 'int'");
	}
	
	uword _prop_action(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityAction inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.action);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'action' of type 'byte'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityAction inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityAction inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "EntityAction", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("send", &send);
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_EID", &_prop_EID);
			c.method("_prop_action", &_prop_action);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "EntityAction.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(EntityAction));
		newGlobal(t, "EntityAction");
	}
}

struct NamedEntitySpawnObj
{
	static:
	private NamedEntitySpawn getThis(CrocThread* t)
	{
		return cast(NamedEntitySpawn)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "NamedEntitySpawn");
		NamedEntitySpawn inst;
		
		if(numParams == 0)
		{
			inst = new NamedEntitySpawn();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		NamedEntitySpawn inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type NamedEntitySpawn`, fieldName);
			
			case "z":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_z`, 1);
				break;
			
			case "y":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_y`, 1);
				break;
			
			case "rotation":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_rotation`, 1);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_x`, 1);
				break;
			
			case "currentItem":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_currentItem`, 1);
				break;
			
			case "pitch":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_pitch`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_EID`, 1);
				break;
			
			case "name":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_name`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type NamedEntitySpawn`, fieldName);
			
			case "z":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_z`, 0);
				break;
			
			case "y":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_y`, 0);
				break;
			
			case "rotation":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_rotation`, 0);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_x`, 0);
				break;
			
			case "currentItem":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_currentItem`, 0);
				break;
			
			case "pitch":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_pitch`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_EID`, 0);
				break;
			
			case "name":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_name`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_z(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		NamedEntitySpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.z);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'z' of type 'int'");
	}
	
	uword _prop_y(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		NamedEntitySpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.y);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'y' of type 'int'");
	}
	
	uword _prop_rotation(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		NamedEntitySpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.rotation);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'rotation' of type 'byte'");
	}
	
	uword _prop_x(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		NamedEntitySpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.x);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'x' of type 'int'");
	}
	
	uword _prop_currentItem(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		NamedEntitySpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.currentItem);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'currentItem' of type 'short'");
	}
	
	uword _prop_pitch(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		NamedEntitySpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.pitch);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'pitch' of type 'byte'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		NamedEntitySpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_EID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		NamedEntitySpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.EID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'EID' of type 'int'");
	}
	
	uword _prop_name(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		NamedEntitySpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.name);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'name' of type 'char[]'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		NamedEntitySpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "NamedEntitySpawn", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_z", &_prop_z);
			c.method("_prop_y", &_prop_y);
			c.method("_prop_rotation", &_prop_rotation);
			c.method("_prop_x", &_prop_x);
			c.method("_prop_currentItem", &_prop_currentItem);
			c.method("_prop_pitch", &_prop_pitch);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_EID", &_prop_EID);
			c.method("_prop_name", &_prop_name);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "NamedEntitySpawn.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(NamedEntitySpawn));
		newGlobal(t, "NamedEntitySpawn");
	}
}

struct PickupSpawnObj
{
	static:
	private PickupSpawn getThis(CrocThread* t)
	{
		return cast(PickupSpawn)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "PickupSpawn");
		PickupSpawn inst;
		
		if(numParams == 0)
		{
			inst = new PickupSpawn();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		PickupSpawn inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type PickupSpawn`, fieldName);
			
			case "z":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_z`, 1);
				break;
			
			case "y":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_y`, 1);
				break;
			
			case "itemID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_itemID`, 1);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_x`, 1);
				break;
			
			case "rotation":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_rotation`, 1);
				break;
			
			case "pitch":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_pitch`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "count":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_count`, 1);
				break;
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_EID`, 1);
				break;
			
			case "damage":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_damage`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "roll":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_roll`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type PickupSpawn`, fieldName);
			
			case "z":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_z`, 0);
				break;
			
			case "y":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_y`, 0);
				break;
			
			case "itemID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_itemID`, 0);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_x`, 0);
				break;
			
			case "rotation":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_rotation`, 0);
				break;
			
			case "pitch":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_pitch`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "count":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_count`, 0);
				break;
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_EID`, 0);
				break;
			
			case "damage":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_damage`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "roll":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_roll`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_z(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PickupSpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.z);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'z' of type 'int'");
	}
	
	uword _prop_y(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PickupSpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.y);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'y' of type 'int'");
	}
	
	uword _prop_itemID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PickupSpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.itemID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'itemID' of type 'short'");
	}
	
	uword _prop_x(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PickupSpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.x);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'x' of type 'int'");
	}
	
	uword _prop_rotation(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PickupSpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.rotation);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'rotation' of type 'byte'");
	}
	
	uword _prop_pitch(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PickupSpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.pitch);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'pitch' of type 'byte'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PickupSpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_count(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PickupSpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.count);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'count' of type 'byte'");
	}
	
	uword _prop_EID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PickupSpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.EID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'EID' of type 'int'");
	}
	
	uword _prop_damage(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PickupSpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.damage);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'damage' of type 'short'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PickupSpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_roll(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PickupSpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.roll);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'roll' of type 'byte'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "PickupSpawn", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_z", &_prop_z);
			c.method("_prop_y", &_prop_y);
			c.method("_prop_itemID", &_prop_itemID);
			c.method("_prop_x", &_prop_x);
			c.method("_prop_rotation", &_prop_rotation);
			c.method("_prop_pitch", &_prop_pitch);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_count", &_prop_count);
			c.method("_prop_EID", &_prop_EID);
			c.method("_prop_damage", &_prop_damage);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_roll", &_prop_roll);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "PickupSpawn.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(PickupSpawn));
		newGlobal(t, "PickupSpawn");
	}
}

struct CollectItemObj
{
	static:
	private CollectItem getThis(CrocThread* t)
	{
		return cast(CollectItem)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "CollectItem");
		CollectItem inst;
		
		if(numParams == 0)
		{
			inst = new CollectItem();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		CollectItem inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type CollectItem`, fieldName);
			
			case "collector":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_collector`, 1);
				break;
			
			case "collected":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_collected`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type CollectItem`, fieldName);
			
			case "collector":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_collector`, 0);
				break;
			
			case "collected":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_collected`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_collector(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		CollectItem inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.collector);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'collector' of type 'int'");
	}
	
	uword _prop_collected(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		CollectItem inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.collected);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'collected' of type 'int'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		CollectItem inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		CollectItem inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "CollectItem", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_collector", &_prop_collector);
			c.method("_prop_collected", &_prop_collected);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "CollectItem.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(CollectItem));
		newGlobal(t, "CollectItem");
	}
}

struct AddObjectObj
{
	static:
	private AddObject getThis(CrocThread* t)
	{
		return cast(AddObject)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "AddObject");
		AddObject inst;
		
		if(numParams == 0)
		{
			inst = new AddObject();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		AddObject inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type AddObject`, fieldName);
			
			case "z":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_z`, 1);
				break;
			
			case "tz":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_tz`, 1);
				break;
			
			case "type":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_type`, 1);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_x`, 1);
				break;
			
			case "thrower":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_thrower`, 1);
				break;
			
			case "tx":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_tx`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "y":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_y`, 1);
				break;
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_EID`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "ty":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_ty`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type AddObject`, fieldName);
			
			case "z":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_z`, 0);
				break;
			
			case "tz":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_tz`, 0);
				break;
			
			case "type":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_type`, 0);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_x`, 0);
				break;
			
			case "thrower":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_thrower`, 0);
				break;
			
			case "tx":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_tx`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "y":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_y`, 0);
				break;
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_EID`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "ty":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_ty`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_z(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		AddObject inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.z);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'z' of type 'int'");
	}
	
	uword _prop_tz(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		AddObject inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.tz);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'tz' of type 'short'");
	}
	
	uword _prop_type(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		AddObject inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.type);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'type' of type 'byte'");
	}
	
	uword _prop_x(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		AddObject inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.x);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'x' of type 'int'");
	}
	
	uword _prop_thrower(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		AddObject inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.thrower);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'thrower' of type 'int'");
	}
	
	uword _prop_tx(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		AddObject inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.tx);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'tx' of type 'short'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		AddObject inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_y(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		AddObject inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.y);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'y' of type 'int'");
	}
	
	uword _prop_EID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		AddObject inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.EID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'EID' of type 'int'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		AddObject inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_ty(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		AddObject inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.ty);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'ty' of type 'short'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "AddObject", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_z", &_prop_z);
			c.method("_prop_tz", &_prop_tz);
			c.method("_prop_type", &_prop_type);
			c.method("_prop_x", &_prop_x);
			c.method("_prop_thrower", &_prop_thrower);
			c.method("_prop_tx", &_prop_tx);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_y", &_prop_y);
			c.method("_prop_EID", &_prop_EID);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_ty", &_prop_ty);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "AddObject.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(AddObject));
		newGlobal(t, "AddObject");
	}
}

struct MobSpawnObj
{
	static:
	private MobSpawn getThis(CrocThread* t)
	{
		return cast(MobSpawn)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "MobSpawn");
		MobSpawn inst;
		
		if(numParams == 0)
		{
			inst = new MobSpawn();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		MobSpawn inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type MobSpawn`, fieldName);
			
			case "z":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_z`, 1);
				break;
			
			case "y":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_y`, 1);
				break;
			
			case "type":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_type`, 1);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_x`, 1);
				break;
			
			case "metadata":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_metadata`, 1);
				break;
			
			case "pitch":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_pitch`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_EID`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "yaw":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_yaw`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type MobSpawn`, fieldName);
			
			case "z":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_z`, 0);
				break;
			
			case "y":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_y`, 0);
				break;
			
			case "type":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_type`, 0);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_x`, 0);
				break;
			
			case "metadata":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_metadata`, 0);
				break;
			
			case "pitch":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_pitch`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_EID`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "yaw":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_yaw`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_z(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		MobSpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.z);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'z' of type 'int'");
	}
	
	uword _prop_y(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		MobSpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.y);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'y' of type 'int'");
	}
	
	uword _prop_type(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		MobSpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.type);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'type' of type 'byte'");
	}
	
	uword _prop_x(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		MobSpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.x);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'x' of type 'int'");
	}
	
	uword _prop_metadata(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		MobSpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.metadata);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'metadata' of type 'Metadata[]'");
	}
	
	uword _prop_pitch(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		MobSpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.pitch);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'pitch' of type 'byte'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		MobSpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_EID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		MobSpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.EID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'EID' of type 'int'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		MobSpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_yaw(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		MobSpawn inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.yaw);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'yaw' of type 'byte'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "MobSpawn", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_z", &_prop_z);
			c.method("_prop_y", &_prop_y);
			c.method("_prop_type", &_prop_type);
			c.method("_prop_x", &_prop_x);
			c.method("_prop_metadata", &_prop_metadata);
			c.method("_prop_pitch", &_prop_pitch);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_EID", &_prop_EID);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_yaw", &_prop_yaw);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "MobSpawn.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(MobSpawn));
		newGlobal(t, "MobSpawn");
	}
}

struct EntityPaintingObj
{
	static:
	private EntityPainting getThis(CrocThread* t)
	{
		return cast(EntityPainting)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "EntityPainting");
		EntityPainting inst;
		
		if(numParams == 0)
		{
			inst = new EntityPainting();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		EntityPainting inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type EntityPainting`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_EID`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "title":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_title`, 1);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_x`, 1);
				break;
			
			case "z":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_z`, 1);
				break;
			
			case "type":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_type`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "y":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_y`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type EntityPainting`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_EID`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "title":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_title`, 0);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_x`, 0);
				break;
			
			case "z":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_z`, 0);
				break;
			
			case "type":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_type`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "y":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_y`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_EID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityPainting inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.EID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'EID' of type 'int'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityPainting inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_title(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityPainting inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.title);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'title' of type 'char[]'");
	}
	
	uword _prop_x(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityPainting inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.x);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'x' of type 'int'");
	}
	
	uword _prop_z(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityPainting inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.z);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'z' of type 'int'");
	}
	
	uword _prop_type(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityPainting inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.type);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'type' of type 'int'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityPainting inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_y(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityPainting inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.y);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'y' of type 'int'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "EntityPainting", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_EID", &_prop_EID);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_title", &_prop_title);
			c.method("_prop_x", &_prop_x);
			c.method("_prop_z", &_prop_z);
			c.method("_prop_type", &_prop_type);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_y", &_prop_y);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "EntityPainting.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(EntityPainting));
		newGlobal(t, "EntityPainting");
	}
}

struct ExperienceOrbObj
{
	static:
	private ExperienceOrb getThis(CrocThread* t)
	{
		return cast(ExperienceOrb)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "ExperienceOrb");
		ExperienceOrb inst;
		
		if(numParams == 0)
		{
			inst = new ExperienceOrb();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		ExperienceOrb inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type ExperienceOrb`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_EID`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "y":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_y`, 1);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_x`, 1);
				break;
			
			case "z":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_z`, 1);
				break;
			
			case "count":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_count`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type ExperienceOrb`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_EID`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "y":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_y`, 0);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_x`, 0);
				break;
			
			case "z":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_z`, 0);
				break;
			
			case "count":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_count`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_EID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		ExperienceOrb inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.EID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'EID' of type 'int'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		ExperienceOrb inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_y(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		ExperienceOrb inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.y);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'y' of type 'int'");
	}
	
	uword _prop_x(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		ExperienceOrb inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.x);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'x' of type 'int'");
	}
	
	uword _prop_z(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		ExperienceOrb inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.z);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'z' of type 'int'");
	}
	
	uword _prop_count(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		ExperienceOrb inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.count);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'count' of type 'short'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		ExperienceOrb inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "ExperienceOrb", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_EID", &_prop_EID);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_y", &_prop_y);
			c.method("_prop_x", &_prop_x);
			c.method("_prop_z", &_prop_z);
			c.method("_prop_count", &_prop_count);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "ExperienceOrb.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(ExperienceOrb));
		newGlobal(t, "ExperienceOrb");
	}
}

struct UnknownObj
{
	static:
	private Unknown getThis(CrocThread* t)
	{
		return cast(Unknown)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "Unknown");
		Unknown inst;
		
		if(numParams == 0)
		{
			inst = new Unknown();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		Unknown inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type Unknown`, fieldName);
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type Unknown`, fieldName);
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Unknown inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Unknown inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "Unknown", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "Unknown.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(Unknown));
		newGlobal(t, "Unknown");
	}
}

struct EntityVelocityObj
{
	static:
	private EntityVelocity getThis(CrocThread* t)
	{
		return cast(EntityVelocity)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "EntityVelocity");
		EntityVelocity inst;
		
		if(numParams == 0)
		{
			inst = new EntityVelocity();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		EntityVelocity inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type EntityVelocity`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_EID`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "y":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_y`, 1);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_x`, 1);
				break;
			
			case "z":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_z`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type EntityVelocity`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_EID`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "y":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_y`, 0);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_x`, 0);
				break;
			
			case "z":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_z`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_EID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityVelocity inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.EID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'EID' of type 'int'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityVelocity inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_y(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityVelocity inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.y);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'y' of type 'short'");
	}
	
	uword _prop_x(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityVelocity inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.x);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'x' of type 'short'");
	}
	
	uword _prop_z(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityVelocity inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.z);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'z' of type 'short'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityVelocity inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "EntityVelocity", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_EID", &_prop_EID);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_y", &_prop_y);
			c.method("_prop_x", &_prop_x);
			c.method("_prop_z", &_prop_z);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "EntityVelocity.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(EntityVelocity));
		newGlobal(t, "EntityVelocity");
	}
}

struct DestroyEntityObj
{
	static:
	private DestroyEntity getThis(CrocThread* t)
	{
		return cast(DestroyEntity)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "DestroyEntity");
		DestroyEntity inst;
		
		if(numParams == 0)
		{
			inst = new DestroyEntity();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		DestroyEntity inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type DestroyEntity`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_EID`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type DestroyEntity`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_EID`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_EID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		DestroyEntity inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.EID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'EID' of type 'int'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		DestroyEntity inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		DestroyEntity inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "DestroyEntity", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_EID", &_prop_EID);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "DestroyEntity.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(DestroyEntity));
		newGlobal(t, "DestroyEntity");
	}
}

struct EntityObj
{
	static:
	private Entity getThis(CrocThread* t)
	{
		return cast(Entity)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "Entity");
		Entity inst;
		
		if(numParams == 0)
		{
			inst = new Entity();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		Entity inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type Entity`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_EID`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type Entity`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_EID`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_EID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Entity inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.EID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'EID' of type 'int'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Entity inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Entity inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "Entity", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_EID", &_prop_EID);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "Entity.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(Entity));
		newGlobal(t, "Entity");
	}
}

struct EntityRelativeMoveObj
{
	static:
	private EntityRelativeMove getThis(CrocThread* t)
	{
		return cast(EntityRelativeMove)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "EntityRelativeMove");
		EntityRelativeMove inst;
		
		if(numParams == 0)
		{
			inst = new EntityRelativeMove();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		EntityRelativeMove inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type EntityRelativeMove`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_EID`, 1);
				break;
			
			case "dY":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_dY`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "dX":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_dX`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "dZ":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_dZ`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type EntityRelativeMove`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_EID`, 0);
				break;
			
			case "dY":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_dY`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "dX":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_dX`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "dZ":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_dZ`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_EID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityRelativeMove inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.EID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'EID' of type 'int'");
	}
	
	uword _prop_dY(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityRelativeMove inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.dY);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'dY' of type 'byte'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityRelativeMove inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_dX(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityRelativeMove inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.dX);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'dX' of type 'byte'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityRelativeMove inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_dZ(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityRelativeMove inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.dZ);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'dZ' of type 'byte'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "EntityRelativeMove", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_EID", &_prop_EID);
			c.method("_prop_dY", &_prop_dY);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_dX", &_prop_dX);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_dZ", &_prop_dZ);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "EntityRelativeMove.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(EntityRelativeMove));
		newGlobal(t, "EntityRelativeMove");
	}
}

struct EntityLookObj
{
	static:
	private EntityLook getThis(CrocThread* t)
	{
		return cast(EntityLook)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "EntityLook");
		EntityLook inst;
		
		if(numParams == 0)
		{
			inst = new EntityLook();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		EntityLook inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type EntityLook`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_EID`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "pitch":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_pitch`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "yaw":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_yaw`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type EntityLook`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_EID`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "pitch":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_pitch`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "yaw":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_yaw`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_EID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityLook inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.EID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'EID' of type 'int'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityLook inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_pitch(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityLook inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.pitch);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'pitch' of type 'byte'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityLook inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_yaw(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityLook inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.yaw);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'yaw' of type 'byte'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "EntityLook", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_EID", &_prop_EID);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_pitch", &_prop_pitch);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_yaw", &_prop_yaw);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "EntityLook.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(EntityLook));
		newGlobal(t, "EntityLook");
	}
}

struct EntityLookRelativeMoveObj
{
	static:
	private EntityLookRelativeMove getThis(CrocThread* t)
	{
		return cast(EntityLookRelativeMove)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "EntityLookRelativeMove");
		EntityLookRelativeMove inst;
		
		if(numParams == 0)
		{
			inst = new EntityLookRelativeMove();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		EntityLookRelativeMove inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type EntityLookRelativeMove`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_EID`, 1);
				break;
			
			case "dY":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_dY`, 1);
				break;
			
			case "yaw":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_yaw`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "pitch":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_pitch`, 1);
				break;
			
			case "dX":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_dX`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "dZ":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_dZ`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type EntityLookRelativeMove`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_EID`, 0);
				break;
			
			case "dY":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_dY`, 0);
				break;
			
			case "yaw":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_yaw`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "pitch":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_pitch`, 0);
				break;
			
			case "dX":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_dX`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "dZ":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_dZ`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_EID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityLookRelativeMove inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.EID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'EID' of type 'int'");
	}
	
	uword _prop_dY(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityLookRelativeMove inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.dY);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'dY' of type 'byte'");
	}
	
	uword _prop_yaw(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityLookRelativeMove inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.yaw);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'yaw' of type 'byte'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityLookRelativeMove inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_pitch(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityLookRelativeMove inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.pitch);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'pitch' of type 'byte'");
	}
	
	uword _prop_dX(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityLookRelativeMove inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.dX);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'dX' of type 'byte'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityLookRelativeMove inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_dZ(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityLookRelativeMove inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.dZ);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'dZ' of type 'byte'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "EntityLookRelativeMove", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_EID", &_prop_EID);
			c.method("_prop_dY", &_prop_dY);
			c.method("_prop_yaw", &_prop_yaw);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_pitch", &_prop_pitch);
			c.method("_prop_dX", &_prop_dX);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_dZ", &_prop_dZ);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "EntityLookRelativeMove.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(EntityLookRelativeMove));
		newGlobal(t, "EntityLookRelativeMove");
	}
}

struct EntityTeleportObj
{
	static:
	private EntityTeleport getThis(CrocThread* t)
	{
		return cast(EntityTeleport)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "EntityTeleport");
		EntityTeleport inst;
		
		if(numParams == 0)
		{
			inst = new EntityTeleport();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		EntityTeleport inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type EntityTeleport`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_EID`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "y":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_y`, 1);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_x`, 1);
				break;
			
			case "z":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_z`, 1);
				break;
			
			case "pitch":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_pitch`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "yaw":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_yaw`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type EntityTeleport`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_EID`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "y":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_y`, 0);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_x`, 0);
				break;
			
			case "z":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_z`, 0);
				break;
			
			case "pitch":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_pitch`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "yaw":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_yaw`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_EID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityTeleport inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.EID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'EID' of type 'int'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityTeleport inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_y(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityTeleport inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.y);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'y' of type 'int'");
	}
	
	uword _prop_x(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityTeleport inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.x);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'x' of type 'int'");
	}
	
	uword _prop_z(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityTeleport inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.z);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'z' of type 'int'");
	}
	
	uword _prop_pitch(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityTeleport inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.pitch);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'pitch' of type 'byte'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityTeleport inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_yaw(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityTeleport inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.yaw);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'yaw' of type 'byte'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "EntityTeleport", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_EID", &_prop_EID);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_y", &_prop_y);
			c.method("_prop_x", &_prop_x);
			c.method("_prop_z", &_prop_z);
			c.method("_prop_pitch", &_prop_pitch);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_yaw", &_prop_yaw);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "EntityTeleport.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(EntityTeleport));
		newGlobal(t, "EntityTeleport");
	}
}

struct EntityStatusObj
{
	static:
	private EntityStatus getThis(CrocThread* t)
	{
		return cast(EntityStatus)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "EntityStatus");
		EntityStatus inst;
		
		if(numParams == 0)
		{
			inst = new EntityStatus();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		EntityStatus inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type EntityStatus`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_EID`, 1);
				break;
			
			case "status":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_status`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type EntityStatus`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_EID`, 0);
				break;
			
			case "status":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_status`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_EID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityStatus inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.EID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'EID' of type 'int'");
	}
	
	uword _prop_status(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityStatus inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.status);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'status' of type 'byte'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityStatus inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityStatus inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "EntityStatus", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_EID", &_prop_EID);
			c.method("_prop_status", &_prop_status);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "EntityStatus.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(EntityStatus));
		newGlobal(t, "EntityStatus");
	}
}

struct AttachEntityObj
{
	static:
	private AttachEntity getThis(CrocThread* t)
	{
		return cast(AttachEntity)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "AttachEntity");
		AttachEntity inst;
		
		if(numParams == 0)
		{
			inst = new AttachEntity();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		AttachEntity inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type AttachEntity`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_EID`, 1);
				break;
			
			case "vehicle":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_vehicle`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type AttachEntity`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_EID`, 0);
				break;
			
			case "vehicle":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_vehicle`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_EID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		AttachEntity inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.EID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'EID' of type 'int'");
	}
	
	uword _prop_vehicle(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		AttachEntity inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.vehicle);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'vehicle' of type 'int'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		AttachEntity inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		AttachEntity inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "AttachEntity", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_EID", &_prop_EID);
			c.method("_prop_vehicle", &_prop_vehicle);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "AttachEntity.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(AttachEntity));
		newGlobal(t, "AttachEntity");
	}
}

struct EntityMetadataObj
{
	static:
	private EntityMetadata getThis(CrocThread* t)
	{
		return cast(EntityMetadata)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "EntityMetadata");
		EntityMetadata inst;
		
		if(numParams == 0)
		{
			inst = new EntityMetadata();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		EntityMetadata inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type EntityMetadata`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_EID`, 1);
				break;
			
			case "metadata":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_metadata`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type EntityMetadata`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_EID`, 0);
				break;
			
			case "metadata":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_metadata`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_EID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityMetadata inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.EID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'EID' of type 'int'");
	}
	
	uword _prop_metadata(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityMetadata inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.metadata);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'metadata' of type 'Metadata[]'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityMetadata inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityMetadata inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "EntityMetadata", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_EID", &_prop_EID);
			c.method("_prop_metadata", &_prop_metadata);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "EntityMetadata.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(EntityMetadata));
		newGlobal(t, "EntityMetadata");
	}
}

struct EntityEffectObj
{
	static:
	private EntityEffect getThis(CrocThread* t)
	{
		return cast(EntityEffect)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "EntityEffect");
		EntityEffect inst;
		
		if(numParams == 0)
		{
			inst = new EntityEffect();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		EntityEffect inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type EntityEffect`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_EID`, 1);
				break;
			
			case "amplifier":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_amplifier`, 1);
				break;
			
			case "duration":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_duration`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "effect":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_effect`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type EntityEffect`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_EID`, 0);
				break;
			
			case "amplifier":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_amplifier`, 0);
				break;
			
			case "duration":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_duration`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "effect":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_effect`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_EID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityEffect inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.EID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'EID' of type 'int'");
	}
	
	uword _prop_amplifier(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityEffect inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.amplifier);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'amplifier' of type 'byte'");
	}
	
	uword _prop_duration(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityEffect inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.duration);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'duration' of type 'short'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityEffect inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_effect(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityEffect inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.effect);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'effect' of type 'byte'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		EntityEffect inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "EntityEffect", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_EID", &_prop_EID);
			c.method("_prop_amplifier", &_prop_amplifier);
			c.method("_prop_duration", &_prop_duration);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_effect", &_prop_effect);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "EntityEffect.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(EntityEffect));
		newGlobal(t, "EntityEffect");
	}
}

struct RemoveEntityEffectObj
{
	static:
	private RemoveEntityEffect getThis(CrocThread* t)
	{
		return cast(RemoveEntityEffect)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "RemoveEntityEffect");
		RemoveEntityEffect inst;
		
		if(numParams == 0)
		{
			inst = new RemoveEntityEffect();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		RemoveEntityEffect inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type RemoveEntityEffect`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_EID`, 1);
				break;
			
			case "effect":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_effect`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type RemoveEntityEffect`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_EID`, 0);
				break;
			
			case "effect":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_effect`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_EID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		RemoveEntityEffect inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.EID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'EID' of type 'int'");
	}
	
	uword _prop_effect(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		RemoveEntityEffect inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.effect);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'effect' of type 'byte'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		RemoveEntityEffect inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		RemoveEntityEffect inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "RemoveEntityEffect", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_EID", &_prop_EID);
			c.method("_prop_effect", &_prop_effect);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "RemoveEntityEffect.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(RemoveEntityEffect));
		newGlobal(t, "RemoveEntityEffect");
	}
}

struct ExperienceObj
{
	static:
	private Experience getThis(CrocThread* t)
	{
		return cast(Experience)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "Experience");
		Experience inst;
		
		if(numParams == 0)
		{
			inst = new Experience();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		Experience inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type Experience`, fieldName);
			
			case "level":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_level`, 1);
				break;
			
			case "total":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_total`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "current":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_current`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type Experience`, fieldName);
			
			case "level":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_level`, 0);
				break;
			
			case "total":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_total`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "current":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_current`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_level(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Experience inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.level);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'level' of type 'byte'");
	}
	
	uword _prop_total(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Experience inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.total);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'total' of type 'short'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Experience inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Experience inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_current(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Experience inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.current);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'current' of type 'byte'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "Experience", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_level", &_prop_level);
			c.method("_prop_total", &_prop_total);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_current", &_prop_current);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "Experience.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(Experience));
		newGlobal(t, "Experience");
	}
}

struct PreChunkObj
{
	static:
	private PreChunk getThis(CrocThread* t)
	{
		return cast(PreChunk)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "PreChunk");
		PreChunk inst;
		
		if(numParams == 0)
		{
			inst = new PreChunk();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		PreChunk inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type PreChunk`, fieldName);
			
			case "y":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_y`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "mode":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_mode`, 1);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_x`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type PreChunk`, fieldName);
			
			case "y":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_y`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "mode":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_mode`, 0);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_x`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_y(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PreChunk inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.y);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'y' of type 'int'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PreChunk inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_mode(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PreChunk inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.mode);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'mode' of type 'bool'");
	}
	
	uword _prop_x(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PreChunk inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.x);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'x' of type 'int'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PreChunk inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "PreChunk", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_y", &_prop_y);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_mode", &_prop_mode);
			c.method("_prop_x", &_prop_x);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "PreChunk.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(PreChunk));
		newGlobal(t, "PreChunk");
	}
}

struct MapChunkObj
{
	static:
	private MapChunk getThis(CrocThread* t)
	{
		return cast(MapChunk)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "MapChunk");
		MapChunk inst;
		
		if(numParams == 0)
		{
			inst = new MapChunk();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		MapChunk inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type MapChunk`, fieldName);
			
			case "z":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_z`, 1);
				break;
			
			case "sizeX":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_sizeX`, 1);
				break;
			
			case "sizeY":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_sizeY`, 1);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_x`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "y":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_y`, 1);
				break;
			
			case "data":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_data`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "size":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_size`, 1);
				break;
			
			case "sizeZ":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_sizeZ`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type MapChunk`, fieldName);
			
			case "z":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_z`, 0);
				break;
			
			case "sizeX":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_sizeX`, 0);
				break;
			
			case "sizeY":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_sizeY`, 0);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_x`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "y":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_y`, 0);
				break;
			
			case "data":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_data`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "size":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_size`, 0);
				break;
			
			case "sizeZ":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_sizeZ`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_z(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		MapChunk inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.z);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'z' of type 'int'");
	}
	
	uword _prop_sizeX(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		MapChunk inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.sizeX);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'sizeX' of type 'ubyte'");
	}
	
	uword _prop_sizeY(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		MapChunk inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.sizeY);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'sizeY' of type 'ubyte'");
	}
	
	uword _prop_x(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		MapChunk inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.x);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'x' of type 'int'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		MapChunk inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_y(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		MapChunk inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.y);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'y' of type 'short'");
	}
	
	uword _prop_data(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		MapChunk inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.data);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'data' of type 'byte[]'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		MapChunk inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_size(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		MapChunk inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.size);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'size' of type 'int'");
	}
	
	uword _prop_sizeZ(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		MapChunk inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.sizeZ);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'sizeZ' of type 'ubyte'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "MapChunk", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_z", &_prop_z);
			c.method("_prop_sizeX", &_prop_sizeX);
			c.method("_prop_sizeY", &_prop_sizeY);
			c.method("_prop_x", &_prop_x);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_y", &_prop_y);
			c.method("_prop_data", &_prop_data);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_size", &_prop_size);
			c.method("_prop_sizeZ", &_prop_sizeZ);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "MapChunk.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(MapChunk));
		newGlobal(t, "MapChunk");
	}
}

struct MultiBlockChangeObj
{
	static:
	private MultiBlockChange getThis(CrocThread* t)
	{
		return cast(MultiBlockChange)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "MultiBlockChange");
		MultiBlockChange inst;
		
		if(numParams == 0)
		{
			inst = new MultiBlockChange();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		MultiBlockChange inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type MultiBlockChange`, fieldName);
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "length":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_length`, 1);
				break;
			
			case "coordinates":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_coordinates`, 1);
				break;
			
			case "types":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_types`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "metadata":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_metadata`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type MultiBlockChange`, fieldName);
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "length":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_length`, 0);
				break;
			
			case "coordinates":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_coordinates`, 0);
				break;
			
			case "types":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_types`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "metadata":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_metadata`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		MultiBlockChange inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_length(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		MultiBlockChange inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.length);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'length' of type 'short'");
	}
	
	uword _prop_coordinates(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		MultiBlockChange inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.coordinates);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'coordinates' of type 'short[]'");
	}
	
	uword _prop_types(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		MultiBlockChange inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.types);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'types' of type 'byte[]'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		MultiBlockChange inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_metadata(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		MultiBlockChange inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.metadata);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'metadata' of type 'byte[]'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "MultiBlockChange", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_length", &_prop_length);
			c.method("_prop_coordinates", &_prop_coordinates);
			c.method("_prop_types", &_prop_types);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_metadata", &_prop_metadata);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "MultiBlockChange.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(MultiBlockChange));
		newGlobal(t, "MultiBlockChange");
	}
}

struct BlockChangeObj
{
	static:
	private BlockChange getThis(CrocThread* t)
	{
		return cast(BlockChange)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "BlockChange");
		BlockChange inst;
		
		if(numParams == 0)
		{
			inst = new BlockChange();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		BlockChange inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type BlockChange`, fieldName);
			
			case "y":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_y`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "z":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_z`, 1);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_x`, 1);
				break;
			
			case "type":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_type`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "metadata":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_metadata`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type BlockChange`, fieldName);
			
			case "y":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_y`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "z":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_z`, 0);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_x`, 0);
				break;
			
			case "type":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_type`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "metadata":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_metadata`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_y(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		BlockChange inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.y);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'y' of type 'byte'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		BlockChange inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_z(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		BlockChange inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.z);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'z' of type 'int'");
	}
	
	uword _prop_x(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		BlockChange inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.x);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'x' of type 'int'");
	}
	
	uword _prop_type(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		BlockChange inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.type);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'type' of type 'byte'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		BlockChange inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_metadata(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		BlockChange inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.metadata);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'metadata' of type 'byte'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "BlockChange", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_y", &_prop_y);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_z", &_prop_z);
			c.method("_prop_x", &_prop_x);
			c.method("_prop_type", &_prop_type);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_metadata", &_prop_metadata);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "BlockChange.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(BlockChange));
		newGlobal(t, "BlockChange");
	}
}

struct BlockActionObj
{
	static:
	private BlockAction getThis(CrocThread* t)
	{
		return cast(BlockAction)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "BlockAction");
		BlockAction inst;
		
		if(numParams == 0)
		{
			inst = new BlockAction();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		BlockAction inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type BlockAction`, fieldName);
			
			case "y":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_y`, 1);
				break;
			
			case "arg1":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_arg1`, 1);
				break;
			
			case "arg2":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_arg2`, 1);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_x`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "z":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_z`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type BlockAction`, fieldName);
			
			case "y":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_y`, 0);
				break;
			
			case "arg1":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_arg1`, 0);
				break;
			
			case "arg2":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_arg2`, 0);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_x`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "z":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_z`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_y(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		BlockAction inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.y);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'y' of type 'short'");
	}
	
	uword _prop_arg1(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		BlockAction inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.arg1);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'arg1' of type 'byte'");
	}
	
	uword _prop_arg2(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		BlockAction inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.arg2);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'arg2' of type 'byte'");
	}
	
	uword _prop_x(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		BlockAction inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.x);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'x' of type 'int'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		BlockAction inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_z(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		BlockAction inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.z);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'z' of type 'int'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		BlockAction inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "BlockAction", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_y", &_prop_y);
			c.method("_prop_arg1", &_prop_arg1);
			c.method("_prop_arg2", &_prop_arg2);
			c.method("_prop_x", &_prop_x);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_z", &_prop_z);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "BlockAction.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(BlockAction));
		newGlobal(t, "BlockAction");
	}
}

struct ExplosionObj
{
	static:
	private Explosion getThis(CrocThread* t)
	{
		return cast(Explosion)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "Explosion");
		Explosion inst;
		
		if(numParams == 0)
		{
			inst = new Explosion();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		Explosion inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type Explosion`, fieldName);
			
			case "y":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_y`, 1);
				break;
			
			case "records":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_records`, 1);
				break;
			
			case "z":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_z`, 1);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_x`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "recordCount":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_recordCount`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type Explosion`, fieldName);
			
			case "y":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_y`, 0);
				break;
			
			case "records":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_records`, 0);
				break;
			
			case "z":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_z`, 0);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_x`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "recordCount":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_recordCount`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_y(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Explosion inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.y);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'y' of type 'double'");
	}
	
	uword _prop_records(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Explosion inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.records);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'records' of type 'Record[]'");
	}
	
	uword _prop_z(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Explosion inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.z);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'z' of type 'double'");
	}
	
	uword _prop_x(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Explosion inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.x);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'x' of type 'double'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Explosion inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Explosion inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_recordCount(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Explosion inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.recordCount);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'recordCount' of type 'int'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "Explosion", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_y", &_prop_y);
			c.method("_prop_records", &_prop_records);
			c.method("_prop_z", &_prop_z);
			c.method("_prop_x", &_prop_x);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_recordCount", &_prop_recordCount);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "Explosion.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(Explosion));
		newGlobal(t, "Explosion");
	}
}

struct SoundEffectObj
{
	static:
	private SoundEffect getThis(CrocThread* t)
	{
		return cast(SoundEffect)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "SoundEffect");
		SoundEffect inst;
		
		if(numParams == 0)
		{
			inst = new SoundEffect();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		SoundEffect inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type SoundEffect`, fieldName);
			
			case "y":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_y`, 1);
				break;
			
			case "data":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_data`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_x`, 1);
				break;
			
			case "z":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_z`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "id":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_id`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type SoundEffect`, fieldName);
			
			case "y":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_y`, 0);
				break;
			
			case "data":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_data`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_x`, 0);
				break;
			
			case "z":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_z`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "id":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_id`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_y(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		SoundEffect inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.y);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'y' of type 'byte'");
	}
	
	uword _prop_data(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		SoundEffect inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.data);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'data' of type 'int'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		SoundEffect inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_x(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		SoundEffect inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.x);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'x' of type 'int'");
	}
	
	uword _prop_z(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		SoundEffect inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.z);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'z' of type 'int'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		SoundEffect inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_id(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		SoundEffect inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.id);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'id' of type 'int'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "SoundEffect", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_y", &_prop_y);
			c.method("_prop_data", &_prop_data);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_x", &_prop_x);
			c.method("_prop_z", &_prop_z);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_id", &_prop_id);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "SoundEffect.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(SoundEffect));
		newGlobal(t, "SoundEffect");
	}
}

struct NewStateObj
{
	static:
	private NewState getThis(CrocThread* t)
	{
		return cast(NewState)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "NewState");
		NewState inst;
		
		if(numParams == 0)
		{
			inst = new NewState();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		NewState inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type NewState`, fieldName);
			
			case "reason":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_reason`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type NewState`, fieldName);
			
			case "reason":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_reason`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_reason(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		NewState inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.reason);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'reason' of type 'byte'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		NewState inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		NewState inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "NewState", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_reason", &_prop_reason);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "NewState.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(NewState));
		newGlobal(t, "NewState");
	}
}

struct ThunderboltObj
{
	static:
	private Thunderbolt getThis(CrocThread* t)
	{
		return cast(Thunderbolt)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "Thunderbolt");
		Thunderbolt inst;
		
		if(numParams == 0)
		{
			inst = new Thunderbolt();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		Thunderbolt inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type Thunderbolt`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_EID`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "y":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_y`, 1);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_x`, 1);
				break;
			
			case "z":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_z`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type Thunderbolt`, fieldName);
			
			case "EID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_EID`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "y":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_y`, 0);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_x`, 0);
				break;
			
			case "z":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_z`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_EID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Thunderbolt inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.EID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'EID' of type 'int'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Thunderbolt inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_y(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Thunderbolt inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.y);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'y' of type 'int'");
	}
	
	uword _prop_x(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Thunderbolt inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.x);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'x' of type 'int'");
	}
	
	uword _prop_z(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Thunderbolt inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.z);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'z' of type 'int'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Thunderbolt inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "Thunderbolt", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_EID", &_prop_EID);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_y", &_prop_y);
			c.method("_prop_x", &_prop_x);
			c.method("_prop_z", &_prop_z);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "Thunderbolt.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(Thunderbolt));
		newGlobal(t, "Thunderbolt");
	}
}

struct OpenWindowObj
{
	static:
	private OpenWindow getThis(CrocThread* t)
	{
		return cast(OpenWindow)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "OpenWindow");
		OpenWindow inst;
		
		if(numParams == 0)
		{
			inst = new OpenWindow();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		OpenWindow inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type OpenWindow`, fieldName);
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "title":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_title`, 1);
				break;
			
			case "type":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_type`, 1);
				break;
			
			case "slots":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_slots`, 1);
				break;
			
			case "id":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_id`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type OpenWindow`, fieldName);
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "title":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_title`, 0);
				break;
			
			case "type":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_type`, 0);
				break;
			
			case "slots":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_slots`, 0);
				break;
			
			case "id":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_id`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		OpenWindow inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		OpenWindow inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_title(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		OpenWindow inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.title);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'title' of type 'char[]'");
	}
	
	uword _prop_type(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		OpenWindow inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.type);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'type' of type 'byte'");
	}
	
	uword _prop_slots(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		OpenWindow inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.slots);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'slots' of type 'byte'");
	}
	
	uword _prop_id(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		OpenWindow inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.id);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'id' of type 'byte'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "OpenWindow", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_title", &_prop_title);
			c.method("_prop_type", &_prop_type);
			c.method("_prop_slots", &_prop_slots);
			c.method("_prop_id", &_prop_id);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "OpenWindow.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(OpenWindow));
		newGlobal(t, "OpenWindow");
	}
}

struct CloseWindowObj
{
	static:
	private CloseWindow getThis(CrocThread* t)
	{
		return cast(CloseWindow)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "CloseWindow");
		CloseWindow inst;
		
		if(numParams == 1 && TypesMatch!(byte)(t))
		{
			// getting parameters
			byte id = superGet!(byte)(t, 1);
			
			inst = new CloseWindow(id);
		}
		
		if(numParams == 0)
		{
			inst = new CloseWindow();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		CloseWindow inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword send(CrocThread* t)
	{
		CloseWindow inst = getThis(t);
		
		MinecraftDataOutput output = superGet!(MinecraftDataOutput)(t, 1);
		
		//call the function
		inst.send(output);
		return 0;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type CloseWindow`, fieldName);
			
			case "id":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_id`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type CloseWindow`, fieldName);
			
			case "id":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_id`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_id(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		CloseWindow inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.id);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'id' of type 'byte'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		CloseWindow inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		CloseWindow inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "CloseWindow", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			c.method("send", &send);
			
			//properties
			c.method("_prop_id", &_prop_id);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "CloseWindow.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(CloseWindow));
		newGlobal(t, "CloseWindow");
	}
}

struct WindowClickObj
{
	static:
	private WindowClick getThis(CrocThread* t)
	{
		return cast(WindowClick)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "WindowClick");
		WindowClick inst;
		
		if(numParams == 7 && TypesMatch!(byte, short, byte, short, short, byte, short)(t))
		{
			// getting parameters
			byte id = superGet!(byte)(t, 1);
			short slot = superGet!(short)(t, 2);
			byte rightClick = superGet!(byte)(t, 3);
			short transactionID = superGet!(short)(t, 4);
			short itemID = superGet!(short)(t, 5);
			byte count = superGet!(byte)(t, 6);
			short uses = superGet!(short)(t, 7);
			
			inst = new WindowClick(id, slot, rightClick, transactionID, itemID, count, uses);
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword send(CrocThread* t)
	{
		WindowClick inst = getThis(t);
		
		MinecraftDataOutput output = superGet!(MinecraftDataOutput)(t, 1);
		
		//call the function
		inst.send(output);
		return 0;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type WindowClick`, fieldName);
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type WindowClick`, fieldName);
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		WindowClick inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "WindowClick", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("send", &send);
			
			//properties
			c.method("_prop_packetID", &_prop_packetID);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "WindowClick.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(WindowClick));
		newGlobal(t, "WindowClick");
	}
}

struct SetSlotObj
{
	static:
	private SetSlot getThis(CrocThread* t)
	{
		return cast(SetSlot)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "SetSlot");
		SetSlot inst;
		
		if(numParams == 0)
		{
			inst = new SetSlot();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		SetSlot inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type SetSlot`, fieldName);
			
			case "count":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_count`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "itemID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_itemID`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "slot":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_slot`, 1);
				break;
			
			case "uses":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_uses`, 1);
				break;
			
			case "id":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_id`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type SetSlot`, fieldName);
			
			case "count":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_count`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "itemID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_itemID`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "slot":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_slot`, 0);
				break;
			
			case "uses":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_uses`, 0);
				break;
			
			case "id":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_id`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_count(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		SetSlot inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.count);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'count' of type 'byte'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		SetSlot inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_itemID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		SetSlot inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.itemID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'itemID' of type 'short'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		SetSlot inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_slot(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		SetSlot inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.slot);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'slot' of type 'short'");
	}
	
	uword _prop_uses(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		SetSlot inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.uses);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'uses' of type 'short'");
	}
	
	uword _prop_id(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		SetSlot inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.id);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'id' of type 'byte'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "SetSlot", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_count", &_prop_count);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_itemID", &_prop_itemID);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_slot", &_prop_slot);
			c.method("_prop_uses", &_prop_uses);
			c.method("_prop_id", &_prop_id);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "SetSlot.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(SetSlot));
		newGlobal(t, "SetSlot");
	}
}

struct WindowItemsObj
{
	static:
	private WindowItems getThis(CrocThread* t)
	{
		return cast(WindowItems)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "WindowItems");
		WindowItems inst;
		
		if(numParams == 0)
		{
			inst = new WindowItems();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		WindowItems inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type WindowItems`, fieldName);
			
			case "count":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_count`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "items":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_items`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "id":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_id`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type WindowItems`, fieldName);
			
			case "count":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_count`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "items":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_items`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "id":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_id`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_count(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		WindowItems inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.count);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'count' of type 'short'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		WindowItems inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_items(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		WindowItems inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.items);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'items' of type 'Item[]'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		WindowItems inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_id(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		WindowItems inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.id);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'id' of type 'byte'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "WindowItems", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_count", &_prop_count);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_items", &_prop_items);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_id", &_prop_id);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "WindowItems.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(WindowItems));
		newGlobal(t, "WindowItems");
	}
}

struct UpdateProgressObj
{
	static:
	private UpdateProgress getThis(CrocThread* t)
	{
		return cast(UpdateProgress)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "UpdateProgress");
		UpdateProgress inst;
		
		if(numParams == 0)
		{
			inst = new UpdateProgress();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		UpdateProgress inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type UpdateProgress`, fieldName);
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "value":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_value`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "bar":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_bar`, 1);
				break;
			
			case "id":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_id`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type UpdateProgress`, fieldName);
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "value":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_value`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "bar":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_bar`, 0);
				break;
			
			case "id":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_id`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		UpdateProgress inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_value(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		UpdateProgress inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.value);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'value' of type 'short'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		UpdateProgress inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_bar(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		UpdateProgress inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.bar);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'bar' of type 'short'");
	}
	
	uword _prop_id(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		UpdateProgress inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.id);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'id' of type 'byte'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "UpdateProgress", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_value", &_prop_value);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_bar", &_prop_bar);
			c.method("_prop_id", &_prop_id);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "UpdateProgress.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(UpdateProgress));
		newGlobal(t, "UpdateProgress");
	}
}

struct TransactionObj
{
	static:
	private Transaction getThis(CrocThread* t)
	{
		return cast(Transaction)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "Transaction");
		Transaction inst;
		
		if(numParams == 0)
		{
			inst = new Transaction();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		Transaction inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type Transaction`, fieldName);
			
			case "accepted":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_accepted`, 1);
				break;
			
			case "transactionID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_transactionID`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "id":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_id`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type Transaction`, fieldName);
			
			case "accepted":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_accepted`, 0);
				break;
			
			case "transactionID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_transactionID`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "id":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_id`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_accepted(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Transaction inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.accepted);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'accepted' of type 'bool'");
	}
	
	uword _prop_transactionID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Transaction inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.transactionID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'transactionID' of type 'short'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Transaction inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Transaction inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_id(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Transaction inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.id);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'id' of type 'byte'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "Transaction", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_accepted", &_prop_accepted);
			c.method("_prop_transactionID", &_prop_transactionID);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_id", &_prop_id);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "Transaction.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(Transaction));
		newGlobal(t, "Transaction");
	}
}

struct CreativeInventoryActionObj
{
	static:
	private CreativeInventoryAction getThis(CrocThread* t)
	{
		return cast(CreativeInventoryAction)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "CreativeInventoryAction");
		CreativeInventoryAction inst;
		
		if(numParams == 0)
		{
			inst = new CreativeInventoryAction();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		CreativeInventoryAction inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type CreativeInventoryAction`, fieldName);
			
			case "count":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_count`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "id":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_id`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "uses":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_uses`, 1);
				break;
			
			case "slot":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_slot`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type CreativeInventoryAction`, fieldName);
			
			case "count":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_count`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "id":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_id`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "uses":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_uses`, 0);
				break;
			
			case "slot":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_slot`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_count(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		CreativeInventoryAction inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.count);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'count' of type 'short'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		CreativeInventoryAction inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_id(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		CreativeInventoryAction inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.id);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'id' of type 'short'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		CreativeInventoryAction inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_uses(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		CreativeInventoryAction inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.uses);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'uses' of type 'short'");
	}
	
	uword _prop_slot(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		CreativeInventoryAction inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.slot);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'slot' of type 'short'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "CreativeInventoryAction", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_count", &_prop_count);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_id", &_prop_id);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_uses", &_prop_uses);
			c.method("_prop_slot", &_prop_slot);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "CreativeInventoryAction.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(CreativeInventoryAction));
		newGlobal(t, "CreativeInventoryAction");
	}
}

struct UpdateSignObj
{
	static:
	private UpdateSign getThis(CrocThread* t)
	{
		return cast(UpdateSign)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "UpdateSign");
		UpdateSign inst;
		
		if(numParams == 0)
		{
			inst = new UpdateSign();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		UpdateSign inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type UpdateSign`, fieldName);
			
			case "z":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_z`, 1);
				break;
			
			case "line2":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_line2`, 1);
				break;
			
			case "line4":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_line4`, 1);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_x`, 1);
				break;
			
			case "line3":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_line3`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "line1":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_line1`, 1);
				break;
			
			case "y":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_y`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type UpdateSign`, fieldName);
			
			case "z":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_z`, 0);
				break;
			
			case "line2":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_line2`, 0);
				break;
			
			case "line4":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_line4`, 0);
				break;
			
			case "x":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_x`, 0);
				break;
			
			case "line3":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_line3`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "line1":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_line1`, 0);
				break;
			
			case "y":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_y`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_z(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		UpdateSign inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.z);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'z' of type 'int'");
	}
	
	uword _prop_line2(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		UpdateSign inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.line2);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'line2' of type 'char[]'");
	}
	
	uword _prop_line4(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		UpdateSign inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.line4);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'line4' of type 'char[]'");
	}
	
	uword _prop_x(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		UpdateSign inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.x);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'x' of type 'int'");
	}
	
	uword _prop_line3(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		UpdateSign inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.line3);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'line3' of type 'char[]'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		UpdateSign inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_line1(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		UpdateSign inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.line1);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'line1' of type 'char[]'");
	}
	
	uword _prop_y(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		UpdateSign inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.y);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'y' of type 'short'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		UpdateSign inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "UpdateSign", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_z", &_prop_z);
			c.method("_prop_line2", &_prop_line2);
			c.method("_prop_line4", &_prop_line4);
			c.method("_prop_x", &_prop_x);
			c.method("_prop_line3", &_prop_line3);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_line1", &_prop_line1);
			c.method("_prop_y", &_prop_y);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "UpdateSign.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(UpdateSign));
		newGlobal(t, "UpdateSign");
	}
}

struct ItemDataObj
{
	static:
	private ItemData getThis(CrocThread* t)
	{
		return cast(ItemData)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "ItemData");
		ItemData inst;
		
		if(numParams == 0)
		{
			inst = new ItemData();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		ItemData inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type ItemData`, fieldName);
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "data":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_data`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "type":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_type`, 1);
				break;
			
			case "len":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_len`, 1);
				break;
			
			case "id":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_id`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type ItemData`, fieldName);
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "data":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_data`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "type":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_type`, 0);
				break;
			
			case "len":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_len`, 0);
				break;
			
			case "id":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_id`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		ItemData inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_data(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		ItemData inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.data);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'data' of type 'byte[]'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		ItemData inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_type(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		ItemData inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.type);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'type' of type 'short'");
	}
	
	uword _prop_len(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		ItemData inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.len);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'len' of type 'ubyte'");
	}
	
	uword _prop_id(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		ItemData inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.id);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'id' of type 'short'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "ItemData", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_data", &_prop_data);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_type", &_prop_type);
			c.method("_prop_len", &_prop_len);
			c.method("_prop_id", &_prop_id);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "ItemData.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(ItemData));
		newGlobal(t, "ItemData");
	}
}

struct IncrementStatisticObj
{
	static:
	private IncrementStatistic getThis(CrocThread* t)
	{
		return cast(IncrementStatistic)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "IncrementStatistic");
		IncrementStatistic inst;
		
		if(numParams == 0)
		{
			inst = new IncrementStatistic();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		IncrementStatistic inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type IncrementStatistic`, fieldName);
			
			case "amount":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_amount`, 1);
				break;
			
			case "id":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_id`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type IncrementStatistic`, fieldName);
			
			case "amount":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_amount`, 0);
				break;
			
			case "id":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_id`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_amount(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		IncrementStatistic inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.amount);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'amount' of type 'byte'");
	}
	
	uword _prop_id(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		IncrementStatistic inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.id);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'id' of type 'int'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		IncrementStatistic inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		IncrementStatistic inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "IncrementStatistic", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_amount", &_prop_amount);
			c.method("_prop_id", &_prop_id);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "IncrementStatistic.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(IncrementStatistic));
		newGlobal(t, "IncrementStatistic");
	}
}

struct PlayerListItemObj
{
	static:
	private PlayerListItem getThis(CrocThread* t)
	{
		return cast(PlayerListItem)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "PlayerListItem");
		PlayerListItem inst;
		
		if(numParams == 0)
		{
			inst = new PlayerListItem();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		PlayerListItem inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type PlayerListItem`, fieldName);
			
			case "ping":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_ping`, 1);
				break;
			
			case "online":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_online`, 1);
				break;
			
			case "name":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_name`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type PlayerListItem`, fieldName);
			
			case "ping":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_ping`, 0);
				break;
			
			case "online":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_online`, 0);
				break;
			
			case "name":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_name`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_ping(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PlayerListItem inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.ping);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'ping' of type 'short'");
	}
	
	uword _prop_online(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PlayerListItem inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.online);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'online' of type 'bool'");
	}
	
	uword _prop_name(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PlayerListItem inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.name);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'name' of type 'char[]'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PlayerListItem inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		PlayerListItem inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "PlayerListItem", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_ping", &_prop_ping);
			c.method("_prop_online", &_prop_online);
			c.method("_prop_name", &_prop_name);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "PlayerListItem.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(PlayerListItem));
		newGlobal(t, "PlayerListItem");
	}
}

struct ServerListPingObj
{
	static:
	private ServerListPing getThis(CrocThread* t)
	{
		return cast(ServerListPing)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "ServerListPing");
		ServerListPing inst;
		
		if(numParams == 0)
		{
			inst = new ServerListPing();
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword send(CrocThread* t)
	{
		ServerListPing inst = getThis(t);
		
		MinecraftDataOutput output = superGet!(MinecraftDataOutput)(t, 1);
		
		//call the function
		inst.send(output);
		return 0;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type ServerListPing`, fieldName);
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type ServerListPing`, fieldName);
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		ServerListPing inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "ServerListPing", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("send", &send);
			
			//properties
			c.method("_prop_packetID", &_prop_packetID);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "ServerListPing.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(ServerListPing));
		newGlobal(t, "ServerListPing");
	}
}

struct DisconnectObj
{
	static:
	private Disconnect getThis(CrocThread* t)
	{
		return cast(Disconnect)getNativeObj(t, getExtraVal(t, 0, 0));
	}
	
	uword constructor(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		checkInstParam(t, 0, "Disconnect");
		Disconnect inst;
		
		if(numParams == 0)
		{
			inst = new Disconnect();
		}
		
		if(numParams == 1 && TypesMatch!(char[])(t))
		{
			// getting parameters
			char[] reason = superGet!(char[])(t, 1);
			
			inst = new Disconnect(reason);
		}
		
		if(inst is null) throwStdException(t, "MethodException", "No such constructor");
		pushNativeObj(t, inst);
		setExtraVal(t, 0, 0);
		setWrappedInstance(t, inst, 0);
		return 0;
	}
	
	uword send(CrocThread* t)
	{
		Disconnect inst = getThis(t);
		
		MinecraftDataOutput output = superGet!(MinecraftDataOutput)(t, 1);
		
		//call the function
		inst.send(output);
		return 0;
	}
	
	uword receive(CrocThread* t)
	{
		Disconnect inst = getThis(t);
		
		MinecraftDataInput input = superGet!(MinecraftDataInput)(t, 1);
		
		//call the function
		int returns = inst.receive(input);
		superPush!(int)(t, returns);
		return 1;
	}
	
	uword opField(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type Disconnect`, fieldName);
			
			case "reason":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_reason`, 1);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_minSize`, 1);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				methodCall(t, -2, `_prop_packetID`, 1);
				break;
		}
		return 1;
	}
	
	uword opFieldAssign(CrocThread* t)
	{
		auto fieldName = checkStringParam(t, 1);
		switch(fieldName)
		{
			default:
				throwStdException(t, `FieldException`, `Attempting to access nonexistent field '{}' from type Disconnect`, fieldName);
			
			case "reason":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_reason`, 0);
				break;
			
			case "minSize":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_minSize`, 0);
				break;
			
			case "packetID":
				dup(t, 0);
				pushNull(t);
				dup(t, 2);
				methodCall(t, -3, `_prop_packetID`, 0);
				break;
		}
		return 0;
	}
	
	uword _prop_reason(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Disconnect inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.reason);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'reason' of type 'char[]'");
	}
	
	uword _prop_minSize(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Disconnect inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.minSize);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'minSize' of type 'uint'");
	}
	
	uword _prop_packetID(CrocThread* t)
	{
		auto numParams = stackSize(t) - 1;
		Disconnect inst = getThis(t);
		if(numParams == 0)
		{
			superPush(t, inst.packetID);
			return 1;
		}
		throwStdException(t, "FieldException", "Attempting to set read-only property 'packetID' of type 'PacketID'");
	}
	
	void init(CrocThread* t)
	{
		CreateClass(t, "Disconnect", (CreateClass* c)
		{
			c.method("constructor", &constructor);
			
			//methods
			c.method("send", &send);
			c.method("receive", &receive);
			
			//properties
			c.method("_prop_reason", &_prop_reason);
			c.method("_prop_minSize", &_prop_minSize);
			c.method("_prop_packetID", &_prop_packetID);
			c.method("opField", &opField);
			c.method("opFieldAssign", &opFieldAssign);
		});
		
		newFunction(t, &BasicClassAllocator!(1, 0), "Disconnect.allocator");
		setAllocator(t, -2);
		
		setWrappedClass(t, typeid(Disconnect));
		newGlobal(t, "Disconnect");
	}
}