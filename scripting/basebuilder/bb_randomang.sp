public void RandomAngle_PlayerSpawn(int client)
{
	
	float ang[3];
	GetClientEyeAngles(client, ang);
	
	float random = GetRandomFloat(1.0, 10.0);
	int randomint = GetRandomInt(1, 2);
	if(randomint == 1)
		ang[1] += random;
	else if(randomint == 2)
		ang[1] -= random;
	
	TeleportEntity(client, NULL_VECTOR, ang, NULL_VECTOR);

}