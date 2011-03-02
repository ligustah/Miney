module miney;

import minid.api;
import minid.bind;

void main()
{
	MDVM vm;
	
	auto t = openVM(&vm);
	loadStdlibs(t, MDStdlib.All);
	
	runFile(t, "miney.md");
}