module map

@onMapChunk
local function preChunk(packet)
{
	writefln $ "mapchunk {}/{} {}", packet.x, packet.y
}