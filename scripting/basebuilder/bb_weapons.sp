char g_LastPrimaryWeapon[MAXPLAYERS + 1][50];
char g_LastSecondaryWeapon[MAXPLAYERS + 1][50];

public Action CMD_Guns(int client, int args)
{
	if(GetClientTeam(client) == BUILDERS && !IsPrepTime() && !IsBuildTime())
	{
		int weapon = GetPlayerWeaponSlot(client, CS_SLOT_PRIMARY);
		if(!IsValidEntity(weapon))
		{
			ShowWeaponMenu(client);	
		}
	}
}

public void Weapons_OnClientPutInServer(int client)
{
	g_LastPrimaryWeapon[client] = "";
	g_LastSecondaryWeapon[client] = "";
}

public void RemoveAllPlayerWeapons(int client)
{
	//Removing primary weapon
	int weapon = GetPlayerWeaponSlot(client, CS_SLOT_PRIMARY);
	if(weapon > 0) {
		RemovePlayerItem(client, weapon);
		RemoveEdict(weapon);	
	}
	
	//Removing secondary weapon
	int weapon2 = GetPlayerWeaponSlot(client, CS_SLOT_SECONDARY);
	if(weapon2 > 0) {
		RemovePlayerItem(client, weapon2);
		RemoveEdict(weapon2);	
	}
	
	//Removing grenades
	int weapon3 = GetPlayerWeaponSlot(client, CS_SLOT_GRENADE);
	if(weapon3 > 0) {
		RemovePlayerItem(client, weapon3);
		RemoveEdict(weapon3);	
	}
}


public void Weapons_OnPrepTimeStart()
{
	LoopAllPlayers(i) 
	{
		if(GetClientTeam(i) == BUILDERS) 
		{
			ShowWeaponMenu(i);
		}
	}	
}

void ShowWeaponMenu(int client)
{
	Menu menu = new Menu(MenuHandlers_PrimaryWeapon);
	SetMenuTitle(menu, "Primary weapon");
	
	if(!StrEqual(g_LastPrimaryWeapon[client], "") && !StrEqual(g_LastSecondaryWeapon[client], ""))
		menu.AddItem("last", "Last weapons");
	
	menu.AddItem("weapon_ak47", 			"AK-47");
	menu.AddItem("weapon_aug", 				"AUG");
	menu.AddItem("weapon_famas", 			"Famas");
	menu.AddItem("weapon_galilar", 			"Gallil");
	menu.AddItem("weapon_m4a1", 			"M4A1");
	menu.AddItem("weapon_mac10", 			"MAC10");
	menu.AddItem("weapon_mp7", 				"MP7");
	menu.AddItem("weapon_mp9", 				"MP9");
	menu.AddItem("weapon_awp", 				"AWP");
	menu.AddItem("weapon_sg556", 			"SG556");
	menu.AddItem("weapon_ssg08", 			"Scout");
	menu.AddItem("weapon_ump45", 			"UPM-45");
	menu.AddItem("weapon_m4a1_silencer", 	"M4A1-S");
	
	SetMenuExitButton(menu, false);
	menu.Display(client, 0);
}

public int MenuHandlers_PrimaryWeapon(Menu menu, MenuAction action, int client, int item) 
{
	switch(action)
	{
		case MenuAction_Select:
		{
			if(GetClientTeam(client) == BUILDERS && IsPlayerAlive(client) && !IsBuildTime()) 
			{
				char info[32];
				GetMenuItem(menu, item, info, sizeof(info));
				
				if (StrEqual(info, "last"))
				{
					GivePlayerItem(client, g_LastSecondaryWeapon[client]);
					GivePlayerItem(client, g_LastPrimaryWeapon[client]);
					return false;
				}
				
				//Set new last weapon
				g_LastPrimaryWeapon[client] = info;
				GivePlayerItem(client, info);
				
				Menu menu2 = new Menu(MenuHandlers_SecondaryWeapon);
				SetMenuTitle(menu, "Secondary weapon");
				menu2.AddItem("weapon_deagle", 		"Deagle");
				menu2.AddItem("weapon_revolver", 	"Revolver");
				menu2.AddItem("weapon_elite", 		"Dual burretas");
				menu2.AddItem("weapon_fiveseven",	"Five seven");
				menu2.AddItem("weapon_glock", 		"Glock");
				menu2.AddItem("weapon_hkp2000", 	"USP");
				menu2.AddItem("weapon_p250", 		"P250");
				menu2.AddItem("weapon_tec9", 		"TEC-9");
				SetMenuExitButton(menu2, false);
				menu2.Display(client, 0);
			}
		}
	}
	return false;
}

public int MenuHandlers_SecondaryWeapon(Menu menu2, MenuAction action, int client, int item) 
{
	switch(action)
	{
		case MenuAction_Select:
		{
			if(GetClientTeam(client) == CS_TEAM_CT && IsPlayerAlive(client)) 
			{
				char info[32];
				GetMenuItem(menu2, item, info, sizeof(info));
				
				g_LastSecondaryWeapon[client] = info;
				GivePlayerItem(client, info);
			}
		}
	}
}
