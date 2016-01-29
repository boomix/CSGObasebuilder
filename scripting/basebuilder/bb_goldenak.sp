void GiveGoldenAk(int client)
{
	//FPVMI_SetClientModel(client, "weapon_ak47", Golden_ViewModel, Golden_WorldModel);
	int weapon = GetPlayerWeaponSlot(client, CS_SLOT_PRIMARY);
	if(IsValidEntity(weapon))
	{
		RemovePlayerItem(client, weapon);
		AcceptEntityInput(weapon, "Kill");
	}
	GivePlayerItem(client, "weapon_ak47");
	g_bHasGoldenAK[client] = true;
}

public void GoldenAk_OnClientPutInServer(int client)
{
	g_bHasGoldenAK[client] = false;
	g_bHasSuperKnife[client] = false;
	SDKHook(client, SDKHook_OnTakeDamage, Golden_OnTakeDamage);
}

public Action Golden_OnTakeDamage(int victim, int &attacker, int &inflictor, float &damage, int &damagetype, int &weapon, float damageForce[3], float damagePosition[3], int damagecustom)
{
	//Golden AK
	if(weapon != -1 && IsValidEntity(weapon))
	{
		char classname[50];
		GetEntityClassname(weapon, classname, sizeof(classname));
	
		if(StrEqual(classname, "weapon_ak47") && g_bHasGoldenAK[attacker] && IsClientInGame(victim) && GetClientTeam(victim) == ZOMBIES){
			damage *= 1.5;
			return Plugin_Changed;
		}
	}
	
	return Plugin_Continue;
		
}

public void GoldenAk_RoundStart()
{
	LoopAllPlayers(i)
	{
		if(g_bHasGoldenAK[i]) 
		{
			g_bHasGoldenAK[i] = false;
			//FPVMI_RemoveViewModelToClient(i, "weapon_ak47");
			//FPVMI_RemoveWorldModelToClient(i, "weapon_ak47");
		}
	}
}

public Action BB_WeaponFire(Handle event, const char[] name, bool dontBroadcast) 
{
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	
	char weapon[50];
	GetEventString(event, "weapon", weapon, sizeof(weapon));

	if(StrEqual(weapon, "weapon_ak47") && g_bHasGoldenAK[client])
		CreateBeam(client);
}

//Another function inside bb_nofalldamage.sp

/// ** MAIN FUNCTIONS **//
//	not written by me	**//
public Action CreateBeam(any client)
{
	float f_playerViewOrigin[3];
	GetClientAbsOrigin(client, f_playerViewOrigin);
	if(GetClientButtons(client) & IN_DUCK)
		f_playerViewOrigin[2] += 35;
	else
		f_playerViewOrigin[2] += 52;

	float f_playerViewDestination[3];		
	GetPlayerEye(client, f_playerViewDestination);

	float distance = GetVectorDistance( f_playerViewOrigin, f_playerViewDestination );

	float percentage = 0.4 / ( distance / 100 );

	float f_newPlayerViewOrigin[3];
	f_newPlayerViewOrigin[0] = f_playerViewOrigin[0] + ( ( f_playerViewDestination[0] - f_playerViewOrigin[0] ) * percentage );
	f_newPlayerViewOrigin[1] = f_playerViewOrigin[1] + ( ( f_playerViewDestination[1] - f_playerViewOrigin[1] ) * percentage );
	f_newPlayerViewOrigin[2] = f_playerViewOrigin[2] + ( ( f_playerViewDestination[2] - f_playerViewOrigin[2] ) * percentage );

	int color[4];
	color[0] = 218; 
	color[1] = 165;
	color[2] = 32;
	color[3] = 255;
	
	float life;
	life = 0.1;

	float width;
	width = 10.0;

	f_newPlayerViewOrigin[1] += 5.0;
	
	TE_SetupBeamPoints( f_newPlayerViewOrigin, f_playerViewDestination, g_sprite, 0, 0, 0, life, width, 0.0, 1, 0.0, color, 0 );
	TE_SendToAll();
	
	return Plugin_Continue;
}

bool GetPlayerEye(int client, float pos[3])
{
	float vAngles[3];
	float vOrigin[3];
	GetClientEyePosition(client,vOrigin);
	GetClientEyeAngles(client, vAngles);
	
	Handle trace = TR_TraceRayFilterEx(vOrigin, vAngles, MASK_SHOT, RayType_Infinite, TraceEntityFilterPlayer2);
	
	if(TR_DidHit(trace))
	{
		TR_GetEndPosition(pos, trace);
		CloseHandle(trace);
		return true;
	}
	CloseHandle(trace);
	return false;
}

public bool TraceEntityFilterPlayer2(int entity, int contentsMask)
{
    return entity > GetMaxClients();
}