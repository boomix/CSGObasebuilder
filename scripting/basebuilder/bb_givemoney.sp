public void Money_OnPlayerDeath(int client)
{
	int money = Client_GetMoney(client);
	Client_SetMoney(client, money + g_iMoneyPerRound);
	
}