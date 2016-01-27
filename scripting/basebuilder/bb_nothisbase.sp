bool g_touchingBlock[MAXPLAYERS + 1];
bool g_bOnIce[MAXPLAYERS + 1];

public void NotHisBase_OnClientPutInServer(int client)
{
	g_bOnIce[client] = false;
}


public void NotHisBase_OnPluginStart()
{
	
	LoopAllPlayers(i)
	{
		g_bOnIce[i] = false;
	}

}

public void NotHisBase_PlayerSpawn(int client)
{
	
	if(PushPlayersEnabled())
	{
	
		if(GetClientTeam(client) == BUILDERS)
		{
			SDKHook(client, SDKHook_StartTouch, OnStartTouch);
			SDKHook(client, SDKHook_EndTouch, 	OnEndTouch);
		}
		
		else if(GetClientTeam(client) == ZOMBIES)
		{
			SDKUnhook(client, SDKHook_StartTouch, 	OnStartTouch);
			SDKUnhook(client, SDKHook_EndTouch, 	OnEndTouch);
		}

	}

}

public int OnEndTouch(int client, int ent)
{
	g_bOnIce[client] = false;
	
	char classname[50];
	GetEntityClassname(ent, classname, sizeof(classname));
	if(StrEqual(classname, "prop_dynamic"))
	{
		g_touchingBlock[client] = false;
		SetEntityGravity(client, 1.0);
	}
}

public int OnStartTouch(int client, int ent)
{
	
	if(!PushPlayersEnabled())
		return;
	
	if (!IsValidEntity(ent))
        return;
        
	if(GetClientTeam(client) == ZOMBIES)
		return;
		
	if(g_touchingBlock[client])
	{
		g_bOnIce[client] = true;
		SetEntityGravity(client, 10.0);	
	}
	
	char clsname[150];
	GetEntityClassname(ent, clsname, sizeof(clsname));

	if(StrEqual(clsname, "prop_dynamic"))
	{
		int owner = GetBlockOwner(ent);
	
		if(owner > 0)
		{
			int client2 = g_iInPartyWith[client];
			
			if(client2 == -1)
				client2 = client;
			
			if(owner != client && owner != client2)
			{
				g_bOnIce[client] = true;
				g_touchingBlock[client] = true;
				SlapPlayer(client, 0, false);
				SetEntityGravity(client, 10.0);	
			}
		}
		
	}
	
	
	return;
}


public void NotHisBase_OnGameFrame(){
	
	
	if(PushPlayersEnabled())
	{
		LoopAllPlayers(i)
		{
			if(g_bOnIce[i] && IsPlayerAlive(i) && GetClientTeam(i) == BUILDERS){ 
				if(GetEntityFlags(i) & FL_ONGROUND){ 
					float fVel[3]; 
					Entity_GetAbsVelocity(i, fVel); 
					fVel[2] = 0.0;
					GetEntPropVector(i, Prop_Data, "m_vecVelocity", fVel); 
					float newvel[3];
					NormalizeVector(fVel, newvel);
					ScaleVector(newvel, 250.0);
					TeleportEntity(i, NULL_VECTOR, NULL_VECTOR, newvel); 
				} 
			} 
	   	}
   }
    
} 

bool PushPlayersEnabled()
{
	if(g_iPushPlayersOfBlocks == 1)
	{
		return true;
	}
	
	else
	{
		return false;
	}
}