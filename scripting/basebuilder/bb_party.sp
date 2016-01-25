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
	}
}

public void Party_OnClientDisconnect(int client)
{
	int client2 = g_iInPartyWith[client];
	
	if(client >= 1 && !IsFakeClient(client) && client2 >= 1 && !IsFakeClient(client2)) {
		CPrintToChat(client2, "%s%T", Prefix, "Party left game", client2);
		g_bIsInParty[client] = false;
		g_bIsInParty[client2] = false;
		g_iInPartyWith[client] = -1;
		g_iInPartyWith[client2] = -1;
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
	}
}

public Action CMD_Accept(int client, int args)
{

	int client2 = g_iInPartyWith[client];

	if(g_iInPartyWith[client] > 0)
	{
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
		
	} else 
		CPrintToChat(client, "%s%T", Prefix, "Party writes accept without invite", client);
	
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

	}	
	
	return Plugin_Handled;
}