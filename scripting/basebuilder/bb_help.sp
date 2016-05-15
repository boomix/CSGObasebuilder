bool g_bFirstSpawn[MAXPLAYERS + 1];

public void Help_OnClientPutInServer(int client)
{
	g_bFirstSpawn[client] = true;
}

public void Help_FirstSpawn(int client)
{
	if(g_bFirstSpawn[client])
	{
		CreateTimer(10.0, Tmr_ShowMenu, client);
		g_bFirstSpawn[client] = false;	
	}		
}

public Action Tmr_ShowMenu(Handle tmr, any client)
{
	ShowMenu(client);
}

public void ShowMenu(int client)
{
	g_bFirstSpawn[client] = false;
	
	Menu menu = new Menu(Handle_VoteMenu);
	menu.SetTitle("1.%T\n2.%T\n3.%T\n4.%T\n5.%T", "Pick Up block", client, "Lock block", client, "Rotate block", client, "Push Pull", client, "Class", client);
	menu.AddItem("exit", "Exit");
	menu.ExitButton = false;
	menu.Display(client, 20);
	
}

public int Handle_VoteMenu(Menu menu, MenuAction action, int param1,int param2)
{
	
}