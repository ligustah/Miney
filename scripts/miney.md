module miney

//standard library imports
import math
import time : timestamp
import os
import hash

local username = "Moep"
local password = "Password"
local host = "192.168.2.117"
local port = 25565

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

//username = randomString()

global time_connected = 0
global total_download = 0
global total_upload = 0

global namespace spawn
{
	x; y; z
}

global health = 0
global time = 0

local function printPosition(pos, fmt = "")
{
	writefln $ "{} {}/{}/{}", fmt, pos.x, pos.y, pos.z
}

global function onInit()
{
	emit("Init")
	connect(host, port)
	onHandshake(\p{
		send(Login(username, "password"))
		
		//this only needs to be done once
		return true
	})
}

global function onConnect(host, port)
{
	emit $ "Connect"
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
	emit $ "ConnectionClosed"
}

global function onPacket(packet)
{
	//writefln $ "getting packet: {}", PacketID.toString(packet.packetID)
	switch(packet.packetID)
	{
		case PacketID.Login:
			writefln $ "mapSeed: {}", packet.mapSeed
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
}

onTimeUpdate(\p{
	if(p.time % 24000 >= 12000)
	{
		send $ Chat $ "/time set 0"
	}
})

onChat(\p->	writeln $ p.message)

onLoginComplete(\{
	local wolves = {}
	setTimer(1000, \{
		foreach(k, v; entities.mobs())
		{
			if(v.type == MobType.Wolf && k !in wolves)
			{
				wolves[k] = true
				send $ Chat $ format $ "found wolf at {}/{}/{}", v.x / 32, v.y / 32, v.z / 32
			}
		}
	})
})