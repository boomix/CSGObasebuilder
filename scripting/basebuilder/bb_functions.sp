public void BaseBuilder_OnBuildTimeStart()
{
	Timer_OnBuildTimeStart();
	Sounds_OnBuildTimeStart();
	Respawn_RoundStart();
	Teamswitch_RoundStart();
	GoldenAk_RoundStart();
	Locking_RoundStart();
	Party_RoundStart();
	
}

public void BaseBuilder_OnPrepTimeStart()
{
	Timer_OnPrepTimeStart();
	Sounds_OnPrepTimeStart();
	BlockMoving_OnPrepTimeStart();
	OldBlocks_OnPrepTimeStart();
	Respawn_OnPrepTimeStart();
	Weapons_OnPrepTimeStart();
	
}

public void BaseBuilder_OnPrepTimeEnd()
{
	Sounds_OnPrepTimeEnd();
	Respawn_OnPrepTimeEnd();

}

public Action BB_PlayerDeath(Handle event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	int attacker = GetClientOfUserId(GetEventInt(event, "attacker"));
	
	Sounds_OnPlayerDeath(client, attacker);
	OldBlocks_OnPlayerDeath(client);
	Respawn_OnPlayerDeath(client);
	Money_OnPlayerDeath(attacker);

}

public Action BB_RoundEnd(Handle event, const char[] name, bool dontBroadcast) 
{
	int winner_team = GetEventInt(event, "winner");
	
	Sounds_RoundEnd(winner_team);
	Teamswitch_RoundEnd();
	Respawn_RoundEnd();
	
}

public Action BB_PlayerHurt(Handle event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	int attacker = GetClientOfUserId(GetEventInt(event, "attacker"));
	int dmg_health = GetEventInt(event, "dmg_health");
	char sWeapon[50]; 
	GetEventString(event, "weapon", sWeapon, sizeof(sWeapon), "");
	
	Sounds_PlayerHurt(attacker);
	ResetArmor_PlayerHurt(client);
	SuperKnife_PlayerHurt(client, attacker, dmg_health, sWeapon);

}

public void OnClientPutInServer(int client)
{
	
	NoFallDamege_OnClientPutInServer(client);
	Zombies_OnClientPutInServer(client);
	Weapons_OnClientPutInServer(client);
	TeamSwitch_OnClientPutInServer(client);
	Blockmoving_OnClientPutInServer(client);
	Party_OnClientPutInServer(client);
	GoldenAk_OnClientPutInServer(client);
	Respawn_OnClientPutInServer(client);
	Help_OnClientPutInServer(client);
	NotHisBase_OnClientPutInServer(client);

}

public void OnClientDisconnect(int client) 
{
	if(client != 0)
		Party_OnClientDisconnect(client);
	
}

public Action BB_PlayerSpawn(Handle event, const char[] name, bool dontBroadcast) 
{
	int client = GetClientOfUserId(GetEventInt(event, "userid"));

	Radar_PlayerSpawn(client);
	Zombies_PlayerSpawn(client);
	Teamswitch_PlayerSpawn(client);
	BlockMoving_PlayerSpawn(client);
	Shop_PlayerSpawn(client);
	Help_FirstSpawn(client);
	NotHisBase_PlayerSpawn(client);
	LadderGravity_PlayerSpawn(client);
	RandomAngle_PlayerSpawn(client);

}

public void OnGameFrame()
{
	NotHisBase_OnGameFrame();
	LadderGravity_OnGameFrame();
	
}