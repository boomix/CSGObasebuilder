float g_fGravity[MAXPLAYERS + 1];

public void LadderGravity_PlayerSpawn(int client)
{
	g_fGravity[client] = GetEntityGravity(client);
}

public void LadderGravity_OnGameFrame()
{

	LoopAllPlayers(i)
	{
		if(GetClientTeam(i) == ZOMBIES && IsPlayerAlive(i))
		{
			if(GetEntityMoveType(i) & MOVETYPE_LADDER)
			{
				SetEntityGravity(i, g_fGravity[i]);
			}
		}
	}

}