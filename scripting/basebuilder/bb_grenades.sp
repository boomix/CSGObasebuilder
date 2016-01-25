#define	FreezeTime			5.0
#define FreezeDistance		220.0
#define FreezeColor 		{0,186,247,255}
#define FragColor 			{255,75,75,255}

public void Grenades_OnPluginStart()
{
	HookEvent("decoy_started", 			Event_DecoyStarted);
	HookEvent("hegrenade_detonate", 	Event_GrenadeStarted, EventHookMode_Pre);
	
	AddNormalSoundHook(GrenadeSoundHook);
}

//Create trail on grenade throw
public void OnEntityCreated(int entity, const char[] classname)
{
	if(StrEqual(classname, "decoy_projectile")) 
		SDKHook(entity, SDKHook_SpawnPost, OnEntitySpawned);
		
	else if(StrEqual(classname, "hegrenade_projectile"))
		SDKHook(entity, SDKHook_SpawnPost, OnEntitySpawned);
}

public void OnEntitySpawned(int iGrenade)
{
	char classname[50];
	GetEntityClassname(iGrenade, classname, sizeof(classname));

	if(StrEqual(classname, "decoy_projectile")) 
	{
		int client = GetEntPropEnt(iGrenade, Prop_Send, "m_hOwnerEntity");
		TE_SetupBeamFollow(iGrenade, BeamSprite,	0, 1.0, 1.0, 10.0, 5, FreezeColor);
		TE_SendToAll();	
		RemovePlayerGrenade(client, "weapon_decoy");
	}
	
	else if(StrEqual(classname, "hegrenade_projectile")) 
	{
		int client = GetEntPropEnt(iGrenade, Prop_Send, "m_hOwnerEntity");
		TE_SetupBeamFollow(iGrenade, BeamSprite,	0, 1.0, 1.0, 10.0, 5, FragColor);
		TE_SendToAll();	
		RemovePlayerGrenade(client, "weapon_hegrenade");
	}
	

}

public void RemovePlayerGrenade(int client, char classname[50])
{
	if(client >= 1) {
		int grenade = Client_GetWeapon(client, classname);
		if(grenade != -1)
		{
			DataPack pack;
			CreateDataTimer(1.0, RemoveGrenade, pack);
			pack.WriteCell(client);
			pack.WriteCell(grenade);
		}
	}
}

public Action RemoveGrenade(Handle tmr, Handle pack)
{
	ResetPack(pack);
	int client = ReadPackCell(pack);
	int grenade = ReadPackCell(pack);
	
	RemovePlayerItem(client, grenade); 
	AcceptEntityInput(grenade, "Kill");		
}

//When grenade explodes
public Action Event_DecoyStarted(Handle event, const char[] name, bool dontBroadcast) 
{
	int entity = GetEventInt(event, "entityid");

	float org[3];
	GetEntPropVector(entity, Prop_Send, "m_vecOrigin", org);
	
	//Create ring
	TE_SetupBeamRingPoint(org, 10.0, FreezeDistance, BeamSprite, BeamSprite, 1, 1, 0.2, 10.0, 0.1, FreezeColor, 0, 0);
	TE_SendToAll();
	
	//Create light
	//LightCreate(org);
	DataPack pack;
	CreateDataTimer(0.2, CreateLight, pack);
	pack.WriteFloat(org[0]);
	pack.WriteFloat(org[1]);
	pack.WriteFloat(org[2]);
	
	//Freeze players
	FreezePlayers(org);
	
	//Create freeze sound
	EmitSoundToAllAny(SOUND_FREEZE);
	
	//Kill entitys
	AcceptEntityInput(entity, "kill");
	//AcceptEntityInput(soundEntity, "kill");

	return Plugin_Handled;
	
}

public Action Event_GrenadeStarted(Handle event, const char[] name, bool dontBroadcast) 
{
	int entity = GetEventInt(event, "entityid");
	SetEntPropFloat(entity, Prop_Send, "m_flDamage", 700.0); 
	SetEntPropFloat(entity, Prop_Send, "m_DmgRadius", 170.0); 
	
	//Create ring
	float org[3];
	GetEntPropVector(entity, Prop_Send, "m_vecOrigin", org);
	TE_SetupBeamRingPoint(org, 10.0, FreezeDistance, BeamSprite, BeamSprite, 1, 1, 0.2, 10.0, 0.1, FragColor, 0, 0);
	TE_SendToAll();
	
	BurnPlayers(org);
}


public Action CreateLight(Handle timer, Handle pack)
{
	float org[3];

	ResetPack(pack);
	org[0] = ReadPackFloat(pack);
	org[1] = ReadPackFloat(pack);
	org[2] = ReadPackFloat(pack);

	LightCreate(org);
}

void BurnPlayers(float org[3])
{
	LoopAllPlayers(i)
	{
		if (IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i) == ZOMBIES)
		{	
			float PlayerOrg[3];
			GetClientAbsOrigin(i, PlayerOrg);
			
			if (GetVectorDistance(org, PlayerOrg) <= FreezeDistance - 20.0)
			{
				IgniteEntity(i, 19.8);
				float speed;
				speed = GetClientSpeed(i);
				SetClientSpeed(i, 0.8);
				
				DataPack pack;
				CreateDataTimer(19.8, Resetspeed, pack);
				pack.WriteCell(i);
				pack.WriteFloat(speed);
			}
		}
	}

}

public Action Resetspeed(Handle tmr, Handle pack)
{
	float speed;
	ResetPack(pack);
	int client = ReadPackCell(pack);
	speed = ReadPackFloat(pack);	
	
	SetClientSpeed(client, speed);
}

void FreezePlayers(float org[3])
{
	LoopAllPlayers(i)
	{
		if (IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i) == ZOMBIES)
		{	
			float PlayerOrg[3];
			GetClientAbsOrigin(i, PlayerOrg);
			
			if (GetVectorDistance(org, PlayerOrg) <= FreezeDistance - 20.0)
			{
				SetEntityMoveType(i, MOVETYPE_NONE);
				Entity_SetRenderColor(i, 0, 186, 247, 255);
				CreateTimer(FreezeTime, ResetMovetype, i);	
			}
		}
	}

}

public Action ResetMovetype(Handle tmr, any client)
{
	SetEntityMoveType(client, MOVETYPE_WALK);
	Entity_SetRenderColor(client, 255, 255, 255, 255);
	EmitSoundToClientAny(client, SOUND_FREEZE_EXPLODE);
}

void LightCreate(float pos[3])   
{  
	int entity = CreateEntityByName("light_dynamic"); 
	
	DispatchKeyValue(entity, "_light", "0 186 247");  
	DispatchKeyValue(entity, "brightness", "7");  
	DispatchKeyValueFloat(entity, "spotlight_radius", FreezeDistance - 20.0);  
	DispatchKeyValueFloat(entity, "distance", FreezeDistance - 50.0);  
	DispatchKeyValue(entity, "style", "0");   
	DispatchSpawn(entity); 
	AcceptEntityInput(entity, "TurnOn"); 
	pos[2] += 50;
	TeleportEntity(entity, pos, NULL_VECTOR, NULL_VECTOR); 
	
	CreateTimer(FreezeTime, Remove_Light, entity);

}

public Action Remove_Light(Handle tmr, any entity)
{
	if(IsValidEdict(entity))
		AcceptEntityInput(entity, "kill");	
}


//Sound shit
public Action GrenadeSoundHook(int clients[64], int &numClients, char sample[PLATFORM_MAX_PATH], int &entity, int &channel, float &volume, int &level, int &pitch, int &flags)
{
	char entityname[100];
	GetEntityClassname(entity, entityname, sizeof(entityname));

	if(StrEqual(entityname, "decoy_projectile"))
		return Plugin_Handled;
	
	return Plugin_Continue;
}


void SetClientSpeed(int client, float speed)
{
	SetEntPropFloat(client, Prop_Data, "m_flLaggedMovementValue", speed);	
}

float GetClientSpeed(int client)
{
	float speed = GetEntPropFloat(client, Prop_Data, "m_flLaggedMovementValue");
	return speed;
}