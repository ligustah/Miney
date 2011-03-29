module miney

//standard library imports
import math
import time : timestamp
import os
import hash

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

import signal : emit

signal.add("Init")
signal.add("Connect")
signal.add("ConnectionClosed")

import position
import map
import entities
import mineyStrings

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

username = randomString()

global time_connected = 0
global total_download = 0
global total_upload = 0

global namespace spawn
{
	x; y; z
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

onEntityTeleport(\p -> 
	modifyEntity(\e
	{
		e.x = p.x
		e.y = p.y
		e.z = p.z
	})
)

global function onInit()
{
	emit("Init")
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
	switch(packet.packetID)
	{
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
			writefln $ "updating {} ({})", packet.EID, EntityType.toString(entities.get(packet.EID).etype)
			entities[packet.EID].metadata = metadata(packet)
			break
		case PacketID.Chat:
			//writefln $ "Chat: {}", packet.message
			break
		case PacketID.TimeUpdate:
			time = packet.time % 24000
			break;
		case PacketID.UpdateHealth:
			health = packet.health
			break
		default:
			//writefln $ "unhandled packet: {}", PacketID.toString(packet.packetID)
			break
	}
	try
		emit((PacketID.toString $ packet.packetID), packet)
	catch(e)
	{
		writeln("caught exception: ", e)
		writeln(thread.traceback())
	}

}

global function update(download, upload)
{
	total_download += download
	total_upload += upload
	position.update()
}