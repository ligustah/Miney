module position

import signal : emit
signal.add("LoginComplete")

global x, y, z, yaw, pitch, onGround

local valid = false

function update()
{
	if(valid)
	{
		//writefln("sending position: {}/{}/{} {}", x, y, z, onGround)
		send(PlayerPositionLook(x, y, z, y + 1.62, yaw, pitch, onGround))
	}
}

function block()
{
	return toInt(x), toInt(y), toInt(z)
}

local function ppl(p)
{
	x = p.x
	y = p.y
	z = p.z
	yaw = p.yaw
	pitch = p.pitch
	onGround = p.onGround
}

onPlayerPositionLook(\p
{
	ppl(p)
	emit $ "LoginComplete"
	onPlayerPositionLook(ppl)
	
	return true // remove this one
})