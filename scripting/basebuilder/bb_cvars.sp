
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
	
	SetConVarInt(mp_startmoney, 0);
	SetConVarInt(mp_force_pick_time, 0);
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
	Handle cash_player_bomb_defused = FindConVar("cash_player_bomb_defused");			
	Handle cash_player_bomb_planted = FindConVar("cash_player_bomb_planted");
	Handle cash_player_damage_hostage	 = FindConVar("cash_player_damage_hostage");
	Handle cash_player_interact_with_hostage = FindConVar("cash_player_interact_with_hostage");
	Handle cash_player_killed_enemy_default = FindConVar("cash_player_killed_enemy_default");
	Handle cash_player_killed_enemy_factor = FindConVar("cash_player_killed_enemy_factor");
	Handle cash_player_killed_teammate = FindConVar("cash_player_killed_teammate");
	Handle cash_player_rescued_hostage = FindConVar("cash_player_rescued_hostage");
	Handle cash_team_elimination_bomb_map = FindConVar("cash_team_elimination_bomb_map");
	Handle cash_team_elimination_hostage_map_t = FindConVar("cash_team_elimination_hostage_map_t");
	Handle cash_team_elimination_hostage_map_ct = FindConVar("cash_team_elimination_hostage_map_ct");
	Handle cash_team_hostage_alive = FindConVar("cash_team_hostage_alive");
	Handle cash_team_hostage_interaction = FindConVar("cash_team_hostage_interaction");
	Handle cash_team_loser_bonus = FindConVar("cash_team_loser_bonus");
	Handle cash_team_loser_bonus_consecutive_rounds = FindConVar("cash_team_loser_bonus_consecutive_rounds");
	Handle cash_team_planted_bomb_but_defused = FindConVar("cash_team_planted_bomb_but_defused");
	Handle cash_team_rescued_hostage = FindConVar("cash_team_rescued_hostage");
	Handle cash_team_terrorist_win_bomb = FindConVar("cash_team_terrorist_win_bomb");
	Handle cash_team_win_by_defusing_bomb = FindConVar("cash_team_win_by_defusing_bomb");
	Handle cash_team_win_by_hostage_rescue = FindConVar("cash_team_win_by_hostage_rescue");
	Handle cash_team_win_by_time_running_out_hostage = FindConVar("cash_team_win_by_time_running_out_hostage");
	Handle cash_team_win_by_time_running_out_bomb = FindConVar("cash_team_win_by_time_running_out_bomb");

	SetConVarInt(cash_player_bomb_defused, 0);
	SetConVarInt(cash_player_bomb_planted, 0);
	SetConVarInt(cash_player_damage_hostage, 0);
	SetConVarInt(cash_player_interact_with_hostage, 0);
	SetConVarInt(cash_player_killed_enemy_default, 0);
	SetConVarFloat(cash_player_killed_enemy_factor, 0.0);
	SetConVarInt(cash_player_killed_teammate, 0);
	SetConVarInt(cash_player_interact_with_hostage, 0);
	SetConVarInt(cash_player_rescued_hostage, 0);
	SetConVarInt(cash_team_elimination_bomb_map, 0);
	SetConVarInt(cash_team_elimination_hostage_map_t, 0);
	SetConVarInt(cash_team_elimination_hostage_map_ct, 0);
	SetConVarInt(cash_team_hostage_alive, 0);
	SetConVarInt(cash_team_hostage_interaction, 0);
	SetConVarInt(cash_team_loser_bonus, 0);
	SetConVarInt(cash_team_loser_bonus_consecutive_rounds, 0);
	SetConVarInt(cash_team_planted_bomb_but_defused, 0);
	SetConVarInt(cash_team_rescued_hostage, 0);
	SetConVarInt(cash_team_terrorist_win_bomb, 0);
	SetConVarInt(cash_team_win_by_hostage_rescue, 0);
	SetConVarInt(cash_team_win_by_defusing_bomb, 0);
	SetConVarInt(cash_team_win_by_time_running_out_hostage, 0);
	SetConVarInt(cash_team_win_by_time_running_out_bomb, 0);
	
}