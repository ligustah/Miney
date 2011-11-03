module signal

local signals = {}

class Signal
{
	this()
	{
		:on = {}
		:after = {}
	}
		
	function addOn(f: function)
		:on[f] = true
	
	function addAfter(f: function)
		:after[f] = true
		
	function _call(tab : table, vararg)
	{
		foreach(f, _; tab, "modify")
		{
			if(f(vararg))
			{
				tab[f] = null
			}
		}
	}

	function opCall(vararg)
	{
		:_call(:on, vararg)
		:_call(:after, vararg)
	}
}

global function add(name)
{
	if(name in signals)
		return
	local onName = "on" ~ name
	local afterName = "after" ~ name
	signals[name] = Signal()
	
	_G.(onName) = function(func: function)
	{
		signals[name].addOn(func)
		
		return func
	}
	
	_G.(afterName) = function(func: function)
	{
		signals[name].addAfter(func)
		
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