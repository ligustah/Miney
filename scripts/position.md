module position

import signal
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

onPlayerPositionLook(\p
{
	x = p.x
	y = p.y
	z = p.z
	yaw = p.yaw
	pitch = p.pitch
	onGround = p.onGround
	
	if(!valid)
	{
		valid = true
		emit $ "LoginComplete"
	}
})