module bindings.all;

import minid.api;
import minid.bind;

import bindings.enums;
import bindings.classes;

import protocol;

void initMineyVM(MDVM* vm)
{
	initMineyEnums(vm);
	initMineyClasses(vm);
}