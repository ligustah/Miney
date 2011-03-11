module miney

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
			writefln $ "MobSpawn EID: {} type: {}", packet.EID, packet.type
			break;
		case PacketID.PlayerPositionLook:
			writefln $ "PPL: X={} Y={} Z={}", packet.x, packet.y, packet.z
			break;
		default:
			break
	}
}