module handler

import io
import string
import all

local file = io.outFile("handler.d")

local h = []

foreach(name, params; all.classes)
{
	local hndlr = ""
	if("constructor" in params)
		continue
	hndlr = format(`	case PacketID.{}:
		m.invoke("onPacket", cast({})pkt);
		break;`, name, name)
	//writeln(hndlr)
}