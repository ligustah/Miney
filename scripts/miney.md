module miney

local username = "Ligustah"
local password = "Password"
local host = "5.1.141.116"
local port = 25565

import mineyStrings
import math
import hash

global entities = 
{
	mobs =    \-> filterTable(this, \k,v->isInt(k) && v.etype == EntityType.Mob)
	players =  \-> filterTable(this, \k,v->isInt(k) && v.etype == EntityType.Player)
	vehicles =  \-> filterTable(this, \k,v->isInt(k) && v.etype == EntityType.Vehicle)
}

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
			writefln $ "MobSpawn EID: {} type: {} at {}/{}/{}", EID, MobType.toString(p.type), p.x / 32.0, p.y / 32.0, p.z / 32.0

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
		ent.x = p.x / 32.0
		ent.y = p.y / 32.0
		ent.z = p.z	/ 32.0
		entities[EID] = ent
		return
	}
	
	moveEntity(entities[EID], p)

}

global function onInit()
{
	connect(host, port)
}

global function onConnect(host, port)
{
	writefln $ "connected!!! ({}:{})", host, port
	
	send(Handshake(username))
	//setTimer(1000, attackMobs)
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
			send(Login(username, password))
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