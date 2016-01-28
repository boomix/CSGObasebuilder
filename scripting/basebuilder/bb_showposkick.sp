Handle CheckTimer[MAXPLAYERS+1];

public void ShowPos_PlayerSpawn(int client)
{
	if(g_iKickPlayersWithShowPos == 1)
	{
		CheckTimer[client] = CreateTimer(1.0, CheckConvar, client, TIMER_REPEAT);
	}

}

public void ShowPos_OnClientPutInServer(int client)
{
	CheckTimer[client] = null;
}

public void ShowPos_OnClientDisconnect(int client)
{
	KillTimers(client);
}

public Action CheckConvar(Handle timer, any client)
{
	if(IsClientInGame(client) && IsPlayerAlive(client))
		QueryClientConVar(client, "cl_showpos", ConVar_QueryClient);
}

public int ConVar_QueryClient(QueryCookie cookie, int client, ConVarQueryResult result, char[] cvarName, char[] cvarValue)
{
	int value = StringToInt(cvarValue);
	
	if(value == 1)
	{
		char username[128];
		char steamid[64];
		GetClientName(client, username, sizeof(username));
		GetClientAuthId(client, AuthId_Steam2, steamid, sizeof(steamid));
		KickClient(client, "Please set cl_showpos 0");
		LogAction(client, -1, "%s [%s] Kicked because of cl_showpos 1", username, steamid);
	}
	
}


public void KillTimers(int client)
{

	if (CheckTimer[client] != null)
	{
		KillTimer(CheckTimer[client]);
		CheckTimer[client] = null;
	}

}