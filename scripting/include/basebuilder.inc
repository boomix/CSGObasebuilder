#if defined _basebuilder_included
 #endinput
#endif
#define _basebuilder_included

native bool BaseBuilder_IsPrepTime();
native bool BaseBuilder_IsBuildTime();

forward void BaseBuilder_OnBuildTimeStart();
forward void BaseBuilder_OnPrepTimeStart();
forward void BaseBuilder_OnPrepTimeEnd();
forward void BaseBuilder_OnBuilderInfected(int builder, int zombie);

public void __pl_basebuilder__SetNTVOptional() 
{
	MarkNativeAsOptional("BaseBuilder_IsPrepTime");
	MarkNativeAsOptional("BaseBuilder_IsBuildTime");
}