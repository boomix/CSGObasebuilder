public void Shop_PlayerSpawn(int client)
{
	g_buyOnceRound[client] = true;
}

public Action CMD_Shop(int client, int args)
{
	//Zombie shop
	if(GetClientTeam(client) == ZOMBIES)
	{

		Menu shopmenu = new Menu(MenuHandler_Shop);
		SetMenuTitle(shopmenu, "Zombie shop");
		
		KeyValues kv = CreateKeyValues("zm_shop");
		kv.ImportFromFile(g_sBasebuilderConfig3);
	 
		if (!kv.GotoFirstSubKey())
		{
			return Plugin_Handled;
		}
	 
		char ItemID[10];
		char name[150];
		char price[20];
		do
		{
			kv.GetSectionName(ItemID, sizeof(ItemID));
			kv.GetString("name", name, sizeof(name));
			kv.GetString("price", price, sizeof(price));
			Format(name, sizeof(price), "%s (%s$)", name, price);
			shopmenu.AddItem(ItemID, name);
		} while (kv.GotoNextKey());
	 
		delete kv;
		shopmenu.Display(client, 0);
	}
	
	else if(GetClientTeam(client) == BUILDERS && !IsBuildTime())
	{
		Menu shopmenu = new Menu(MenuHandler_Shop);
		SetMenuTitle(shopmenu, "Builder shop");
		
		KeyValues kv = CreateKeyValues("ct_shop");
		kv.ImportFromFile(g_sBasebuilderConfig4);
	 
		if (!kv.GotoFirstSubKey())
		{
			return Plugin_Handled;
		}
	 
		char ItemID[10];
		char name[150];
		char price[20];
		do
		{
			kv.GetSectionName(ItemID, sizeof(ItemID));
			kv.GetString("name", name, sizeof(name));
			kv.GetString("price", price, sizeof(price));
			Format(name, sizeof(price), "%s (%s$)", name, price);
			shopmenu.AddItem(ItemID, name);
		} while (kv.GotoNextKey());
	 
		delete kv;
		shopmenu.Display(client, 0);
	}

	return Plugin_Continue;
}


public int MenuHandler_Shop(Menu menu, MenuAction action, int client, int item) 
{
	switch(action)
	{
		case MenuAction_Select:
		{
			char info[32];
			GetMenuItem(menu, item, info, sizeof(info));
			
			KeyValues kvzmShop = CreateKeyValues("zm_shop");
			
			char configfile[PLATFORM_MAX_PATH];
			if(GetClientTeam(client) == ZOMBIES)
				configfile = g_sBasebuilderConfig3;
			else if(GetClientTeam(client) == BUILDERS)
				configfile = g_sBasebuilderConfig4;
			
			if(!kvzmShop.ImportFromFile(configfile)) return;
			if (!kvzmShop.JumpToKey(info)) return;
				
			char price[10];
			kvzmShop.GetString("price", price, sizeof(price));
			int iPrice = StringToInt(price);
			int clientMoney = Client_GetMoney(client);
			
			if(clientMoney < iPrice)
				CPrintToChat(client, "%s%T", Prefix, "Shop not enough money", client);
			else {
				//Take off money
				int newClientMoney = clientMoney - iPrice;
				Client_SetMoney(client, newClientMoney);
				
				//Print message in chat
				char name[50];
				kvzmShop.GetString("name", name, sizeof(name));
				CPrintToChat(client, "%s%T", Prefix, "Shop bought item", client, name);
				
				//Main functions
				char sItem[50];
				char value[50];
				kvzmShop.GetString("item", sItem, sizeof(sItem));
				kvzmShop.GetString("value", value, sizeof(value));
				
				if(StrEqual(sItem, "speed"))
				{
					float fvalue = StringToFloat(value);
					float fspeed = GetEntPropFloat(client, Prop_Data, "m_flLaggedMovementValue");
					SetEntPropFloat(client, Prop_Data, "m_flLaggedMovementValue", fspeed * fvalue);
				}
				
				else if(StrEqual(sItem, "gravity"))
				{
					float fvalue = StringToFloat(value);
					float fgravity = GetEntityGravity(client);
					SetEntityGravity(client, fgravity * fvalue);
				}
				
				else if(StrEqual(sItem, "health"))
				{
					if(g_buyOnceRound[client])
					{
						int ivalue = StringToInt(value);
						int ihealth = GetClientHealth(client);
						SetEntityHealth(client, ihealth + ivalue);
						
						if(GetClientTeam(client) == BUILDERS)
							g_buyOnceRound[client] = false;
							
					} else if(!g_buyOnceRound[client])
					{
						int refreshMoney = Client_GetMoney(client);
						Client_SetMoney(client, refreshMoney + iPrice);
						CPrintToChat(client, "%s%T", Prefix, "Money returned", client);		
					}
				}
				
				else if(StrEqual(sItem, "sknife"))
					GiveSuperKnife(client);
				
				else if(StrEqual(sItem, "weapon_hegrenade"))
					GivePlayerItem(client, "weapon_hegrenade");
				
				else if(StrEqual(sItem, "weapon_decoy"))
					GivePlayerItem(client, "weapon_decoy");
				
				else if(StrEqual(sItem, "goldenak47"))
					GiveGoldenAk(client);
				
			}
			
			delete kvzmShop;

			
		}
	}
}