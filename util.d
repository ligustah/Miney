module util;

/**
	mixin this to add a set of getter-methods to a class,
	assuming the private field has the same name as the getter,
	with an underscore in front
	
	Example
	---
	private int _field;
	
	public int field()
	{
		return _field;
	}
	---
*/
template _getter(Names...)
{
	static if(Names.length == 0)
		const char[] _getter = "";
	else
	{
		//static assert(is(Names[0] == char[]));
		const char[] _getter = "public typeof(_" ~ Names[0] ~ ") " ~ Names[0] ~ "(){ return _" ~ Names[0] ~ ";}" ~ _getter!(Names[1..$]);
	}
}