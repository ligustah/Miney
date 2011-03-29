module tracker

import entities

local players = {}

onNamedEntitySpawn(\p {	players[p.name] = p.EID })

onDestroyEntity(\p
{
	local name
	foreach(k,v; players)
	{
		if(v == p.EID)
		{
			name = k
			break
		}
	}
	players[name] = null
})

function get(eid : int) = players[eid]