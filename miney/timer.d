module miney.timer;

import tango.util.container.more.Heap;
import tango.time.Time;
import tango.time.WallClock;

import tango.io.Stdout;

/*
struct MDAction
{
	Action action;
	ulong mdRef;
	
	static MDAction opCall(ulong r)
	{
		MDAction a;
		
		a.mdRef = r;
		
		return a;
	}
}
*/

/* for some weird reason this would't work as a struct */
class MDAction
{
	Action action;
	ulong mdRef;
	
	this(ulong mdRef)
	{
		this.mdRef = mdRef;
	}
}

class Action
{
	Time 					time;
	bool function(void*) 	fnc;
	bool delegate(void*) 	dlg;
	void* 					data;
	bool 					circular = false;
	bool					unschedule = false;
	TimeSpan 				time_delta;

	bool opCall()
	{
		if(dlg)
		{
			return dlg(data);
		}
		else if(fnc)
		{
			return fnc(data);
		}
		else
			assert(false);
	}
	
	int opCmp(Action e)
	{
		return this.time > e.time;
	}
	
	private this()
	{}

	static Action opCall(Time time, bool function(void*) fnc, void* data = null)
	{
		Action e = new Action();

		e.time = time;
		e.fnc = fnc;
		e.data = data;
		return e;
	}

	static Action opCall(Time time, bool delegate(void*) dlg, void* data = null)
	{
		Action e = new Action();

		e.time = time;
		e.dlg = dlg;
		e.data = data;
		return e;
	}

	static Action opCall(TimeSpan span, bool function(void*) fnc, void* data = null, bool circular = false)
	{
		Action e = new Action();

		e.time = WallClock.now + span;
		e.time_delta = span;
		e.fnc = fnc;
		e.data = data;
		e.circular = circular;
		return e;
	}

	static Action opCall(TimeSpan span, bool delegate(void*) dlg, void* data = null, bool circular = false)
	{
		Action e = new Action();

		e.time = WallClock.now + span;
		e.time_delta = span;
		e.dlg = dlg;
		e.data = data;
		e.circular = circular;
		return e;
	}
}

class ActionScheduler
{
	MinHeap!(Action) _queue;

	public this()
	{
	}

	private final int Action_comparator(Action e1, Action e2)
	{
		return e1.time > e2.time;
	}

	public void schedule(Action e)
	{
		_queue.push(e);
	}

	public void unschedule(Action e)
	{
		e.unschedule = true;
	}

	debug void printActions()
	{
		Stdout("----------Actions----------").newline;
		
		auto copy = _queue.clone;
		
		while(copy.size > 0)
		{
			Action Action = copy.pop;
			Stdout.formatln("{} {} {:x}", Action.time, Action.circular, Action.data);
		}
	}

	package void tick()
	{
		Time now = WallClock.now;
		while(_queue.size > 0)
		{
			Action e = _queue.pop();

			if(e.unschedule) continue;

			if(e.time <= now)
			{
				if(!e() && e.circular && !e.unschedule)
				{
					e.time = WallClock.now + e.time_delta;
					_queue.push(e);
				}
			}
			else
			{
				_queue.push(e);
				break;
			}
		}
	}
}
