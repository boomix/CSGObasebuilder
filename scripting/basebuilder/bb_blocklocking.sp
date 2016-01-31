public void Locking_OnClientPutInServer(int client)
{
	clientlocks[client] = 0;	
}

public void Locking_RoundStart()
{
	LoopAllPlayers(i)
		clientlocks[i] = 0;
}

void LockBlock(int client)
{

	if (IsAdmin(client) || IsPlayerAlive(client) && GetClientTeam(client) == BUILDERS && IsBuildTime())
	{
		int entity = GetTargetBlock(client);
		if (entity != -1)
		{
			int owner = GetBlockOwner(entity);
			
			// block has now owner yet: Lock it!
			if (owner <= 0)
			{
				if (clientlocks[client] < g_iMaxLocks)
				{
					ColorBlockByEntity(client, entity, false);
					SetBlockOwner(entity, client);
					PrintHintText(client, "%T", "Locked", client);
					clientlocks[client]++;
				} 
				else  PrintHintText(client, "%T", "Max locked", client, g_iMaxLocks);
			}
			// Block has already a owner
			else
			{
				// Another player owns this block
				if (client != owner && !IsAdmin(client)) 
				{
					char username[MAX_NAME_LENGTH];
					GetClientName(owner, username, sizeof(username));
					PrintHintText(client, "%T", "Already locked", client, username);
				}
				
				//Unlock block this player owns	it	
				else if(!g_OnceStopped[client])
				{
					ColorBlockByEntity(client, entity, true);
					SetBlockOwner(entity, 0);
					PrintHintText(client, "%T", "Unlocked", client);
					clientlocks[client]--;
				}
			}
		}
	}

}

void ColorBlockByEntity(int client, int entity, bool reset)
{
	
	if(IsValidEntity(entity) && client != -1) 
	{
		SetEntityRenderMode(entity, RENDER_TRANSCOLOR);
		
		if (reset)
			Entity_SetRenderColor(entity, 255, 255, 255, 255);
		else Entity_SetRenderColor(entity, colorr[client], colorg[client], colorb[client], 255);
	}
	
}