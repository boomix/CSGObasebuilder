bool g_bFirstSpawn[MAXPLAYERS + 1];

public void Help_OnClientPutInServer(int client)
{
	g_bFirstSpawn[client] = true;
}

public void Help_FirstSpawn(int client)
{
	if(g_bFirstSpawn[client])
		ShowMenu(client);
}

public void ShowMenu(int client)
{
	g_bFirstSpawn[client] = false;
	
	Menu menu = new Menu(Handle_VoteMenu);
	menu.SetTitle("1.Pick up block with 'E'\n2.Lock block with 'G'\n3.Rotate block with 'R'\n4.Push, pull block with 'mouse1/mouse2'\n5.Change zm class by typing !class");
	menu.AddItem("exit", "Exit");
	menu.ExitButton = false;
	menu.Display(client, 20);
	
}

public int Handle_VoteMenu(Menu menu, MenuAction action, int param1,int param2)
{
	
}