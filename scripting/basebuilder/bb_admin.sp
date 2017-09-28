public Action CMD_AdminPanel(int client, int args)
{
	if(IsAdmin(client))
		OpenBBAdminMenu(client);
	
	return Plugin_Handled;
}

void OpenBBAdminMenu(int client)
{

	Menu menu = new Menu(MenuHandler_PlayerEdit);
	SetMenuTitle(menu, "Select player");
	
	LoopAllPlayers(i)
	{
		char username[MAX_NAME_LENGTH];
		char userid[4];
		GetClientName(i, username, sizeof(username));
		IntToString(i, userid, sizeof(userid));
		menu.AddItem(userid, username);
	}
	
	menu.Display(client, 0);

}

public int MenuHandler_PlayerEdit(Menu menu, MenuAction action, int client, int item)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			char info[32];
			char username[MAX_NAME_LENGTH];
			char clientstring[4];
			GetMenuItem(menu, item, info, sizeof(info));
			
			int customclient = StringToInt(info);
			GetClientName(customclient, username, sizeof(username));
			
			Menu menu2 = new Menu(MenuHandler_PlayerEditSave);
			SetMenuTitle(menu2, username);
			
			char respawnclient[50] = 	"respawn-";
			char changeandresp[50] = 	"changeandresp-";
			
			IntToString(customclient, clientstring, sizeof(clientstring));
			StrCat(respawnclient, sizeof(respawnclient), clientstring);
			StrCat(changeandresp, sizeof(changeandresp), clientstring);

			menu2.AddItem(respawnclient,	"Respawn client");
			menu2.AddItem(changeandresp, 	"Change team and respawn");
			
			menu2.Display(client, 0);
		}
	}
}

public int MenuHandler_PlayerEditSave(Menu menu, MenuAction action, int client, int item)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			char info[32];
			GetMenuItem(menu, item, info, sizeof(info));
			
			char brake[4][40];
			ExplodeString(info, "-", brake, sizeof(brake), sizeof(brake[]));
			int newclient = StringToInt(brake[1]);
			
			if(StrEqual(brake[0], "respawn")) 
			{
				CreateTimer(0.0, Respawn_Player, newclient);
			}
			
			if(StrEqual(brake[0], "changeandresp")) 
			{
				if(GetClientTeam(newclient) == CS_TEAM_CT)
					ChangeClientTeam(newclient, CS_TEAM_T);
				else if(GetClientTeam(newclient) == CS_TEAM_T)
					ChangeClientTeam(newclient, CS_TEAM_CT);
					
				CreateTimer(0.0, Respawn_Player, newclient);
			}
			
			OpenBBAdminMenu(client);
		}
	}
}