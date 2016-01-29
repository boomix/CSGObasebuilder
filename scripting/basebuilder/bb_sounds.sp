Handle RepeatTimer;
int laiks;

int LastSound = 0;

public void Sounds_OnBuildTimeStart()
{
	
	RepeatTimer = CreateTimer(0.1, BB_RepeatTimer, _, TIMER_REPEAT);
	EmitSoundToAllAny("sourcemod/basebuilder/phase_build.mp3");
	
}

public void Sounds_OnPrepTimeStart()
{

	EmitSoundToAllAny("sourcemod/basebuilder/phase_prep.mp3");

}

public Action BB_RepeatTimer(Handle tmr)
{
	
	laiks = g_iCountdown;

	if(laiks == 120 && LastSound != 120) {
		EmitSoundToAllAny("sourcemod/basebuilder/2min.mp3");
		LastSound = laiks;	
	}
	
	else if(laiks == 60 && LastSound != 60) {
		EmitSoundToAllAny("sourcemod/basebuilder/1min.mp3");
		LastSound = laiks;
	}

	else if(laiks == 30 && LastSound != 30) {
		EmitSoundToAllAny("sourcemod/basebuilder/30sec.mp3");
		LastSound = laiks;	
	}
		
	else if(laiks == 10 && LastSound != 10) {
		EmitSoundToAllAny("sourcemod/basebuilder/10sec.mp3");
		LastSound = laiks;	
	}
	
	else if(laiks == 5 && LastSound != 5) {
		EmitSoundToAllAny("sourcemod/basebuilder/5sec.mp3");
		LastSound = laiks;	
	}
	
	if(laiks == 0)
	{
		if (RepeatTimer != null)
		{
			KillTimer(RepeatTimer);
			RepeatTimer = null;
		}	
	}

}

public void Sounds_OnPrepTimeEnd()
{

	int random = GetRandomInt(1, 2);
	if(random == 1)
		EmitSoundToAllAny("sourcemod/basebuilder/round_start.mp3");
	else
		EmitSoundToAllAny("sourcemod/basebuilder/round_start2.mp3");

}

public void Sounds_OnPlayerDeath(int client, int attacker)
{
	if(GetClientTeam(client) == BUILDERS && GetClientTeam(attacker) == ZOMBIES &&!IsBuildTime() && !IsPrepTime())
		EmitSoundToAllAny("sourcemod/basebuilder/zombie_kill.mp3", attacker);
}

public void Sounds_RoundEnd(int winner_team)
{
	if(winner_team == BUILDERS)
		EmitSoundToAllAny("sourcemod/basebuilder/win_builders.mp3");
	else if(winner_team == ZOMBIES)
		EmitSoundToAllAny("sourcemod/basebuilder/win_zombies.mp3");
}

public void Sounds_PlayerHurt(int attacker)
{
	if(GetClientTeam(attacker) == ZOMBIES && !IsBuildTime() && !IsPrepTime())
		EmitSoundToClientAny(attacker, "sourcemod/basebuilder/hit.mp3");
}

public void Sounds_TookBlock(int client)
{
	EmitSoundToClientAny(client, "sourcemod/basebuilder/block_grab.mp3");
}

public void Sounds_DropBlock(int client)
{
	EmitSoundToClientAny(client, "sourcemod/basebuilder/block_drop.mp3");
}