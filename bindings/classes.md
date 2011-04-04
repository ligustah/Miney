module classes

import io
import string
import all

local file = io.outFile("classes.d")

function makeCtor(sig : array)
{
	if(#sig == 0)
	{
		return "void function()"
	}
	else
	{
		return format("void function({})", string.joinArray(sig, ", "))
	}
}

function makeCtors(cl : table)
{
	if("constructor" !in cl)
		return ""
	
	local cons = makeCtor(cl.constructor)
	
	return format("WrapCtors!({}),", cons)
}

function makeProperty(name : string, prop : string)
{
	return format("WrapProperty!({}.{})", name, prop)
}

function makeProperties(name : string, cl : table)
{
	local mp = curry(makeProperty, name)
	if("properties" !in cl)
	{
		cl["properties"] = []
	}
	cl.properties ~= "packetID"
	
	local p = cl.properties.map(mp)
	
	return string.joinArray(p, ", ")
}

file.write(`
module bindings.classes;

import minid.bind;
import minid.api;

import miney.protocol;
import miney.network;

void initMineyClasses(MDVM* vm)
{
	MDThread* t = mainThread(vm);
	
	WrapGlobals!(`);

local cls = []

foreach(name, params; all.classes)
{
	local cl = ""
	local props = makeProperties(name, params)
	local ctors = makeCtors(params)
	
	cl = format(`
		WrapType!(
			{},
			"{}",
			{}`, name, name, ctors)
	cl ~= format(`
			{}
		)`, props)

	cls ~= cl
}

file.write(string.joinArray(cls, ","))
file.write(`
	)(t);
}`);

file.close()