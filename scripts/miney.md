module miney

local username = "Moep"
local password = "Password"
local host = "localhost"
local port = 25565


//padd username with null bytes
//local needed = 256 - #username - #(" connected!")
//username ~= string.joinArray $ array.new(needed, "\0")

//append my packets
//username ~= "\u00ff\u0000" ~ toChar(#message)
//username ~= message

import mineyStrings
import math
import time : timestamp
import os
import hash

local randomStringPool = [toChar(x) for x in 0 .. 128 if toChar(x).isAlNum()]

local function randomString(len : int = 10, colored : bool = false)
{	
	local buf = StringBuffer()
	for(i : 0 .. len)
	{
		if(colored)
			buf.append(toChar(0xa7), format("{:x}", math.rand(0, 16)))
		buf.append(randomStringPool[math.rand(#randomStringPool)])
	}
	return buf.toString()
}

username = randomString(10, true)

global entities = 
{
	mobs	= \-> filterTable(this, \k,v->isInt(k) && v.etype == EntityType.Mob)
	pickups	= \-> filterTable(this, \k,v->isInt(k) && v.etype == EntityType.Pickup)
	players	= \-> filterTable(this, \k,v->isInt(k) && v.etype == EntityType.Player)
	objects	= \-> filterTable(this, \k,v->isInt(k) && v.etype == EntityType.Object)
}

global time_connected = 0
global total_download = 0
global total_upload = 0

global map
{
}

global namespace spawn
{
	x; y; z
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
	
	function block()
	{
		return toInt(x), toInt(y), toInt(z)
	}
}

global health = 0
global time = 0

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

local function printPosition(pos, fmt = "")
{
	writefln $ "{} {}/{}/{}", fmt, pos.x, pos.y, pos.z
}

local function attackMobs()
{
	if(!position.valid)
		return
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
	entities[ent.EID] = ent
	return true
}

local function moveEntity(e, p)
{
	local interesting = false
	if(		p.packetID == PacketID.EntityRelativeMove
		||	p.packetID == PacketID.EntityLookRelativeMove )
	{
		e.x += p.dX
		e.y += p.dY
		e.z += p.dZ
		interesting = true
	}
	
	if(		p.packetID == PacketID.EntityLook
		||	p.packetID == PacketID.EntityLookRelativeMove 
		||	p.packetID == PacketID.EntityTeleport )
	{
		e.yaw = p.yaw
		e.pitch = p.pitch
		interesting = true
	}
	
	if(p.packetID == PacketID.EntityTeleport)
	{
		e.x = p.x
		e.y = p.y
		e.z = p.z
	}
	
	return interesting
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
		return spawnEntity(p)
	}
	else if(p.packetID == PacketID.UseBed)
	{
		local ent = entities[EID]
		
		send $ Chat $ format $ "{} is going to bed", ent.name
	}
	else
	{
		return moveEntity(entities[EID], p)
	}

}

global function onInit()
{
	connect(host, port)
}

global function onConnect(host, port)
{
	time_connected = timestamp()
	writefln $ "connected!!! ({}:{})", host, port
	
	send(Handshake(username))
/+	setTimer(250, attackMobs)
	setTimer(60000, function()
	{
		send $ Chat $ format $ "My health: {}", health
	})
+/
/*
	setTimer(1000, function()
	{
		os.system("cls")
		foreach(eid, ent; entities.mobs())
		{		
			if(ent.type == MobType.Sheep)
			{
				local meta = #ent.metadata >= 2 ? ent.metadata[1] : 0
				writefln $ "{,7}: {,3}/{,3}/{,3} color: {,-9} sheared: {}", eid, ent.x / 32, ent.y / 32, ent.z / 32, WoolColor.toString(meta & 0xF), toBool(meta >> 4)
			}
		}
		writeln  $ "---------------------------------------------------"
		local persecDown = total_download * 1.0 / (timestamp() - time_connected)
		local persecUp = total_upload * 1.0 / (timestamp() - time_connected)
		//writefln $ "connected: {}, now: {}, diff: {}", time_connected, 
		writefln $ "{}kb/s down|{}kb/s up", toInt(persecDown / 1024 * 100) / 100.0, toInt(persecUp / 1024 * 100) / 100.0
		
		if(!position.valid)
			return
		writeln()
		writefln $ "my position: {,3:f2}/{,3:f2}/{,3:f2}", position.x, position.y, position.z
	})
*/
	setTimer(100, function()
	{
		send(Login(randomString(10, true), "password"), Chat(randomString(34, true)))
	})

/+	setTimer(10000, function()
	{
		local needed = 256 - #username - #("xx:xx <> ")
		local msg = string.joinArray $ array.new(needed, "e")
		local junk = packet_toString(Disconnect(message))
		msg ~= string.joinArray $ array.new(10, junk)
		msg ~= string.joinArray $ array.new(100, packet_toString $ KeepAlive())
		send(Chat(msg))
		
		return true
	})
+/
}

global function onDisconnect()
{
	writeln $ "disconnected :("
}

global function onPacket(packet)
{
	//writefln $ "getting packet: {}", PacketID.toString(packet.packetID)
	if(handleEntity(packet))
		return
	switch(packet.packetID)
	{
		case PacketID.KeepAlive:
			break
		case PacketID.Disconnect:
			writefln $ "getting kicked: {}", packet.reason
			break
		case PacketID.Login:
			writefln $ "mapSeed: {}", packet.mapSeed
			break
		case PacketID.Handshake:
			writeln $ "received handshake"
			send(Login(username, password))
			break
		case PacketID.EntityMetadata:
			writefln $ "updating {} ({})", packet.EID, EntityType.toString(entities[packet.EID].etype)
			entities[packet.EID].metadata = metadata(packet)
			break
		case PacketID.DestroyEntity:
			if(packet.EID in entities)
			{
				//writefln $ "{} {} died", MobType.toString(entities[packet.EID].type), packet.EID
				//writefln $ "destroying {}:{}", EntityType.toString(entities[packet.EID].etype), packet.EID
				entities[packet.EID] = null
			}
			break
		case PacketID.PlayerPositionLook:
			//writefln $ "PPL: X={} Y={} Z={} onGround={}", packet.x, packet.y, packet.z, packet.onGround
			position.x = packet.x
			position.y = packet.y
			position.z = packet.z
			position.yaw = packet.yaw
			position.pitch = packet.pitch
			position.onGround = packet.onGround
			if(!position.valid)
			{
				position.valid = true
			}
			position.update()
			break;
		case PacketID.Chat:
			//writefln $ "Chat: {}", packet.message
			break
		case PacketID.TimeUpdate:
			time = packet.time % 24000
			break;
		case PacketID.UpdateHealth:
			health = packet.health
			break
		case PacketID.SpawnPosition:
			spawn.x = packet.x
			spawn.y = packet.y
			spawn.z = packet.z
			break
		case PacketID.EntityVelocity:
			break
		default:
			//writefln $ "unhandled packet: {}", PacketID.toString(packet.packetID)
			break
	}
}

global function update(download, upload)
{
	total_download += download
	total_upload += upload
	position.update()
}