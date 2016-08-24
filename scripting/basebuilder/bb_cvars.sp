
public void LoadCvars()
{
	
	Handle bot_quota = FindConVar("bot_quota");
	Handle bot_quota_mode = FindConVar("bot_quota_mode");
	Handle mp_buytime = FindConVar("mp_buytime");
	Handle mp_freezetime = FindConVar("mp_freezetime"); 
	Handle mp_maxmoney = FindConVar("mp_maxmoney");
	Handle mp_startmoney = FindConVar("mp_startmoney");
	Handle mp_ct_default_secondary = FindConVar("mp_ct_default_secondary");
	Handle mp_t_default_secondary = FindConVar("mp_t_default_secondary");
	Handle mp_autokick = FindConVar("mp_autokick");
	Handle mp_default_team_winner_no_objective = FindConVar("mp_default_team_winner_no_objective");
	Handle mp_warmuptime = FindConVar("mp_warmuptime");
	Handle mp_do_warmup_period = FindConVar("mp_do_warmup_period"); 
	Handle mp_solid_teammates = FindConVar("mp_solid_teammates");
	Handle mp_death_drop_gun = FindConVar("mp_death_drop_gun");
	Handle sv_infinite_ammo = FindConVar("sv_infinite_ammo");
	Handle mp_force_assign_teams = FindConVar("mp_force_assign_teams");
	Handle mp_force_pick_time = FindConVar("mp_force_pick_time");
	//Handle mp_playercashawards = FindConVar("mp_playercashawards");
	Handle mp_teamcashawards = FindConVar("mp_teamcashawards");

	
	SetConVarInt(mp_startmoney, 0);
	SetConVarInt(mp_force_pick_time, 0);
	//SetConVarInt(mp_playercashawards, 0);
	SetConVarInt(mp_teamcashawards, 0);
	
	SetConVarInt(mp_force_assign_teams, 1);
	SetConVarInt(bot_quota, 0);
	SetConVarString(bot_quota_mode, "none");
	SetConVarInt(mp_buytime, 0);
	SetConVarInt(mp_freezetime, 0);
	SetConVarInt(mp_maxmoney, 16000);
	SetConVarString(mp_ct_default_secondary, "");
	SetConVarString(mp_t_default_secondary, "");
	SetConVarInt(mp_autokick, 0);
	SetConVarInt(mp_default_team_winner_no_objective, 3);
	SetConVarInt(mp_warmuptime, 0);
	SetConVarInt(mp_do_warmup_period, 0);
	SetConVarInt(mp_solid_teammates, 0);
	SetConVarInt(mp_death_drop_gun, 0);
	SetConVarInt(sv_infinite_ammo, 2);
	
	//Money setup
	//Handle cash_player_killed_enemy_default = FindConVar("cash_player_killed_enemy_default");
	Handle cash_player_killed_enemy_factor = FindConVar("cash_player_killed_enemy_factor");
	Handle cash_player_killed_teammate = FindConVar("cash_player_killed_teammate");
	Handle cash_team_loser_bonus = FindConVar("cash_team_loser_bonus");
	Handle cash_team_loser_bonus_consecutive_rounds = FindConVar("cash_team_loser_bonus_consecutive_rounds");
	//Handle cash_team_win_by_time_running_out_bomb = FindConVar("cash_team_win_by_time_running_out_bomb");


	//SetConVarInt(cash_player_killed_enemy_default, 0);
	SetConVarFloat(cash_player_killed_enemy_factor, 0.0);
	SetConVarInt(cash_player_killed_teammate, 0);
	SetConVarInt(cash_team_loser_bonus, 0);
	SetConVarInt(cash_team_loser_bonus_consecutive_rounds, 0);
	//SetConVarInt(cash_team_win_by_time_running_out_bomb, 0);
	
	
}