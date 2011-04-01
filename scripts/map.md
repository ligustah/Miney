module map

import time

import signal : emit
signal.add("MapDownloadFinished")

local count = 0
local preCount = 0
local start

onMapChunk(\p{
	start = time.timestamp()
	writefln $ "starting map download"
	local id = setTimer(2000, \{
		send $ Chat $ format $ "[MAP] downloading {}%", count * 100 / 441
	})
	onMapDownloadFinished(\{
		send $ Chat $ "Map download finished"
		stopTimer(id)
	})
	return true
})

@onMapChunk
local function mapChunk(p)
{
	count++
	//writefln $ "mapchunk {} {} * {} * {}", count, p.sizeX, p.sizeY, p.sizeZ
	
	if(count == 441)
	{
		emit("MapDownloadFinished")
		return true
	}
}

/*
@onPreChunk
local function preChunk(packet)
{
	preCount++
	writefln $ "prechunk {}", preCount
}
*/