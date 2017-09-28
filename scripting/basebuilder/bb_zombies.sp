public void Zombies_OnClientPutInServer(int client)
{
	g_iClientClass[client] = 1;
}

public Action CMD_ZMClass(int client, int args)
{

	if(GetClientTeam(client) == ZOMBIES)
	{

		Menu zmmenu = new Menu(MenuHandler_ZombieClass);
		SetMenuTitle(zmmenu, "Zombie class");
	 	
	 	kvZombies.Rewind();
		if (!kvZombies.GotoFirstSubKey())
			return Plugin_Handled;
	 
		char ClassID[10];
		char name[150];
		do
		{
			kvZombies.GetSectionName(ClassID, sizeof(ClassID));
			kvZombies.GetString("name", name, sizeof(name));
			zmmenu.AddItem(ClassID, name);
		} while (kvZombies.GotoNextKey());
	 
		zmmenu.Display(client, 0);
	}

	return Plugin_Continue;
	

}

public int MenuHandler_ZombieClass(Menu menu, MenuAction action, int client, int item) 
{
	switch(action)
	{
		case MenuAction_Select:
		{
			char info[32];
			GetMenuItem(menu, item, info, sizeof(info));
			
			int SelectedZMClass = StringToInt(info);
			
			//Check for VIP class
			kvZombies.Rewind();
			char s_SelectedClass[10];
			IntToString(SelectedZMClass, s_SelectedClass, sizeof(s_SelectedClass));
			if (!kvZombies.JumpToKey(s_SelectedClass)) return;

			char flags[40] = "";
			kvZombies.GetString("flags", flags, sizeof(flags));
			
			if(StrEqual(flags, ""))
			{
				g_iClientClass[client] = SelectedZMClass;
			
				if(IsBuildTime() || IsPrepTime()) {
					CS_RespawnPlayer(client);
				}
				else
					CPrintToChat(client, "%s%T", Prefix, "Class change after death", client);	
			} else
			{
				if(HasPlayerFlags(client, flags))
				{
					g_iClientClass[client] = SelectedZMClass;
				
					if(IsBuildTime() || IsPrepTime()) {
						CS_RespawnPlayer(client);
					}
					else
						CPrintToChat(client, "%s%T", Prefix, "Class change after death", client);		
				} else
					CPrintToChat(client, "%s%T", Prefix, "VIP class fail change", client);
			}
			
			
		}
	}
}

public void Zombies_PlayerSpawn(int client)
{
	if(GetClientTeam(client) == CS_TEAM_CT)
		SetPlayerAsBuilder(client);
	else if(GetClientTeam(client) == CS_TEAM_T)
		SetPlayerAsZombie(client);
}

void SetPlayerAsZombie(int client)
{
	
	kvZombies.Rewind();
	char clientclass[10];
	IntToString(g_iClientClass[client], clientclass, sizeof(clientclass));
	if (!kvZombies.JumpToKey(clientclass)) 
	{
		PrintToServer("Class not found!");
		return;		
	}
		
	char zmName[100];
	char zmGravity[10];
	char zmSpeed[10];
	char zmHeath[10];
	char zmModel[PLATFORM_MAX_PATH + 1];
	char zmArms[PLATFORM_MAX_PATH + 1];
	char flags[40] = "";
	flags = "";
	kvZombies.GetString("name", 		zmName, 	sizeof(zmName));
	kvZombies.GetString("gravity", 		zmGravity, 	sizeof(zmGravity));
	kvZombies.GetString("speed", 		zmSpeed, 	sizeof(zmSpeed));
	kvZombies.GetString("health", 		zmHeath, 	sizeof(zmHeath));
	kvZombies.GetString("model_path", 	zmModel, 	sizeof(zmModel));
	kvZombies.GetString("arms_path", 	zmArms, 	sizeof(zmArms));
	
	float fZmGravity; 
	float fZmSpeed;
	fZmGravity	 = StringToFloat(zmGravity);
	fZmSpeed	 = StringToFloat(zmSpeed);
	int iZmHealth = StringToInt(zmHeath);
	
	if(!IsModelPrecached(zmArms))
		PrecacheModel(zmArms, true);
	SetPlayerArms(client, zmArms);
	SetEntityGravity(client, fZmGravity);
	SetEntityHealth(client, iZmHealth);
	SetEntPropFloat(client, Prop_Data, "m_flLaggedMovementValue", fZmSpeed);
	if(!IsModelPrecached(zmModel))
		PrecacheModel(zmModel, true);
	SetEntityModel(client, zmModel);
	CPrintToChat(client, "%s%T", Prefix, "New zombie", client, zmName);
	
	PlayerLastSpeed[client] = fZmSpeed;


}

void SetPlayerAsBuilder(int client)
{
	SetEntityGravity(client, 1.0);
	SetPlayerArms(client, "models/weapons/t_arms_professional.mdl");
	SetEntityHealth(client, 100);
	SetEntPropFloat(client, Prop_Data, "m_flLaggedMovementValue", 1.0);
	PlayerLastSpeed[client] = 1.0;
}


// ** 	ARM UPDATE FUNCTIONS 	** //

public void SetPlayerArms(int client, char[] arms)
{
	RemoveAllPlayerWeapons(client);
	Client_RemoveWeapon(client, "weapon_knife", true);
	
	SetEntPropString(client, Prop_Send, "m_szArmsModel", arms);
	CreateTimer(0.1, Give_Knife, client);
}

public Action Give_Knife(Handle tmr, any client)
{
	if(IsClientInGame(client))
		GivePlayerItem(client, "weapon_knife");	
}

public bool HasPlayerFlags(int client, char flags[40])
{
	
	if(StrContains(flags, "a") != -1)
	{
		if(Client_HasAdminFlags(client, ADMFLAG_RESERVATION))
		{
			return true;
		}
	}		
	else if(StrContains(flags, "b") != -1)
	{
		if(Client_HasAdminFlags(client, ADMFLAG_GENERIC))
		{
			return true;
		}
	}
	else if(StrContains(flags, "c") != -1)
	{
		if(Client_HasAdminFlags(client, ADMFLAG_KICK))
		{
			return true;
		}
	}
	else if(StrContains(flags, "d") != -1)
	{
		if(Client_HasAdminFlags(client, ADMFLAG_BAN))
		{
			return true;
		}
	}
	else if(StrContains(flags, "e") != -1)
	{
		if(Client_HasAdminFlags(client, ADMFLAG_UNBAN))
		{
			return true;
		}
	}	
	else if(StrContains(flags, "f") != -1)
	{
		if(Client_HasAdminFlags(client, ADMFLAG_SLAY))
		{
			return true;
		}
	}	
	else if(StrContains(flags, "g") != -1)
	{
		if(Client_HasAdminFlags(client, ADMFLAG_CHANGEMAP))
		{
			return true;
		}
	}
	else if(StrContains(flags, "h") != -1)
	{
		if(Client_HasAdminFlags(client, 128))
		{
			return true;
		}
	}		
	else if(StrContains(flags, "i") != -1)
	{
		if(Client_HasAdminFlags(client, ADMFLAG_CONFIG))
		{
			return true;
		}
	}
	else if(StrContains(flags, "j") != -1)
	{
		if(Client_HasAdminFlags(client, ADMFLAG_CHAT))
		{
			return true;
		}
	}		
	else if(StrContains(flags, "k") != -1)
	{
		if(Client_HasAdminFlags(client, ADMFLAG_VOTE))
		{
			return true;
		}
	}	
	else if(StrContains(flags, "l") != -1)
	{
		if(Client_HasAdminFlags(client, ADMFLAG_PASSWORD))
		{
			return true;
		}
	}
	else if(StrContains(flags, "m") != -1)
	{
		if(Client_HasAdminFlags(client, ADMFLAG_RCON))
		{
			return true;
		}
	}		
	else if(StrContains(flags, "n") != -1)
	{
		if(Client_HasAdminFlags(client, ADMFLAG_CHEATS))
		{
			return true;
		}
	}		
	else if(StrContains(flags, "z") != -1)
	{
		if(Client_HasAdminFlags(client, ADMFLAG_ROOT))
		{
			return true;
		}
	}		
	else if(StrContains(flags, "o") != -1)
	{
		if(Client_HasAdminFlags(client, ADMFLAG_CUSTOM1))
		{
			return true;
		}
	}		
	else if(StrContains(flags, "p") != -1)
	{
		if(Client_HasAdminFlags(client, ADMFLAG_CUSTOM2))
		{
			return true;
		}
	}
	else if(StrContains(flags, "q") != -1)
	{
		if(Client_HasAdminFlags(client, ADMFLAG_CUSTOM3))
		{
			return true;
		}
	}		
	else if(StrContains(flags, "r") != -1)
	{
		if(Client_HasAdminFlags(client, ADMFLAG_CUSTOM4))
		{
			return true;
		}
	}			
	else if(StrContains(flags, "s") != -1)
	{
		if(Client_HasAdminFlags(client, ADMFLAG_CUSTOM5))
		{
			return true;
		}
	}			
	else if(StrContains(flags, "t") != -1)
	{
		if(Client_HasAdminFlags(client, ADMFLAG_CUSTOM6))
		{
			return true;
		}
	}
	
	return false;
}