#define DMG_FALL   (1 << 5)

public void NoFallDamage_OnPluginStart()
{
	LoopAllPlayers(i)
		SDKHook(i, SDKHook_OnTakeDamage, OnTakeDamage);
}

public void NoFallDamege_OnClientPutInServer(int client) {
	SDKHook(client, SDKHook_OnTakeDamage, OnTakeDamage);
}

public Action OnTakeDamage(int victim, int &attacker, int &inflictor, float &damage, int &damagetype, int &weapon, float damageForce[3], float damagePosition[3], int damagecustom)
{

	//Fall damage
	if (damagetype & DMG_FALL)
	{
		return Plugin_Handled;
	}
	
	return Plugin_Continue;
	
}

public Action SoundHook(int clients[64], int &numClients, char sound[PLATFORM_MAX_PATH], int &Ent, int &channel, float &volume, int &level, int &pitch, int &flags)
{
    if (StrEqual(sound, "player/damage1.wav", false)) return Plugin_Stop;
    if (StrEqual(sound, "player/damage2.wav", false)) return Plugin_Stop;
    if (StrEqual(sound, "player/damage3.wav", false)) return Plugin_Stop;
    
    return Plugin_Continue;
}