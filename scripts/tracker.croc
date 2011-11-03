module tracker

import entities

local players = {}

onNamedEntitySpawn(\p {	players[p.name] = p.EID })

onDestroyEntity(\p
{
	local name = entities.get(p.EID)
	
	players[name] = null
})

function get(eid : int) = players[eid]