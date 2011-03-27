
module bindings.classes;
import minid.bind;
import minid.api;
import miney.protocol;
import miney.network;
void initMineyClasses(MDVM* vm)
{
	MDThread* t = mainThread(vm);
	
	WrapGlobals!(WrapType!(MetadataPacket, "MetadataPacket"),
		WrapType!(
			Sendable,
			"Sendable",
			
			WrapProperty!(Sendable.packetID)
		),
		WrapType!(
			KeepAlive,
			"KeepAlive",
			
			WrapProperty!(KeepAlive.packetID)
		),
		WrapType!(
			PlayerDigging,
			"PlayerDigging",
			WrapCtors!(void function(byte, int, byte, int, byte)),
			WrapProperty!(PlayerDigging.packetID)
		),
		WrapType!(
			UpdateHealth,
			"UpdateHealth",
			
			WrapProperty!(UpdateHealth.health), WrapProperty!(UpdateHealth.packetID)
		),
		WrapType!(
			EntityAction,
			"EntityAction",
			WrapCtors!(void function(int, byte)),
			WrapProperty!(EntityAction.EID), WrapProperty!(EntityAction.action), WrapProperty!(EntityAction.packetID)
		),
		WrapType!(
			PickupSpawn,
			"PickupSpawn",
			
			WrapProperty!(PickupSpawn.EID), WrapProperty!(PickupSpawn.x), WrapProperty!(PickupSpawn.y), WrapProperty!(PickupSpawn.z), WrapProperty!(PickupSpawn.count), WrapProperty!(PickupSpawn.rotation), WrapProperty!(PickupSpawn.pitch), WrapProperty!(PickupSpawn.roll), WrapProperty!(PickupSpawn.itemID), WrapProperty!(PickupSpawn.damage), WrapProperty!(PickupSpawn.packetID)
		),
		WrapType!(
			PlayerLook,
			"PlayerLook",
			WrapCtors!(void function(float, float, bool)),
			WrapProperty!(PlayerLook.packetID)
		),
		WrapType!(
			SpawnPosition,
			"SpawnPosition",
			
			WrapProperty!(SpawnPosition.x), WrapProperty!(SpawnPosition.y), WrapProperty!(SpawnPosition.z), WrapProperty!(SpawnPosition.packetID)
		),
		WrapType!(
			EntityVelocity,
			"EntityVelocity",
			
			WrapProperty!(EntityVelocity.EID), WrapProperty!(EntityVelocity.x), WrapProperty!(EntityVelocity.y), WrapProperty!(EntityVelocity.z), WrapProperty!(EntityVelocity.packetID)
		),
		WrapType!(
			PreChunk,
			"PreChunk",
			
			WrapProperty!(PreChunk.x), WrapProperty!(PreChunk.y), WrapProperty!(PreChunk.mode), WrapProperty!(PreChunk.packetID)
		),
		WrapType!(
			Transaction,
			"Transaction",
			
			WrapProperty!(Transaction.id), WrapProperty!(Transaction.transactionID), WrapProperty!(Transaction.accepted), WrapProperty!(Transaction.packetID)
		),
		WrapType!(
			EntityPainting,
			"EntityPainting",
			
			WrapProperty!(EntityPainting.EID), WrapProperty!(EntityPainting.x), WrapProperty!(EntityPainting.y), WrapProperty!(EntityPainting.z), WrapProperty!(EntityPainting.type), WrapProperty!(EntityPainting.title), WrapProperty!(EntityPainting.packetID)
		),
		WrapType!(
			NamedEntitySpawn,
			"NamedEntitySpawn",
			
			WrapProperty!(NamedEntitySpawn.EID), WrapProperty!(NamedEntitySpawn.x), WrapProperty!(NamedEntitySpawn.y), WrapProperty!(NamedEntitySpawn.z), WrapProperty!(NamedEntitySpawn.name), WrapProperty!(NamedEntitySpawn.rotation), WrapProperty!(NamedEntitySpawn.pitch), WrapProperty!(NamedEntitySpawn.currentItem), WrapProperty!(NamedEntitySpawn.packetID)
		),
		WrapType!(
			Login,
			"Login",
			WrapCtors!(void function(char[], char[])),
			WrapProperty!(Login.EID), WrapProperty!(Login.mapSeed), WrapProperty!(Login.dimension), WrapProperty!(Login.packetID)
		),
		WrapType!(
			Handshake,
			"Handshake",
			WrapCtors!(void function(char[])),
			WrapProperty!(Handshake.username), WrapProperty!(Handshake.connectionHash), WrapProperty!(Handshake.packetID)
		),
		WrapType!(
			Respawn,
			"Respawn",
			
			WrapProperty!(Respawn.packetID)
		),
		WrapType!(
			EntityLookRelativeMove,
			"EntityLookRelativeMove",
			
			WrapProperty!(EntityLookRelativeMove.EID), WrapProperty!(EntityLookRelativeMove.dX), WrapProperty!(EntityLookRelativeMove.dY), WrapProperty!(EntityLookRelativeMove.dZ), WrapProperty!(EntityLookRelativeMove.yaw), WrapProperty!(EntityLookRelativeMove.pitch), WrapProperty!(EntityLookRelativeMove.packetID)
		),
		WrapType!(
			EntityTeleport,
			"EntityTeleport",
			
			WrapProperty!(EntityTeleport.EID), WrapProperty!(EntityTeleport.x), WrapProperty!(EntityTeleport.y), WrapProperty!(EntityTeleport.z), WrapProperty!(EntityTeleport.yaw), WrapProperty!(EntityTeleport.pitch), WrapProperty!(EntityTeleport.packetID)
		),
		WrapType!(
			EntityRelativeMove,
			"EntityRelativeMove",
			
			WrapProperty!(EntityRelativeMove.EID), WrapProperty!(EntityRelativeMove.dX), WrapProperty!(EntityRelativeMove.dY), WrapProperty!(EntityRelativeMove.dZ), WrapProperty!(EntityRelativeMove.packetID)
		),
		WrapType!(
			EntityStatus,
			"EntityStatus",
			
			WrapProperty!(EntityStatus.EID), WrapProperty!(EntityStatus.status), WrapProperty!(EntityStatus.packetID)
		),
		WrapType!(
			AttachEntity,
			"AttachEntity",
			
			WrapProperty!(AttachEntity.EID), WrapProperty!(AttachEntity.vehicle), WrapProperty!(AttachEntity.packetID)
		),
		WrapType!(
			EntityMetadata,
			"EntityMetadata",
			
			WrapProperty!(EntityMetadata.EID), WrapProperty!(EntityMetadata.packetID)
		),
		WrapType!(
			EntityLook,
			"EntityLook",
			
			WrapProperty!(EntityLook.EID), WrapProperty!(EntityLook.yaw), WrapProperty!(EntityLook.pitch), WrapProperty!(EntityLook.packetID)
		),
		WrapType!(
			DestroyEntity,
			"DestroyEntity",
			
			WrapProperty!(DestroyEntity.EID), WrapProperty!(DestroyEntity.packetID)
		),
		WrapType!(
			MultiBlockChange,
			"MultiBlockChange",
			
			WrapProperty!(MultiBlockChange.length), WrapProperty!(MultiBlockChange.coordinates), WrapProperty!(MultiBlockChange.types), WrapProperty!(MultiBlockChange.metadata), WrapProperty!(MultiBlockChange.packetID)
		),
		WrapType!(
			Explosion,
			"Explosion",
			
			WrapProperty!(Explosion.x), WrapProperty!(Explosion.y), WrapProperty!(Explosion.z), WrapProperty!(Explosion.recordCount), WrapProperty!(Explosion.records), WrapProperty!(Explosion.packetID)
		),
		WrapType!(
			CloseWindow,
			"CloseWindow",
			WrapCtors!(void function(byte)),
			WrapProperty!(CloseWindow.id), WrapProperty!(CloseWindow.packetID)
		),
		WrapType!(
			TimeUpdate,
			"TimeUpdate",
			
			WrapProperty!(TimeUpdate.time), WrapProperty!(TimeUpdate.packetID)
		),
		WrapType!(
			EntityEquipment,
			"EntityEquipment",
			
			WrapProperty!(EntityEquipment.EID), WrapProperty!(EntityEquipment.slot), WrapProperty!(EntityEquipment.itemID), WrapProperty!(EntityEquipment.damage), WrapProperty!(EntityEquipment.packetID)
		),
		WrapType!(
			OpenWindow,
			"OpenWindow",
			
			WrapProperty!(OpenWindow.id), WrapProperty!(OpenWindow.type), WrapProperty!(OpenWindow.slots), WrapProperty!(OpenWindow.title), WrapProperty!(OpenWindow.packetID)
		),
		WrapType!(
			WindowItems,
			"WindowItems",
			
			WrapProperty!(WindowItems.id), WrapProperty!(WindowItems.count), WrapProperty!(WindowItems.items), WrapProperty!(WindowItems.packetID)
		),
		WrapType!(
			Chat,
			"Chat",
			WrapCtors!(void function(char[])),
			WrapProperty!(Chat.message), WrapProperty!(Chat.packetID)
		),
		WrapType!(
			MapChunk,
			"MapChunk",
			
			WrapProperty!(MapChunk.x), WrapProperty!(MapChunk.y), WrapProperty!(MapChunk.z), WrapProperty!(MapChunk.sizeX), WrapProperty!(MapChunk.sizeY), WrapProperty!(MapChunk.sizeZ), WrapProperty!(MapChunk.data), WrapProperty!(MapChunk.size), WrapProperty!(MapChunk.packetID)
		),
		WrapType!(
			PlayNoteBlock,
			"PlayNoteBlock",
			
			WrapProperty!(PlayNoteBlock.x), WrapProperty!(PlayNoteBlock.y), WrapProperty!(PlayNoteBlock.z), WrapProperty!(PlayNoteBlock.type), WrapProperty!(PlayNoteBlock.pitch), WrapProperty!(PlayNoteBlock.packetID)
		),
		WrapType!(
			UpdateProgress,
			"UpdateProgress",
			
			WrapProperty!(UpdateProgress.id), WrapProperty!(UpdateProgress.bar), WrapProperty!(UpdateProgress.value), WrapProperty!(UpdateProgress.packetID)
		),
		WrapType!(
			HoldingChange,
			"HoldingChange",
			WrapCtors!(void function(short)),
			WrapProperty!(HoldingChange.packetID)
		),
		WrapType!(
			PlayerPosition,
			"PlayerPosition",
			WrapCtors!(void function(double, double, double, double, bool)),
			WrapProperty!(PlayerPosition.packetID)
		),
		WrapType!(
			SetSlot,
			"SetSlot",
			
			WrapProperty!(SetSlot.id), WrapProperty!(SetSlot.count), WrapProperty!(SetSlot.slot), WrapProperty!(SetSlot.itemID), WrapProperty!(SetSlot.uses), WrapProperty!(SetSlot.packetID)
		),
		WrapType!(
			Entity,
			"Entity",
			
			WrapProperty!(Entity.EID), WrapProperty!(Entity.packetID)
		),
		WrapType!(
			WindowClick,
			"WindowClick",
			WrapCtors!(void function(byte, short, byte, short, short, byte, short)),
			WrapProperty!(WindowClick.packetID)
		),
		WrapType!(
			DropItem,
			"DropItem",
			
			WrapProperty!(DropItem.packetID)
		),
		WrapType!(
			AddObject,
			"AddObject",
			
			WrapProperty!(AddObject.EID), WrapProperty!(AddObject.x), WrapProperty!(AddObject.y), WrapProperty!(AddObject.z), WrapProperty!(AddObject.type), WrapProperty!(AddObject.packetID)
		),
		WrapType!(
			Disconnect,
			"Disconnect",
			WrapCtors!(void function(char[])),
			WrapProperty!(Disconnect.reason), WrapProperty!(Disconnect.packetID)
		),
		WrapType!(
			BlockChange,
			"BlockChange",
			
			WrapProperty!(BlockChange.x), WrapProperty!(BlockChange.y), WrapProperty!(BlockChange.z), WrapProperty!(BlockChange.type), WrapProperty!(BlockChange.metadata), WrapProperty!(BlockChange.packetID)
		),
		WrapType!(
			UpdateSign,
			"UpdateSign",
			
			WrapProperty!(UpdateSign.x), WrapProperty!(UpdateSign.y), WrapProperty!(UpdateSign.z), WrapProperty!(UpdateSign.line1), WrapProperty!(UpdateSign.line2), WrapProperty!(UpdateSign.line3), WrapProperty!(UpdateSign.line4), WrapProperty!(UpdateSign.packetID)
		),
		WrapType!(
			Animation,
			"Animation",
			WrapCtors!(void function(int, byte)),
			WrapProperty!(Animation.EID), WrapProperty!(Animation.animate), WrapProperty!(Animation.packetID)
		),
		WrapType!(
			PlayerBlockPlacement,
			"PlayerBlockPlacement",
			WrapCtors!(void function(int, byte, int, byte, short, byte, short)),
			WrapProperty!(PlayerBlockPlacement.x), WrapProperty!(PlayerBlockPlacement.y), WrapProperty!(PlayerBlockPlacement.z), WrapProperty!(PlayerBlockPlacement.direction), WrapProperty!(PlayerBlockPlacement.amount), WrapProperty!(PlayerBlockPlacement.block), WrapProperty!(PlayerBlockPlacement.itemID), WrapProperty!(PlayerBlockPlacement.damage), WrapProperty!(PlayerBlockPlacement.packetID)
		),
		WrapType!(
			UseEntity,
			"UseEntity",
			WrapCtors!(void function(int, int, bool)),
			WrapProperty!(UseEntity.user), WrapProperty!(UseEntity.target), WrapProperty!(UseEntity.leftClick), WrapProperty!(UseEntity.packetID)
		),
		WrapType!(
			Player,
			"Player",
			WrapCtors!(void function(bool)),
			WrapProperty!(Player.packetID)
		),
		WrapType!(
			UseBed,
			"UseBed",
			
			WrapProperty!(UseBed.EID), WrapProperty!(UseBed.x), WrapProperty!(UseBed.y), WrapProperty!(UseBed.z), WrapProperty!(UseBed.packetID)
		),
		WrapType!(
			MobSpawn,
			"MobSpawn",
			
			WrapProperty!(MobSpawn.EID), WrapProperty!(MobSpawn.x), WrapProperty!(MobSpawn.y), WrapProperty!(MobSpawn.z), WrapProperty!(MobSpawn.type), WrapProperty!(MobSpawn.yaw), WrapProperty!(MobSpawn.pitch), WrapProperty!(MobSpawn.packetID)
		),
		WrapType!(
			PlayerPositionLook,
			"PlayerPositionLook",
			WrapCtors!(void function(double, double, double, double, float, float, bool)),
			WrapProperty!(PlayerPositionLook.x), WrapProperty!(PlayerPositionLook.y), WrapProperty!(PlayerPositionLook.z), WrapProperty!(PlayerPositionLook.stance), WrapProperty!(PlayerPositionLook.yaw), WrapProperty!(PlayerPositionLook.pitch), WrapProperty!(PlayerPositionLook.onGround), WrapProperty!(PlayerPositionLook.packetID)
		),
		WrapType!(
			CollectItem,
			"CollectItem",
			
			WrapProperty!(CollectItem.collected), WrapProperty!(CollectItem.collector), WrapProperty!(CollectItem.packetID)
		)
	)(t);
}