module signal

local signals = {}

class Signal
{
	this()
		:listeners = {}
		
	function add(f: function)
		:listeners[f] = true

	function opCall(vararg)
	{
		foreach(f, _; :listeners, "modify")
		{
			if(f(vararg))
			{
				:listeners[f] = null
			}
		}
	}
}

global function add(name)
{
	local evName = "on" ~ name
	signals[name] = Signal()
	
	_G.(evName) = function(func: function)
	{
		signals[name].add(func)
		
		return func
	}
}

global function emit(sig, vararg)
{
	signals[sig](vararg)
}

foreach(name; receivables)
{
	add(name)
}