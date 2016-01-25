public void Radar_PlayerSpawn(int client)
{
	CreateTimer(0.1, RemoveRadar, client);
}

public Action RemoveRadar(Handle timer, any client)
{
	
	if(client > 0 && IsClientInGame(client) && !IsFakeClient(client)) 
	{
		SetEntProp(client, Prop_Send, "m_iHideHUD", GetEntProp(client, Prop_Send, "m_iHideHUD") | HIDE_RADAR_CSGO);
		SetEntPropFloat(client, Prop_Send, "m_flFlashDuration", 3600.0);
		SetEntPropFloat(client, Prop_Send, "m_flFlashMaxAlpha", 0.5);	
	}
}

public Action Event_PlayerBlind(Event event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	
	if (IsClientInGame(client) && !IsFakeClient(client))
	{
		float fDuration = GetEntPropFloat(client, Prop_Send, "m_flFlashDuration");
		CreateTimer(fDuration, RemoveRadar, client);
	}

}

///*****************************************
