module entities

local _ents = 
{
}

onDestroyEntity(\p{	_ents[p.EID] = null })

global mobs		= \-> filterTable(_ents, \k,v->v.etype == EntityType.Mob)
global pickups	= \-> filterTable(_ents, \k,v->v.etype == EntityType.Pickup)
global players	= \-> filterTable(_ents, \k,v->v.etype == EntityType.Player)
global objects	= \-> filterTable(_ents, \k,v->v.etype == EntityType.Object)
global all		= \-> _ents

global function get(eid) = _ents[eid]

@onUseBed
local function handleEntity(p)
{
	local EID = p.EID
	
	if(p.packetID == PacketID.UseBed)
	{
		local ent = _ents[EID]
		
		send $ Chat $ format $ "{} is going to bed", ent.name
	}
	else
	{
		return moveEntity(_ents[EID], p)
	}
}

@onMobSpawn
@onNamedEntitySpawn
@onPickupSpawn
@onAddObject
local function spawnEntity(p)
{
	local ent = {}
	
	if(p.packetID == PacketID.MobSpawn)
	{
		//writefln $ "MobSpawn EID: {} type: {} at {}/{}/{}", p.EID, MobType.toString(p.type), p.x / 32.0, p.y / 32.0, p.z / 32.0
		
		ent.yaw = p.yaw
		ent.pitch = p.pitch
		ent.type = p.type
		ent.etype = EntityType.Mob
		ent.metadata = metadata(p)
	}
	else if(p.packetID == PacketID.NamedEntitySpawn)
	{
		ent.name = p.name
		ent.rotation = p.rotation
		ent.pitch = p.pitch
		ent.currentItem = p.currentItem
		ent.etype = EntityType.Player
	}
	else if(p.packetID == PacketID.PickupSpawn)
	{
		//writefln $ "PickupSpawn EID: {} item: {} at {}/{}/{}", EID, p.itemID, p.x / 32.0, p.y / 32.0, p.z / 32.0
		
		ent.count = p.count
		ent.itemID = p.itemID
		ent.rotation = p.rotation
		ent.pitch = p.pitch
		ent.roll = p.roll
		ent.damage = p.damage
		ent.etype = EntityType.Pickup
	}
	else if(p.packetID == PacketID.AddObject)
	{
		ent.type = p.type
		ent.etype = EntityType.Object
	}
	else
	{
		//writefln $ "Warning: unhandled entity spawn: {} EID: {} {}", PacketID.toString(p.packetID), p.EID
		
		ent = null
		return
	}
	ent.EID = p.EID
	ent.x = p.x
	ent.y = p.y
	ent.z = p.z
	_ents[ent.EID] = ent
	return true
}

onInit(\{
	setTimer(1000, \{
		foreach(k, v; _ents)
		{
			dumpVal  $ entities.get $ k
			writefln $ "type: {}", EntityType.toString $ (entities.get $ k).etype
			writeln  $ "======================================"
		}
	})
})