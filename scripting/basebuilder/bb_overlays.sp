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

public void Overlay_OnGameFrame()
{
	LoopAllPlayers(i) {
		if(b_PlayerStuck[i]) {
			
			float ang[3];
			ang[0] = 0.0;
			ang[1] = 0.0;
			ang[2] = 0.0;
		
			TeleportEntity(i, NULL_VECTOR, ang, NULL_VECTOR);
			PrintToChat(i, "\x1 Please set:\x3 cl_showpos 0");
			
		}
	}
			
}

public void ConVar_QueryClient(QueryCookie cookie, int client, ConVarQueryResult result, const char[] cvarName, const char[] cvarValue)
{
	if(IsClientInGame(client))
	{
		if(result == ConVarQuery_Okay)
		{
			bool bCurrent = StringToInt(cvarValue) ? true : false;
			
			if(bCurrent) {
				b_PlayerStuck[client] = true;
				SetEntPropFloat(client, Prop_Data, "m_flLaggedMovementValue", 0.0);
			}
			else {
				b_PlayerStuck[client] = false;
				SetEntPropFloat(client, Prop_Data, "m_flLaggedMovementValue", PlayerLastSpeed[client]);
			}
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