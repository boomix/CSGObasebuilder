void CreateNatives()
{
	CreateNative("BaseBuilder_IsBuildTime", Native_IsBuildTime);
	CreateNative("BaseBuilder_IsPrepTime", Native_IsPrepTime);
}

public int Native_IsBuildTime(Handle plugin, int numParams)
{
	return g_IsBuildTime;
}

public int Native_IsPrepTime(Handle plugin, int numParams)
{
	return g_IsPrepTime;
}
