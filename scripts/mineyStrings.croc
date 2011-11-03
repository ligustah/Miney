module mineyStrings

local ns = [MobType, ObjectType, PacketID, WoolColor, DiggingStatus
		Face, ObjectType, InventoryType, InstrumentType, EntityType
		EntAction]

foreach(n; ns)
{
	local t = {}
	foreach(k, v; n)
	{
		t[v] = k
	}
	
	n.toString = function(vararg)
	{
		if(#vararg == 0)
			return toString(n)
		
		local s = t[vararg[0]]
		
		return isNull(s) ? "invalid" : s
	}
}