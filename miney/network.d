module miney.network;

import tango.io.selector.Selector;
import tango.io.stream.Data;
import tango.io.Stdout;

import tango.time.Time;

import tango.core.Traits;
import tango.core.Variant;
import tango.core.Tuple;

import tango.util.container.LinkedList;

import miney.miney;
import miney.protocol;
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
			count = _selector.select(timeout);
			
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

class MinecraftDataOutput : DataOutput
{
	this(OutputStream outs)
	{
		super(outs);
		endian(Network);
	}
	
	public alias string putString;
	
	public size_t string(char[] str)
	{
		int16(str.length);
		return write(str);
	}
	
	public typeof(this) put(char[] str)
	{
		string(str);
		
		return this;
	}
	
	public typeof(this) put(bool b)
	{
		putBool(b);
		
		return this;
	}
	
	public typeof(this) put(int i)
	{
		putInt(i);
		
		return this;
	}
	
	public typeof(this) put(long l)
	{
		putLong(l);
		
		return this;
	}
	
	public typeof(this) put(short s)
	{
		putShort(s);
		
		return this;
	}
	
	public typeof(this) put(float f)
	{
		putFloat(f);
		
		return this;
	}
	
	public typeof(this) put(double d)
	{
		putFloat(d);
		
		return this;
	}
	
	public typeof(this) put(byte b)
	{
		putByte(b);
		
		return this;
	}
	
	public typeof(this) put(PacketID id)
	{
		putByte(id);
		
		return this;
	}
	
	public typeof(this) put(Sendable s)
	{
		put(s.packetID);
		s.send(this);
		
		return this;
	}
	
	public alias put opOr;
}

class MinecraftDataInput : DataInput
{
	this(InputStream ins)
	{
		super(ins);
		endian(Network);
	}
	
	public alias string getString;
	
	public char[] string()
	{
		short len = int16;
		char[] str = new char[len];
		read(cast(void[])str);
		
		return str;
	}
	
	public typeof(this) get(out char[] str)
	{
		str = string();
		
		return this;
	}
	
	public typeof(this) get(out bool b)
	{
		b = getBool();
		
		return this;
	}
	
	public typeof(this) get(out int i)
	{
		i = getInt();
		
		return this;
	}
	
	public typeof(this) get(out long l)
	{
		l = getLong();
		
		return this;
	}
	
	public typeof(this) get(out byte b)
	{
		b = getByte();
		
		return this;
	}
	
	public typeof(this) get(out short s)
	{
		s = getShort();
		
		return this;
	}
	
	public typeof(this) get(out float f)
	{
		f = getFloat();
		
		return this;
	}
	
	public typeof(this) get(out double d)
	{
		d = getDouble();
		
		return this;
	}
	
	public alias get opOr;
	
	public Variant[] metadata()
	{
		Variant[] vars;
		byte x;
		int n = 0;
		
		while(true)
		{
			this|x;
			
			if(x == 0x7F) // end of metadata
				break;
				
			//Stdout.format("{}: ", n++);
				
			byte y = x >> 5;
			
			switch(y)
			{
				case 0:
					vars ~= Variant(getByte);
					break;
				case 1:
					vars ~= Variant(getShort);
					break;
				case 2:
					vars ~= Variant(getInt);
					break;
				case 3:
					vars ~= Variant(getFloat);
					break;
				case 4:
					vars ~= Variant(getString);
					break;
				case 5:
					vars ~= Variant([Variant(getShort), Variant(getByte), Variant(getShort)]);
					break;
				case 6:
					vars ~= Variant([Variant(getInt), Variant(getInt), Variant(getInt)]);
					break;
				default:
					assert(0, "invalid metadata");
			}
		}
		
		return vars;
	}
}

/*
interface Sendable
{
	public void send(MinecraftDataOutput);
	public PacketID packetID();
}*/

class Sendable
{
	public void send(MinecraftDataOutput output)
	{
		assert(false, "no no no");
	}
	
	public PacketID packetID()
	{
		assert(false, "no no no");
		return PacketID.Login;
	}
}

interface Receivable
{
	public PacketID packetID();
	public size_t minSize();
	public int receive(MinecraftDataInput);
}

class MetadataPacket
{
	public Variant[] metadata()
	{
		assert(false, "not implemented");
	}
}