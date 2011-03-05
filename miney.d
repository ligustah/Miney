module miney;

import minid.api;
import minid.bind;

import tango.net.device.Socket;

import tango.io.selector.Selector;
import tango.io.stream.Buffered;
import tango.io.Stdout;

import tango.core.Thread;

import protocol;

void main()
{
	MDVM vm;
	
	auto t = openVM(&vm);
	loadStdlibs(t, MDStdlib.All);
	
	runFile(t, "miney.md");
	
	return;
	
	auto s = new Selector();
	s.open;
	
	Socket sock = new Socket();
	sock.connect("Andre-PC", 25565);
}