
module bindings.enums;
import minid.api;
import minid.bind;
import miney.protocol;
void initMineyEnums(MDVM* vm)
{
	MDThread* t = mainThread(vm);
	
	WrapGlobals!(
		WrapNamespace!(
		"InstrumentType",
			WrapValue!("Harp", InstrumentType.Harp),
			WrapValue!("DoubleBass", InstrumentType.DoubleBass),
			WrapValue!("SnareDrum", InstrumentType.SnareDrum),
			WrapValue!("Sticks", InstrumentType.Sticks),
			WrapValue!("BassDrum", InstrumentType.BassDrum)
		),
		WrapNamespace!(
		"WoolColor",
			WrapValue!("White", WoolColor.White),
			WrapValue!("Orange", WoolColor.Orange),
			WrapValue!("Magenta", WoolColor.Magenta),
			WrapValue!("LightBlue", WoolColor.LightBlue),
			WrapValue!("Yellow", WoolColor.Yellow),
			WrapValue!("Lime", WoolColor.Lime),
			WrapValue!("Pink", WoolColor.Pink),
			WrapValue!("Gray", WoolColor.Gray),
			WrapValue!("Silver", WoolColor.Silver),
			WrapValue!("Cyan", WoolColor.Cyan),
			WrapValue!("Purple", WoolColor.Purple),
			WrapValue!("Blue", WoolColor.Blue),
			WrapValue!("Brown", WoolColor.Brown),
			WrapValue!("Green", WoolColor.Green),
			WrapValue!("Red", WoolColor.Red),
			WrapValue!("Black", WoolColor.Black)
		),
		WrapNamespace!(
		"ObjectType",
			WrapValue!("Boat", ObjectType.Boat),
			WrapValue!("Minecart", ObjectType.Minecart),
			WrapValue!("StorageCart", ObjectType.StorageCart),
			WrapValue!("PoweredCart", ObjectType.PoweredCart),
			WrapValue!("TNT", ObjectType.TNT),
			WrapValue!("Arrow", ObjectType.Arrow),
			WrapValue!("SnowBall", ObjectType.SnowBall),
			WrapValue!("Egg", ObjectType.Egg),
			WrapValue!("Sand", ObjectType.Sand),
			WrapValue!("Gravel", ObjectType.Gravel),
			WrapValue!("FishingFloat", ObjectType.FishingFloat)
		),
		WrapNamespace!(
		"MobType",
			WrapValue!("Creeper", MobType.Creeper),
			WrapValue!("Skeleton", MobType.Skeleton),
			WrapValue!("Spider", MobType.Spider),
			WrapValue!("GiantZombie", MobType.GiantZombie),
			WrapValue!("Zombie", MobType.Zombie),
			WrapValue!("Slime", MobType.Slime),
			WrapValue!("Ghast", MobType.Ghast),
			WrapValue!("ZombiePigman", MobType.ZombiePigman),
			WrapValue!("Pig", MobType.Pig),
			WrapValue!("Sheep", MobType.Sheep),
			WrapValue!("Cow", MobType.Cow),
			WrapValue!("Hen", MobType.Hen),
			WrapValue!("Squid", MobType.Squid),
			WrapValue!("Wolf", MobType.Wolf)
		),
		WrapNamespace!(
		"PacketID",
			WrapValue!("KeepAlive", PacketID.KeepAlive),
			WrapValue!("Login", PacketID.Login),
			WrapValue!("Handshake", PacketID.Handshake),
			WrapValue!("Chat", PacketID.Chat),
			WrapValue!("TimeUpdate", PacketID.TimeUpdate),
			WrapValue!("EntityEquipment", PacketID.EntityEquipment),
			WrapValue!("SpawnPosition", PacketID.SpawnPosition),
			WrapValue!("UseEntity", PacketID.UseEntity),
			WrapValue!("UpdateHealth", PacketID.UpdateHealth),
			WrapValue!("Respawn", PacketID.Respawn),
			WrapValue!("Player", PacketID.Player),
			WrapValue!("PlayerPosition", PacketID.PlayerPosition),
			WrapValue!("PlayerLook", PacketID.PlayerLook),
			WrapValue!("PlayerPositionLook", PacketID.PlayerPositionLook),
			WrapValue!("PlayerDigging", PacketID.PlayerDigging),
			WrapValue!("PlayerBlockPlacement", PacketID.PlayerBlockPlacement),
			WrapValue!("HoldingChange", PacketID.HoldingChange),
			WrapValue!("UseBed", PacketID.UseBed),
			WrapValue!("Animation", PacketID.Animation),
			WrapValue!("EntityAction", PacketID.EntityAction),
			WrapValue!("NamedEntitySpawn", PacketID.NamedEntitySpawn),
			WrapValue!("PickupSpawn", PacketID.PickupSpawn),
			WrapValue!("CollectItem", PacketID.CollectItem),
			WrapValue!("AddObject", PacketID.AddObject),
			WrapValue!("MobSpawn", PacketID.MobSpawn),
			WrapValue!("EntityPainting", PacketID.EntityPainting),
			WrapValue!("Unknown", PacketID.Unknown),
			WrapValue!("EntityVelocity", PacketID.EntityVelocity),
			WrapValue!("DestroyEntity", PacketID.DestroyEntity),
			WrapValue!("Entity", PacketID.Entity),
			WrapValue!("EntityRelativeMove", PacketID.EntityRelativeMove),
			WrapValue!("EntityLook", PacketID.EntityLook),
			WrapValue!("EntityLookRelativeMove", PacketID.EntityLookRelativeMove),
			WrapValue!("EntityTeleport", PacketID.EntityTeleport),
			WrapValue!("EntityStatus", PacketID.EntityStatus),
			WrapValue!("AttachEntity", PacketID.AttachEntity),
			WrapValue!("EntityMetadata", PacketID.EntityMetadata),
			WrapValue!("PreChunk", PacketID.PreChunk),
			WrapValue!("MapChunk", PacketID.MapChunk),
			WrapValue!("MultiBlockChange", PacketID.MultiBlockChange),
			WrapValue!("BlockChange", PacketID.BlockChange),
			WrapValue!("PlayNoteBlock", PacketID.PlayNoteBlock),
			WrapValue!("Explosion", PacketID.Explosion),
			WrapValue!("OpenWindow", PacketID.OpenWindow),
			WrapValue!("CloseWindow", PacketID.CloseWindow),
			WrapValue!("WindowClick", PacketID.WindowClick),
			WrapValue!("SetSlot", PacketID.SetSlot),
			WrapValue!("WindowItems", PacketID.WindowItems),
			WrapValue!("UpdateProgress", PacketID.UpdateProgress),
			WrapValue!("Transaction", PacketID.Transaction),
			WrapValue!("UpdateSign", PacketID.UpdateSign),
			WrapValue!("Disconnect", PacketID.Disconnect)
		),
		WrapNamespace!(
		"DiggingStatus",
			WrapValue!("StartedDigging", DiggingStatus.StartedDigging),
			WrapValue!("FinishedDigging", DiggingStatus.FinishedDigging),
			WrapValue!("DropItem", DiggingStatus.DropItem)
		),
		WrapNamespace!(
		"Face",
			WrapValue!("BottomY", Face.BottomY),
			WrapValue!("TopY", Face.TopY),
			WrapValue!("BottomZ", Face.BottomZ),
			WrapValue!("TopZ", Face.TopZ),
			WrapValue!("BottomX", Face.BottomX),
			WrapValue!("TopX", Face.TopX)
		),
		WrapNamespace!(
		"InventoryType",
			WrapValue!("Chest", InventoryType.Chest),
			WrapValue!("Workbench", InventoryType.Workbench),
			WrapValue!("Furnace", InventoryType.Furnace),
			WrapValue!("Dispenser", InventoryType.Dispenser)
		),
		WrapNamespace!(
		"EntityType",
			WrapValue!("Mob", EntityType.Mob),
			WrapValue!("Object", EntityType.Object),
			WrapValue!("Player", EntityType.Player),
			WrapValue!("Pickup", EntityType.Pickup)
		),
		WrapNamespace!(
		"EntAction",
			WrapValue!("Crouch", EntAction.Crouch),
			WrapValue!("Uncrouch", EntAction.Uncrouch),
			WrapValue!("LeaveBed", EntAction.LeaveBed)
		)
	)(t);
	
}

