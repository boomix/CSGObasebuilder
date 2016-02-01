#pragma semicolon 1

#include <sourcemod>
#include <sdktools>
#include <cstrike>
#include <basebuilder>
#include <emitsoundany>
#include <smlib>
#include <sdkhooks>
//#include <fpvm_interface>
#include <multicolors>

#pragma newdecls required

#include "basebuilder/bb_globals.sp"
#include "basebuilder/bb_natives.sp"
#include "basebuilder/bb_timers.sp"
#include "basebuilder/bb_cvars.sp"
#include "basebuilder/bb_disableradar.sp"
#include "basebuilder/bb_downloadprecache.sp"
#include "basebuilder/bb_sounds.sp"
#include "basebuilder/bb_functions.sp"
#include "basebuilder/bb_blockmoving.sp"
#include "basebuilder/bb_blocklocking.sp"
#include "basebuilder/bb_nofalldamage.sp"
#include "basebuilder/bb_removenotusedblocks.sp"
#include "basebuilder/bb_blocksuicide.sp"
#include "basebuilder/bb_respawn.sp"
#include "basebuilder/bb_colors.sp"
#include "basebuilder/bb_zombies.sp"
#include "basebuilder/bb_teamswitch.sp"
#include "basebuilder/bb_weapons.sp"
#include "basebuilder/bb_shop.sp"
#include "basebuilder/bb_party.sp"
#include "basebuilder/bb_grenades.sp"
#include "basebuilder/bb_goldenak.sp"
#include "basebuilder/bb_resetarmor.sp"
#include "basebuilder/bb_superknife.sp"
#include "basebuilder/bb_givemoney.sp"
#include "basebuilder/bb_admin.sp"
#include "basebuilder/bb_help.sp"
#include "basebuilder/bb_nothisbase.sp"
#include "basebuilder/bb_laddergravity.sp"
#include "basebuilder/bb_randomspawnangle.sp"

EngineVersion g_Game;

public Plugin myinfo = 
{
	name = "Basebuilder 2.2.6",
	author = PLUGIN_AUTHOR,
	description = "Gamemode from cs 1.6  - Basebuilder .",
	version = PLUGIN_VERSION,
	url = "http://csgo.lol | http://zipcore.net/"
};

public void OnPluginStart()
{
	g_Game = GetEngineVersion();
	if(g_Game != Engine_CSGO && g_Game != Engine_CSS)
	{
		SetFailState("This plugin is for CSGO/CSS only.");	
	}
	
	//** 	Events	 **//
	HookEvent("round_start", 	BB_RoundStart);
	HookEvent("player_spawn", 	BB_PlayerSpawn, 	EventHookMode_Post);
	HookEvent("player_blind", 	Event_PlayerBlind, 	EventHookMode_Post);
	HookEvent("player_death", 	BB_PlayerDeath);
	HookEvent("round_end",	 	BB_RoundEnd);
	HookEvent("player_hurt", 	BB_PlayerHurt, 		EventHookMode_Pre);
	HookEvent("player_team", 	BB_PlayerTeam, 		EventHookMode_Pre);
	HookEvent("weapon_fire", 	BB_WeaponFire);
	
	//** 	Commands 	**//
	RegConsoleCmd("sm_lm", 			CMD_LastMover, 	"Last mover");
	RegConsoleCmd("sm_lastmover", 	CMD_LastMover, 	"Last mover 2");
	RegConsoleCmd("sm_respawn", 	CMD_Respawn,	"Respawn");
	RegConsoleCmd("sm_revive", 		CMD_Respawn,	"Respawn 2");
	RegConsoleCmd("sm_colors", 		CMD_Colors,		"Colors");
	RegConsoleCmd("sm_class", 		CMD_ZMClass, 	"Change class");
	RegConsoleCmd("sm_zclass", 		CMD_ZMClass, 	"Change class 2");
	RegConsoleCmd("sm_zombie", 		CMD_ZMClass, 	"Change class");
	RegConsoleCmd("sm_shop", 		CMD_Shop, 		"Open shop!");
	RegConsoleCmd("sm_guns", 		CMD_Guns);
	RegConsoleCmd("sm_bb", 			CMD_AdminPanel);
	
	
	//Locking
	AddCommandListener(BB_LockBlock, "drop");
	AddCommandListener(BB_BlockKill, "kill");
	AddCommandListener(BB_BlockTeamChange, "jointeam");
	
	BuildPath(Path_SM, g_sBasebuilderConfig, sizeof(g_sBasebuilderConfig), "configs/basebuilder/bb_main.cfg");
	BuildPath(Path_SM, g_sBasebuilderConfig2, sizeof(g_sBasebuilderConfig2), "configs/basebuilder/bb_zombies.cfg");
	BuildPath(Path_SM, g_sBasebuilderConfig3, sizeof(g_sBasebuilderConfig3), "configs/basebuilder/bb_zmshop.cfg");
	BuildPath(Path_SM, g_sBasebuilderConfig4, sizeof(g_sBasebuilderConfig4), "configs/basebuilder/bb_ctshop.cfg");
	
	AddNormalSoundHook(SoundHook);
	
	NoFallDamage_OnPluginStart();
	Party_OnPluginStart();
	Grenades_OnPluginStart();
	//NotHisBase_OnPluginStart();
	
	//Translation
	LoadTranslations("basebuilder.phrases");

}

public void OnConfigsExecuted()
{

	LoadCvars();

	KeyValues kvMainCfg = CreateKeyValues("bb_config");

	if(!kvMainCfg.ImportFromFile(g_sBasebuilderConfig)) return;
	if (!kvMainCfg.JumpToKey("config")) return;
		
	char g_sBuildTime[10];
	char g_sPrepTime[10];
	char g_sRoundTime[10];
	char g_sMaxLocks[10];
	char g_sRemoveNotUsedBlocks[10];
	char g_sRemoveBlockAfterDeath[10];
	char g_sMoneyPerKill[10];
	char g_sPushPlayersOfBlocks[10];
	kvMainCfg.GetString("Buildtime", 			g_sBuildTime, 		sizeof(g_sBuildTime));
	kvMainCfg.GetString("PrepTime", 			g_sPrepTime,		sizeof(g_sPrepTime));
	kvMainCfg.GetString("BuildTimeMessage", 	g_sBuildTimeMsg,	sizeof(g_sBuildTimeMsg));
	kvMainCfg.GetString("PrepTimeMessage", 		g_sPrepTimeMsg,		sizeof(g_sPrepTimeMsg));
	kvMainCfg.GetString("ReleaseMessage", 		g_sReleaseMsg,		sizeof(g_sReleaseMsg));
	kvMainCfg.GetString("Prefix", 				Prefix,				sizeof(Prefix));
	kvMainCfg.GetString("RoundTime", 			g_sRoundTime, 		sizeof(g_sRoundTime));
	kvMainCfg.GetString("MaxLocks", 			g_sMaxLocks, 		sizeof(g_sMaxLocks));
	kvMainCfg.GetString("RemoveNotUsedBlocks", 	g_sRemoveNotUsedBlocks, sizeof(g_sRemoveNotUsedBlocks));
	kvMainCfg.GetString("RemoveBlockAfterDeath", g_sRemoveBlockAfterDeath, sizeof(g_sRemoveBlockAfterDeath));
	kvMainCfg.GetString("MoneyPerKill", 		g_sMoneyPerKill,	sizeof(g_sMoneyPerKill));
	kvMainCfg.GetString("PushPlayersOfBlocks", 	g_sPushPlayersOfBlocks,	sizeof(g_sPushPlayersOfBlocks));
	
	
	g_fBuildTime	= StringToFloat(g_sBuildTime);
	g_fPrepTime	 	= StringToFloat(g_sPrepTime);
	
	g_iRoundTime 	= StringToInt(g_sRoundTime);
	g_iMaxLocks 	= StringToInt(g_sMaxLocks);
	
	g_iRemoveNotUsedBlocks 		= StringToInt(g_sRemoveNotUsedBlocks);
	g_iRemoveBlockAfterDeath 	= StringToInt(g_sRemoveBlockAfterDeath);
	g_iPushPlayersOfBlocks 		= StringToInt(g_sPushPlayersOfBlocks);
	
	g_iMoneyPerRound = StringToInt(g_sMoneyPerKill);
	
	delete kvMainCfg;
	
	ReplaceString(g_sBuildTimeMsg, sizeof(g_sBuildTimeMsg), "{TIME}", "%i");
	ReplaceString(g_sPrepTimeMsg, sizeof(g_sPrepTimeMsg), "{TIME}", "%i");
	
	FixPrefix();
	GetTeleportCoords();

}

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	RegPluginLibrary("basebuilder");
	
	CreateNatives();
	
	g_OnBuildTimeStart = CreateGlobalForward("BaseBuilder_OnBuildTimeStart", ET_Ignore);
	g_OnPrepTimeStart = CreateGlobalForward("BaseBuilder_OnPrepTimeStart", ET_Ignore);
	g_OnPrepTimeEnd = CreateGlobalForward("BaseBuilder_OnPrepTimeEnd", ET_Ignore);
	
	return APLRes_Success;
}

public Action BB_RoundStart(Handle event, const char[] name, bool dontBroadcast)
{
	
	g_IsBuildTime = true;
	
	/* Forward: BaseBuilder_OnBuildTimeStart */
	Call_StartForward(g_OnBuildTimeStart);
	Call_Finish();
	
	KillTimers2();
	
	TimeTimer = CreateTimer(g_fBuildTime, BB_BuildTime);
	
	
	//Setting round time
	GameRules_SetProp("m_iRoundTime", g_iRoundTime, 16);

}

public Action BB_LockBlock(int client, const char[] cmd, int argc) 
{
	LockBlock(client);
}

public Action CMD_LastMover(int client, int args)
{

	int entity = GetTargetBlock(client);
	
	if(IsValidEntity(entity)) {
		int lastmover = GetLastMover(entity);
		if(lastmover > 0) {
			char username[MAX_NAME_LENGTH];
			GetClientName(lastmover, username, sizeof(username));
			//PrintToChatAll("%s%T", Prefix, "Last mover", client, username);
			//CPrintToChat(client, "%s%T", Prefix, "Last mover", client, username);
			CPrintToChat(client, "%s%T", Prefix, "Last mover", client, username);
		} else {
			CPrintToChat(client, "%s%T", Prefix, "Not moved", client);
		}
	}

}

public Action BB_BuildTime(Handle tmr)
{
	Call_StartForward(g_OnPrepTimeStart);
	Call_Finish();
	
	g_IsBuildTime = false;
	g_IsPrepTime = true;
	
	TimeTimer = CreateTimer(g_fPrepTime, BB_PrepTime);
}

public Action BB_PrepTime(Handle tmr)
{
	g_IsPrepTime = false;
	KillTimers2();
	
	Call_StartForward(g_OnPrepTimeEnd);
	Call_Finish();
}

public void KillTimers2() 
{

	if (TimeTimer != INVALID_HANDLE)
	{
		KillTimer(TimeTimer);
		TimeTimer = INVALID_HANDLE;
	}
	
}

public void FixPrefix()
{

	char ColorPre[150] = "\x1 ";
	ReplaceString(Prefix, sizeof(Prefix), "{WHITE}", "\x01");
	ReplaceString(Prefix, sizeof(Prefix), "{RED}", 	"\x02");
	ReplaceString(Prefix, sizeof(Prefix), "{TEAM}", "\x03");
	ReplaceString(Prefix, sizeof(Prefix), "{GREEN}", "\x04");
	ReplaceString(Prefix, sizeof(Prefix), "{LIME}", "\x05");
	ReplaceString(Prefix, sizeof(Prefix), "{LIGHTGREEN}", "\x06");
	ReplaceString(Prefix, sizeof(Prefix), "{LIGHTRED}", "\x07");
	ReplaceString(Prefix, sizeof(Prefix), "{GRAY}", "\x08");
	ReplaceString(Prefix, sizeof(Prefix), "{LIGHTOLIVE}", "\x09");
	ReplaceString(Prefix, sizeof(Prefix), "{OLIVE}", "\x10");
	ReplaceString(Prefix, sizeof(Prefix), "{PURPLE}", "\x0E");
	ReplaceString(Prefix, sizeof(Prefix), "{LIGHTBLUE}", "\x0B");
	ReplaceString(Prefix, sizeof(Prefix), "{BLUE}", "\x0C");
	
	StrCat(ColorPre, sizeof(ColorPre), Prefix);
	
	Prefix = ColorPre;

}

public bool IsBuildTime()
{
	if(g_IsBuildTime)
		return true;
	else return false;
}

public bool IsPrepTime()
{
	if(g_IsPrepTime)
		return true;
	else return false;
}

public bool IsAdmin(int client)
{
	if(Client_HasAdminFlags(client, ADMFLAG_GENERIC) || Client_HasAdminFlags(client, ADMFLAG_ROOT) || Client_HasAdminFlags(client, ADMFLAG_BAN))
		return true;
	else return false;
}

int GetBlockOwner(int entity)
{
	char entname[MAX_NAME_LENGTH];
	Entity_GetName(entity, entname, sizeof(entname));
	
	int entval = StringToInt(entname);
	
	return entval;
}

void SetBlockOwner(int entity, int owner)
{
	if(IsValidEntity(entity))
		Entity_SetName(entity, "%i", owner); 
}

void SetLastMover(int entity, int owner)
{
	Entity_SetGlobalName(entity, "%i", owner);
}

int GetLastMover(int entity)
{
	char entityname[10];
	Entity_GetGlobalName(entity, entityname, sizeof(entityname));
	int LastMover = StringToInt(entityname);
	return LastMover;
}

public Action BB_PlayerTeam(Handle event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	Respawn_PlayerTeam(client);
	return Plugin_Handled;
}


public Action BB_BlockTeamChange(int client, const char[] command, int args) 
{ 
	return Plugin_Handled;
}
