public void ResetArmor_PlayerHurt(int client)
{
	SetEntProp(client, Prop_Data, "m_ArmorValue", 100, 4);
}