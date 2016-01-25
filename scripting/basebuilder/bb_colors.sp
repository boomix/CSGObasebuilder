public Action CMD_Colors(int client, int args)
{

	Menu menu = new Menu(MenuHandler_ColorMenu);
	SetMenuTitle(menu, "Player colors");	
	
	LoopAllPlayers(i) 
	{
		char username[MAX_NAME_LENGTH];
		GetClientName(i, username, sizeof(username));
		
		StrCat(username, sizeof(username), " - ");
		StrCat(username, sizeof(username), colors[i]);
		
		menu.AddItem("Player", username);
	}
		
	menu.Display(client, 0);

}

public int MenuHandler_ColorMenu(Menu menu10, MenuAction action, int client, int item)
{
	//No output in menu :)	
}