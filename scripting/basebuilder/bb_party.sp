public void Party_OnPluginStart()
{
	RegConsoleCmd("sm_party", 		CMD_Party, 		"Party with someone!");
	RegConsoleCmd("sm_accept", 		CMD_Accept, 	"Accept party");
	RegConsoleCmd("sm_stopparty", 	CMD_StopParty, 	"Stop party with someone!");
}

public Action Party_OnClientPutInServer(int client)
{
	g_bIsInParty[client] = false;
	g_iInPartyWith[client] = -1;
	g_iDecalEntity[client] = -1;
	g_PartyInviter[client] = false;
}

public void Party_RoundStart()
{
	LoopAllPlayers(i)
	{
		int client2 = g_bIsInParty[i];
		g_bIsInParty[i] = false;
		g_bIsInParty[client2] = false;
		g_iInPartyWith[i] = -1;
		g_iInPartyWith[client2] = -1;
		g_iDecalEntity[i] = -1;
		
		//Remove decals from heads
		RemoveDecalAbovePlayer(i);
	}
}

public void Party_OnPlayerDeath(int client)
{
	RemoveDecalAbovePlayer(client);	
}

public void Party_OnClientDisconnect(int client)
{
	int client2 = g_iInPartyWith[client];
	
	RemoveDecalAbovePlayer(client);
	
	if(client >= 1 && !IsFakeClient(client) && client2 >= 1 && !IsFakeClient(client2)) {
		CPrintToChat(client2, "%s%T", Prefix, "Party left game", client2);
		g_bIsInParty[client] = false;
		g_bIsInParty[client2] = false;
		g_iInPartyWith[client] = -1;
		g_iInPartyWith[client2] = -1;
		g_iDecalEntity[client] = -1;
	}
}

public Action CMD_Party(int client, int args)
{
	//Client is already in party!
	if(g_bIsInParty[client])
	{
		CPrintToChat(client, "%s%T", Prefix, "Party Im in party", client);
		return Plugin_Handled;	
	}
	
	Menu partymenu = new Menu(MenuHandler_PartyMenu);
	SetMenuTitle(partymenu, "Select party friend");
	
	LoopAllPlayers(i)
	{
		if(!g_bIsInParty[i] && GetClientTeam(client) == GetClientTeam(i) && client != i)
		{
			char username[MAX_NAME_LENGTH];
			GetClientName(i, username, sizeof(username));
			
			char userID[10];
			IntToString(i, userID, sizeof(userID));
			
			partymenu.AddItem(userID, username);
		}
	}
	
	partymenu.Display(client, 0);
	
	return Plugin_Handled;
}


public int MenuHandler_PartyMenu(Menu menu, MenuAction action, int client, int item) 
{
	switch(action)
	{
		case MenuAction_Select:
		{
			char info[32];
			GetMenuItem(menu, item, info, sizeof(info));
			
			int client2 = StringToInt(info);
			
			if(GetClientTeam(client) == BUILDERS && GetClientTeam(client2) == BUILDERS)
			{
				if(IsClientInGame(client2))
				{
					char client_username[MAX_NAME_LENGTH];
					GetClientName(client, client_username, sizeof(client_username));
					
					char client2_username[MAX_NAME_LENGTH];
					GetClientName(client2, client2_username, sizeof(client2_username));
		
					CPrintToChat(client, "%s%T", Prefix, "Party invited", client, client2_username);
					CPrintToChat(client2, "%s%T", Prefix, "Party got invite", client, client_username);
					
					g_iInPartyWith[client] = client2;
					g_iInPartyWith[client2] = client;
					
					g_PartyInviter[client] = true;
					
					CreateTimer(20.0, ResetInvite, client);
					CreateTimer(20.0, ResetInvite, client2);
				} else {
					CPrintToChat(client, "%s%T", Prefix, "Party not found", client);
				}
			} else {
				char username[MAX_NAME_LENGTH];
				GetClientName(client2, username, sizeof(username));
				CPrintToChat(client, "%s%T", Prefix, "Party different teams", client, username);
			}
			
		}
	}
}

public Action ResetInvite(Handle tmr, any client)
{
	if(!g_bIsInParty[client])
	{
		g_iInPartyWith[client] = -1;
		g_PartyInviter[client] = false;
	}
}

public Action CMD_Accept(int client, int args)
{

	int client2 = g_iInPartyWith[client];

	if(g_iInPartyWith[client] > 0)
	{
		
		if(g_PartyInviter[client])
		{
			CPrintToChat(client, "Don't accept when you invite someone!");
			return Plugin_Handled;	
		}
		
		
		if(!IsClientInGame(client2))
		{
			CPrintToChat(client, "%s%T", Prefix, "Party not found", client);
			return Plugin_Handled;
		}
		
		if(GetClientTeam(client) != BUILDERS || GetClientTeam(client2) != BUILDERS)
		{
			char username[MAX_NAME_LENGTH];
			GetClientName(client2, username, sizeof(username));
			CPrintToChat(client, "%s%T", Prefix, "Party different teams", client, username);
			return Plugin_Handled;
		}
		
		if(g_bIsInParty[client])
		{
			CPrintToChat(client, "%s%T", Prefix, "Party Im in party", client);
			return Plugin_Handled;
		}
		
		if(g_bIsInParty[client2])
		{
			char username[MAX_NAME_LENGTH];
			GetClientName(client2, username, sizeof(username));
			CPrintToChat(client, "%s%T", Prefix, "Party already in different party", client, username);
			return Plugin_Handled;		
		}
		
		
		g_bIsInParty[client] = true;
		g_bIsInParty[client2] = true;
		g_iInPartyWith[client] = client2;
		g_iInPartyWith[client2] = client;
		
		char client_username[MAX_NAME_LENGTH];
		GetClientName(client, client_username, sizeof(client_username));
		
		char client2_username[MAX_NAME_LENGTH];
		GetClientName(client2, client2_username, sizeof(client2_username));
		
		CPrintToChat(client, "%s%T", Prefix, "Party success", client, client2_username);
		CPrintToChat(client2, "%s%T", Prefix, "Party success2", client2, client_username);
		
		//Create decals over player heads, that they see with who they are in party
		CreateTimer(1.0, Timer_SpawnSprite, client);
		CreateTimer(1.0, Timer_SpawnSprite, client2);
		
		
	} else 
		CPrintToChat(client, "%s%T", Prefix, "Party writes accept without invite", client);
	
	return Plugin_Handled;

}

public Action Timer_SpawnSprite(Handle timer, any client)
{
	if(IsClientInGame(client) && IsPlayerAlive(client) && !IsFakeClient(client))
	{
		g_iDecalEntity[client] = SpawnDecalAbovePlayer(client, "materials/overlays/friends2.vmt");
		char Gname[20];
		IntToString(g_iInPartyWith[client], Gname, sizeof(Gname));
		Entity_SetGlobalName(g_iDecalEntity[client], Gname);
		SDKHook(g_iDecalEntity[client], SDKHook_SetTransmit, ShowFriendOverlay);	
	}
}

public Action ShowFriendOverlay(int ent, int client)
{
	char Gname[20];
	Entity_GetGlobalName(ent, Gname, sizeof(Gname));
	int client2 = StringToInt(Gname);
	
	if(client2 == client)
		return Plugin_Continue;
	else
		return Plugin_Handled;
}


public Action CMD_StopParty(int client, int args)
{
	if(g_bIsInParty[client])
	{
		int client2 = g_iInPartyWith[client];
		g_bIsInParty[client] = false;
		g_bIsInParty[client2] = false;
		g_iInPartyWith[client] = -1;
		g_iInPartyWith[client2] = -1;
		
		CPrintToChat(client, "%s%T", Prefix, "Party left", client);
		CPrintToChat(client2, "%s%T", Prefix, "Party left2", client2);
		
		RemoveDecalAbovePlayer(client);
		RemoveDecalAbovePlayer(client2);

	}	
	
	return Plugin_Handled;
}


//DECAL FUNCTIONS

int SpawnDecalAbovePlayer(int client, const char sDecal[PLATFORM_MAX_PATH])
{
	if(!IsClientInGame(client) || !IsPlayerAlive(client) || GetClientTeam(client) < 2)
		return -1;
	
	int iEnt = CreateEntityByName("env_sprite");
	if(iEnt == -1)
		return -1;
	
	SetEntityModel(iEnt, sDecal);
	DispatchKeyValue(iEnt, "GlowProxySize", "1");
	DispatchKeyValue(iEnt, "rendercolor", "118 147 163");
	DispatchKeyValue(iEnt, "renderamt", "140");
	DispatchKeyValue(iEnt, "rendermode", "5");
	DispatchKeyValue(iEnt, "renderfx", "0");
	DispatchKeyValueFloat(iEnt, "framerate", 15.0);
	DispatchKeyValueFloat(iEnt, "scale", 0.1);
	char sBuffer[32];
	Format(sBuffer, sizeof(sBuffer), "1337client_%d", iEnt);
	DispatchKeyValue(client, "targetname", sBuffer);
	float fMin[3] = {-50.0, -50.0, 0.0};
	float fMax[3] = {50.0, 50.0, 100.0};
	SetEntPropVector(iEnt, Prop_Send, "m_vecMins", fMin);
	SetEntPropVector(iEnt, Prop_Send, "m_vecMaxs", fMax);
	SetEntProp(iEnt, Prop_Send, "m_nSolidType", 2);
	int iEffects = GetEntProp(iEnt, Prop_Send, "m_fEffects");
	SetEntProp(iEnt, Prop_Send, "m_fEffects", (iEffects | 32));
	DispatchSpawn(iEnt);
	ActivateEntity(iEnt);
	float fOrigin[3];
	GetClientEyePosition(client, fOrigin);
	
	// Place 30 units above player's head.
	fOrigin[2] += 30.0;
	
	TeleportEntity(iEnt, fOrigin, NULL_VECTOR, NULL_VECTOR);
	SetVariantString(sBuffer);
	AcceptEntityInput(iEnt, "SetParent");
	
	return iEnt;
}

bool RemoveDecalAbovePlayer(int client)
{
	if(!IsClientInGame(client))
		return false;
	
	char sBuffer[32];
	GetEntPropString(client, Prop_Data, "m_iName", sBuffer, sizeof(sBuffer));
	
	// That player doesn't have a sprite above his head, which has been spawned with the above stock.
	if(StrContains(sBuffer, "1337client_") != 0)
	{
		DispatchKeyValue(client, "targetname", "");
		return false;
	}
	
	int iEnt = StringToInt(sBuffer[11]);
	if(iEnt <= 0 || !IsValidEntity(iEnt) || !IsValidEdict(iEnt))
		return false;
	
	GetEdictClassname(iEnt, sBuffer, sizeof(sBuffer));
	if(!StrEqual(sBuffer, "env_sprite"))
	{
		DispatchKeyValue(client, "targetname", "");
		return false;
	}
	
	AcceptEntityInput(iEnt, "Kill");
	DispatchKeyValue(client, "targetname", "");
	return true;
}