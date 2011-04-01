module entities

local _ents = 
{
}

local function filterTable(t : table, pred : function)
{
	local newTab = t.dup()
	
	foreach(k, v; newTab, "modify")
	{
		if(!pred(k, v))
			hash.remove(newTab, k)
	}
	
	return newTab
}

afterDestroyEntity (\p{ _ents[p.EID] = null })

global mobs		= \-> filterTable(_ents, \k,v->v.etype == EntityType.Mob)
global pickups	= \-> filterTable(_ents, \k,v->v.etype == EntityType.Pickup)
global players	= \-> filterTable(_ents, \k,v->v.etype == EntityType.Player)
global objects	= \-> filterTable(_ents, \k,v->v.etype == EntityType.Object)
global all		= \-> _ents

global function get(eid) = _ents[eid]

global function modify(eid : int, modifier : function)
{
	local ent = _ents[eid]
	modifier(ent)
}

global function new(p, extra : function)
{
	local EID = p.EID
	
	if(EID in _ents)
		return
	local ent = {}
	ent.x = p.x
	ent.y = p.y
	ent.z = p.z
	ent.EID = EID
	ent.block = \-> {x = ent.x / 32.0, y = ent.y / 32.0, z = ent.z / 32.0}
	extra(ent)
	_ents[EID] = ent
}

@onUseBed
local function handleEntity(p)
{
	local EID = p.EID
	
	if(p.packetID == PacketID.UseBed)
	{
		local ent = _ents[EID]
		
		send $ Chat $ format $ "{} is going to bed", ent.name
	}
}

@onEntityRelativeMove
@onEntityLookRelativeMove
local function entityMove(p)=
	modify(p.EID, \e
	{
		e.x += p.dX
		e.y += p.dY
		e.z += p.dZ
	})
	
onEntityTeleport(\p{
	modify(p.EID, \e
	{
		e.x = p.x
		e.y = p.y
		e.z = p.z
	})
})

@onEntityLook
@onEntityLookRelativeMove
@onEntityTeleport
local function entityLook(p) = 
	modify(p.EID, \e{
		e.yaw = p.yaw
		e.pitch = p.pitch
	})

	
onMobSpawn(\p->
	new(p, \e{
		e.yaw = p.yaw
		e.pitch = p.pitch
		e.type = p.type
		e.etype = EntityType.Mob
		e.metadata = metadata(p)
	})
)

onNamedEntitySpawn(\p->
	new(p, \e{
		e.name = p.name
		e.rotation = p.rotation
		e.pitch = p.pitch
		e.currentItem = p.currentItem
		e.etype = EntityType.Player
	})
)

onPickupSpawn(\p->
	new(p, \e{
		e.count = p.count
		e.itemID = p.itemID
		e.rotation = p.rotation
		e.pitch = p.pitch
		e.roll = p.roll
		e.damage = p.damage
		e.etype = EntityType.Pickup
	})
)

onAddObject(\p->
	new(p, \e{
		e.type = p.type
		e.etype = EntityType.Object
	})
)

onEntityMetadata(\p->
	modify(p.EID, \e
	{
		e.metadata = metadata(p)
	})
)