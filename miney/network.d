module miney.network;

import tango.io.selector.Selector;
import tango.io.Stdout;

import tango.time.Time;

import tango.core.Traits;
import tango.core.Variant;
import tango.core.Tuple;

import tango.util.container.LinkedList;

import miney.miney;
import miney.timer;

class Network
{
	private Selector			_selector;
	private LinkedList!(Miney)	_bots;
	private LinkedList!(Miney)	_removeMe;
	private ActionScheduler		_scheduler;
	
	public this()
	{
		_selector = new Selector();
		_selector.open();
		
		_bots = new LinkedList!(Miney);
		_removeMe = new LinkedList!(Miney);
		_scheduler = new ActionScheduler;
	}
	
	public void addAction(Action a)
	{
		_scheduler.schedule(a);
	}
	
	public void removeAction(Action a)
	{
		_scheduler.unschedule(a);
	}
	
	public void addBot(Miney m)
	{
		_bots.add(m);
	}
	
	public void registerBot(Miney m, Event events = Event.Read)
	{
		//Stdout.formatln("registering bot 0x{:b}", events);
		_selector.register(m, events);
	}
	
	public void removeBot(Miney m)
	{
		_removeMe.add(m);
	}
	
	public void run()
	{
		int count;
		TimeSpan timeout = TimeSpan.fromMillis(50);
		
		while(true)
		{
			_scheduler.tick();
			count = _selector.select(0.01);
			
			if(count > 0)
			{
				auto set = _selector.selectedSet;
				
				foreach(key; set)
				{
					Miney m = cast(Miney)key.conduit;
					if(key.isError)
					{
						Stdout("socket has error").newline;
					}
					if(key.isHangup)
					{
						Stdout("socket is hangup").newline;
					}
					if(key.isReadable)
					{
						m.handleRead();
					}
				}
			}
			
			foreach(bot; _bots)
			{
				bot.update();
			}
			
			if(count > 0)
			{
				auto set = _selector.selectedSet;
				foreach(key; set)
				{
					Miney m = cast(Miney)key.conduit;
					if(key.isWritable)
					{
						m.handleWrite();
					}
				}
			}
			
			Miney bot;
			
			while(_removeMe.take(bot))
			{
				_selector.unregister(bot);
				_bots.remove(bot);
			}
		}
	}
}