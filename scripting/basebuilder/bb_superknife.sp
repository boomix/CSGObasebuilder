public void SuperKnife_RoundStart()
{
	LoopAllPlayers(i)
	{
		g_bHasSuperKnife[i] = false;
	}
}

public void SuperKnife_PlayerHurt(int client, int attacker, int dmg_health, char sWeapon[50])
{
	if(StrEqual(sWeapon, "knifegg") && dmg_health > 54 && g_bHasSuperKnife[attacker]) {
		SetEntityHealth(client, 0);
	}
}

public void GiveSuperKnife(int client)
{
	int currentknife = GetPlayerWeaponSlot(client, CS_SLOT_KNIFE);
					        
	if(IsValidEntity(currentknife))
		AcceptEntityInput(currentknife, "Kill");
		
	int weapons = GivePlayerItem(client, "weapon_knifegg");
	EquipPlayerWeapon(client, weapons);
	SetEntPropEnt(client, Prop_Send, "m_hActiveWeapon", weapons);
	g_bHasSuperKnife[client] = true;	
}