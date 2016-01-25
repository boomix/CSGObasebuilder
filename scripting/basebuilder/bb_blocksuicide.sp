public Action BB_BlockKill(int client, const char[] command, int args)
{
	CPrintToChat(client, "%s%T", Prefix, "Kill", client);
	return Plugin_Handled;
}  