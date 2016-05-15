public void OnClientPostAdminCheck(int client)
{
	if(IsClientInGame(client) && !IsFakeClient(client))
	{
		g_hTimer_Query[client] = CreateTimer(1.0, Timer_QueryClient, client);	
	}
}

public void OverLays_OnCofigsExecuted()
{
	LoopAllPlayers(i)
		if(IsClientInGame(i) && !IsFakeClient(i))
			g_hTimer_Query[i] = CreateTimer(1.0, Timer_QueryClient, i);	
}

public void ConVar_QueryClient(QueryCookie cookie, int client, ConVarQueryResult result, const char[] cvarName, const char[] cvarValue)
{
	if(IsClientInGame(client))
	{
		if(result == ConVarQuery_Okay)
		{
			bool bCurrent = StringToInt(cvarValue) ? true : false;
			
			if(bCurrent)
				Overlay(client, "overlays/white");
			else
				Overlay(client, "");
			
		}
		g_hTimer_Query[client] = CreateTimer(1.0, Timer_QueryClient, client);
	}
}


public void OverLays_OnClientDisconnect(int client)
{
	if(g_hTimer_Query[client] != INVALID_HANDLE && CloseHandle(g_hTimer_Query[client]))
		g_hTimer_Query[client] = INVALID_HANDLE;
}

public Action Timer_QueryClient(Handle timer, any client)
{
	g_hTimer_Query[client] = INVALID_HANDLE;
	if(IsClientInGame(client))
		QueryClientConVar(client, "cl_showpos", ConVar_QueryClient);

	return Plugin_Continue;
}



void Overlay(int client, char[] material = "")
{
    if (IsClientInGame(client) && !IsFakeClient(client))
    {
        int iFlags = GetCommandFlags("r_screenoverlay");
        SetCommandFlags("r_screenoverlay", iFlags & ~FCVAR_CHEAT);
        if (!StrEqual(material, "")) ClientCommand(client, "r_screenoverlay \"%s\"", material);
        else ClientCommand(client, "r_screenoverlay \"\"");
        SetCommandFlags("r_screenoverlay", iFlags);
    }
}  