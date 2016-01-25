public void OldBlocks_OnPrepTimeStart()
{
	RemoveOldBlocks(1, "prep");	
}

public void OldBlocks_OnPlayerDeath(int client)
{
	if(IsClientInGame(client) && !IsFakeClient(client)) 
	{
		if(client >= 1) {
			
			//If not in party, remove his blocks
			if(!g_bIsInParty[client])
				RemoveOldBlocks(client, "death");
		
			//If he's in party
			else if(g_bIsInParty[client])
			{
				//Get with who he is in party
				int client2 = g_iInPartyWith[client];
				
				if(!IsPlayerAlive(client2) || GetClientTeam(client2) == ZOMBIES)
				{
					RemoveOldBlocks(client, "death");
					RemoveOldBlocks(client2, "death");	
				}
			
			}

		}	
	}
	
}

public void RemoveOldBlocks(int client, char type[10])
{
	
	if(g_iRemoveNotUsedBlocks == 1) {
	
		if(StrEqual(type, "prep")) {
			int ent = 0;
			while ((ent = FindEntityByClassname(ent, "prop_dynamic")) != INVALID_ENT_REFERENCE) {
				if(IsValidEntity(ent) && IsValidEdict(ent)) {
					char entname[50];
					Entity_GetName(ent, entname, sizeof(entname));
					
					char entglobaname[50];
					Entity_GetGlobalName(ent, entglobaname, sizeof(entglobaname));
					
					if (StrEqual(entname, "") && StrEqual(entglobaname, "")) {
						if(IsValidEntity(ent)) {
							Entity_Kill(ent);
						}
					}
					
				}
			}
		}
	
	}
	
	
	if(g_iRemoveBlockAfterDeath == 1) {
	
		if(StrEqual(type, "death")) {
			if(!IsBuildTime() && !IsPrepTime()) {
				int ent = 0;
				while ((ent = FindEntityByClassname(ent, "prop_dynamic")) != INVALID_ENT_REFERENCE) {
					if(IsValidEntity(ent) && ent != -1) {
						char entname[50];
						Entity_GetName(ent, entname, sizeof(entname));
						
						char entglobaname[50];
						Entity_GetGlobalName(ent, entglobaname, sizeof(entglobaname));
						
						int entity = StringToInt(entname);
						int entitygn = StringToInt(entglobaname);
						
						if(entity == client || entitygn == client) {
							Entity_Kill(ent);
						}
					}
				}
			
			}
		}
	
	}

}
