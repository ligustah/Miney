module miney

import mineyStrings
import math

global mobs = {}
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
	foreach(eid, mob; mobs)
	{
		local dis = distance(position, mob)
		
		if(dis <= 4)
		{
			writefln $ "mob distance {}", dis
			send(UseEntity(0, eid, true))
		}
	}
}

local function handleMob(p)
{
	local EID
	try
	{
		EID = p.EID
	}catch(e){ return }
	
	if(EID !in mobs)
	{
		if(p.packetID == PacketID.MobSpawn)
		{
			mobs[EID] = { }
			local mob = mobs[EID]
			writefln $ "MobSpawn EID: {} type: {} at {}/{}/{}", EID, MobType.toString(p.type), p.x, p.y, p.z
			mob.x = p.x
			mob.y = p.y
			mob.z = p.z
			mob.yaw = p.yaw
			mob.pitch = p.pitch
			mob.type = p.type
		}
		return
	}
	
	local mob = mobs[EID]
	
	if(		p.packetID == PacketID.EntityRelativeMove
		||	p.packetID == PacketID.EntityLookRelativeMove )
	{
		mob.x += p.dX / 32.0
		mob.y += p.dY / 32.0
		mob.z += p.dZ / 32.0
	}
	
	if(		p.packetID == PacketID.EntityLook
		||	p.packetID == PacketID.EntityLookRelativeMove )
	{
			mob.yaw = p.yaw
			mob.pitch = p.pitch
	}
}

global function onConnect(host, port)
{
	writefln $ "connected!!! ({}:{})", host, port
	local t = 0
	
	setTimer(1000, attackMobs)
	writeln $ setTimer(5000, function()
	{
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
	handleMob(packet)
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
			if(packet.EID in mobs)
			{
				writefln $ "{} {} died", MobType.toString(mobs[packet.EID].type), packet.EID
				mobs[packet.EID] = null
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