public void Teamswitch_RoundStart()
{
	LoopAllPlayers(i)
	{
		if(!IsClientReplay(i) && !IsClientSourceTV(i))
		{	
			if(GetClientTeam(i) == BUILDERS)
				g_bWasBuilderThisRound[i] = true;
			else
				g_bWasBuilderThisRound[i] = false;
		}
	}
}

public void Teamswitch_PlayerSpawn(int client)
{
	if(IsBuildTime() || IsPrepTime())
	{
		if(GetClientTeam(client) == BUILDERS)
			g_bWasBuilderThisRound[client] = true;
	}
}

public void Teamswitch_RoundEnd()
{

	LoopAllPlayers(i)
	{
		if(!IsClientReplay(i) && !IsClientSourceTV(i))
		{
			if(g_bWasBuilderThisRound[i])
			{
				CS_SwitchTeam(i, ZOMBIES);
			}
			else
			{
				CS_SwitchTeam(i, BUILDERS);
			}
		
			g_bWasBuilderThisRound[i] = false;
		}
	}

}

public void TeamSwitch_OnClientPutInServer(int client)
{
	g_bWasBuilderThisRound[client] = false;
}
