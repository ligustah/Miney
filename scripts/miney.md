module miney

import mineyStrings
import math
import hash

global entities = 
{
	mobs = function()
	{
		return filterTable(this, \k, v->isInt(k) && v.etype == EntityType.Mob)
	}
}

local lastAttack = 0
global namespace position
{
	x; y; z; yaw; pitch; onGround; valid = false
	
	function update()
	{
		if(valid)
		{
			//writefln("sending position: {}/{}/{} {}", x, y, z, onGround)
			send(PlayerPositionLook(x, y, z, y + 1.65, yaw, pitch, onGround))
		}
	}
}

global function filterTable(t : table, pred : function)
{
	local newTab = t.dup()
	
	foreach(k, v; newTab, "modify")
	{
		if(!pred(k, v))
			hash.remove(newTab, k)
	}
	
	return newTab
}

local function onEntity(packet)
{
	if(packet.EID !in entities)
	{
		entities[packet.EID] = {}
	}
}

local function printPosition(pos, fmt = "")
{
	writefln $ "{} {}/{}/{}", fmt, pos.x, pos.y, pos.z
}

local function attackMobs()
{
	foreach(eid, ent; entities.mobs())
	{
		if(ent.etype != EntityType.Mob)
			continue;
		local dis = distance(position, ent)
		
		if(dis <= 4)
		{
			writefln $ "mob distance {}", dis
			send(UseEntity(0, eid, true))
		}
	}
}

local function moveEntity(e, p)
{
	if(		p.packetID == PacketID.EntityRelativeMove
		||	p.packetID == PacketID.EntityLookRelativeMove )
	{
		e.x += p.dX / 32.0
		e.y += p.dY / 32.0
		e.z += p.dZ / 32.0
	}
	
	if(		p.packetID == PacketID.EntityLook
		||	p.packetID == PacketID.EntityLookRelativeMove )
	{
			e.yaw = p.yaw
			e.pitch = p.pitch
	}
}

local function handleEntity(p)
{
	local EID
	try
	{
		EID = p.EID
	}catch(e){ return }
	
	if(p.packetID == PacketID.Login)
		return
	
	if(EID !in entities)
	{
		local ent = {}
		
		if(p.packetID == PacketID.MobSpawn)
		{
			writefln $ "MobSpawn EID: {} type: {} at {}/{}/{}", EID, MobType.toString(p.type), p.x, p.y, p.z

			ent.yaw = p.yaw
			ent.pitch = p.pitch
			ent.type = p.type
			ent.etype = EntityType.Mob
		}
		else if(p.packetID == PacketID.NamedEntitySpawn)
		{
			ent.name = p.name
			ent.rotation = p.rotation
			ent.pitch = p.pitch
			ent.currentItem = p.currentItem
			ent.etype = EntityType.Player
		}
		else
		{
			writefln $ "Warning: unhandled entity spawn: {} EID: {}", PacketID.toString(p.packetID), p.EID
			ent = null
			return
		}
		ent.EID = p.EID
		ent.x = p.x
		ent.y = p.y
		ent.z = p.z	
		entities[EID] = ent
		return
	}
	
	moveEntity(entities[EID], p)

}

global function onConnect(host, port)
{
	writefln $ "connected!!! ({}:{})", host, port
	local t = 0
	
	setTimer(1000, attackMobs)
	setTimer(5000, function()
	{
		foreach(eid, mob; entities.mobs())
		{
			assert(mob.etype == EntityType.Mob)
		}
		writeln $ "all mobs"
		return true
	})
	setTimer(2000, function()
	{
		local mobs = entities.mobs()
		writefln $ "checking distances for {} mobs", #mobs
		foreach(eid, mob; mobs)
		{
			writefln $ "mob distance {} ({}) = {}", eid, MobType.toString(mob.type), distance(position, mob)
		}
		return true
	})
}

global function onDisconnect()
{
	writeln $ "disconnected :("
}

global function onPacket(packet)
{
	handleEntity(packet)
	switch(packet.packetID)
	{
		case PacketID.Login:
			writefln $ "mapSeed: {}", packet.mapSeed
			break
		case PacketID.Handshake:
			writeln $ "received handshake"
			break;
		case PacketID.EntityMetadata:
			writefln $ "updating {}", packet.EID
		case PacketID.DestroyEntity:
			if(packet.EID in entities)
			{
				writefln $ "{} {} died", MobType.toString(entities[packet.EID].type), packet.EID
				entities[packet.EID] = null
			}
			break
		case PacketID.PlayerPositionLook:
			writefln $ "PPL: X={} Y={} Z={} onGround={}", packet.x, packet.y, packet.z, packet.onGround
			position.x = packet.x
			position.y = packet.y
			position.z = packet.z
			position.yaw = packet.yaw
			position.pitch = packet.pitch
			position.onGround = packet.onGround
			position.valid = true
			break;
		case PacketID.Chat:
			writefln $ "Chat: {}", packet.message
			break
		default:
			break
	}
}

local counter = 0
local factor = 0.01

global function update()
{
	position.update()
}