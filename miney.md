module miney

import mineyStrings

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

global function onPacket(packet)
{
	switch(packet.packetID)
	{
		case PacketID.Login:
			writefln $ "mapSeed: {}", packet.mapSeed
			break
		case PacketID.Handshake:
			writeln $ "received handshake"
			break;
		case PacketID.MobSpawn:
			writefln $ "MobSpawn EID: {} type: {}", packet.EID, MobType.toString(packet.type)
			mobs[packet.EID] = packet.type
			break;
		case PacketID.EntityMetadata:
			writefln $ "updating {}", packet.EID
		case PacketID.DestroyEntity:
			if(packet.EID in mobs)
			{
				writefln $ "{} {} died", MobType.toString(mobs[packet.EID]), packet.EID
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
	if(position.valid)
	{
		//position.onGround = true
		position.x += factor * counter
		counter += factor
		
		if(counter >= 20 || counter <= 0)
		{
			factor *= -1
		}
	}
	position.update()
	
	if(time.microTime() - lastAttack > 1_000_000)
	{
		//writeln $ "attack!"
		foreach(eid, type; mobs)
		{
			send(UseEntity(0, eid, true))
		}
		
		lastAttack = time.microTime()
	}	
}