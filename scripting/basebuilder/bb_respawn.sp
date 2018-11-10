bool g_RoundEnd;

public void Respawn_OnClientPutInServer(int client)
{
	g_bFirstTeamJoin[client] = true;
}

public void Respawn_PlayerTeam(int client)
{
	if(g_bFirstTeamJoin[client] && !IsClientSourceTV(client)) 
	{
		g_bFirstTeamJoin[client] = false;
		DataPack pack = new DataPack();
		pack.WriteCell(GetClientUserId(client));
		pack.WriteCell(-1);
		CreateTimer(5.0, Respawn_Player, pack);
	}		
}

public Action CMD_Respawn(int client, int args)
{
	if(IsClientInGame(client) && client > 0)
	{
		//Command !respawn
		if(IsBuildTime() || IsPrepTime()) {
			CS_RespawnPlayer(client);
			return Plugin_Handled;
		}
		
		CPrintToChat(client, "%s%T", Prefix, "Respawn", client);
	}
	return Plugin_Continue;
}

public void Respawn_OnPrepTimeStart()
{

	//Respawn builders on Prep start
	LoopAllPlayers(i)
	{
		if(GetClientTeam(i) == BUILDERS)
			CS_RespawnPlayer(i);
	}

}

public void Respawn_OnPrepTimeEnd()
{
	//Teleports zombies to CT spawn on Prep end
	LoopAllPlayers(i)
	{
		if(GetClientTeam(i) == ZOMBIES)
		{
			TeleportEntity(i, CTSpawnOrg, CTSpawnAng, NULL_VECTOR);
		}
	}
	
}

//Respawns dead player
public void Respawn_OnPlayerDeath(int victim, int attacker)
{
	DataPack pack = new DataPack();
	pack.WriteCell(GetClientUserId(victim));
	pack.WriteCell(GetClientUserId(attacker));
	CreateTimer(1.0, Respawn_Player, pack);
}

public Action Respawn_Player(Handle tmr, DataPack pack)
{
	pack.Reset();
	int client = GetClientOfUserId(pack.ReadCell());
	int attacker = GetClientOfUserId(pack.ReadCell());
	
	if(IsClientInGame(client) && !IsPlayerAlive(client))
	{
		if(!g_RoundEnd && client != 0 && IsClientInGame(client)) {
			if(GetClientTeam(client) == ZOMBIES)
			{
				//Default respawn in Build/Prep time for ZOMBIES
				if(IsBuildTime() || IsPrepTime()) 
					CS_RespawnPlayer(client);
				
				//Teleport ZOMBIES to CT spawn after their death
				if(!IsBuildTime() && !IsPrepTime())
				{
					CS_RespawnPlayer(client);
					TeleportEntity(client, CTSpawnOrg, CTSpawnAng, NULL_VECTOR);
				}
			}
			
			else if(GetClientTeam(client) == BUILDERS)
			{
				//Default respawn in Build/Prep time for BUILDERS
				if(IsBuildTime() || IsPrepTime())
					CS_RespawnPlayer(client);
		
				//Move BUILDER to ZOMBIES after death and respawn
				if(!IsBuildTime() && !IsPrepTime())
				{
					CS_SwitchTeam(client, ZOMBIES);
					CS_RespawnPlayer(client);
					TeleportEntity(client, CTSpawnOrg, CTSpawnAng, NULL_VECTOR);
					
					if(attacker > 0) {
						// FORWARD
						Call_StartForward(g_OnBuilderInfected);
						Call_PushCell(client);
						Call_PushCell(attacker);
					}
					
				}
			}
		}
	}
	
}

public void Respawn_RoundEnd()
{
	g_RoundEnd = true;
}

public void Respawn_RoundStart()
{
	g_RoundEnd = false;	
}

void GetTeleportCoords()
{	
	int entindex;
	char name[150];
	
	while ((entindex = FindEntityByClassname(entindex, "info_teleport_destination")) != -1)
	{
		if(IsValidEntity(entindex) && entindex != -1) 
		{
			GetEntPropString(entindex, Prop_Data, "m_iName", name, sizeof(name));
			if (StrEqual(name, "teleport_lobby"))
			{
				GetEntPropVector(entindex, Prop_Send, "m_vecOrigin", 	CTSpawnOrg);
				GetEntPropVector(entindex, Prop_Data, "m_angRotation", 	CTSpawnAng); 

				CTSpawnOrg[2] += 20;
			}
		}
	}
}