#define PLUGIN_AUTHOR "boomix & zipcore"
#define PLUGIN_VERSION "2.00"

#define ZOMBIES		CS_TEAM_T
#define BUILDERS	CS_TEAM_CT

#define HIDE_RADAR_CSGO 1<<12
#define SOUND_FREEZE			"physics/glass/glass_impact_bullet4.wav"
#define SOUND_FREEZE_EXPLODE	"ui/freeze_cam.wav"

#define LoopAllPlayers(%1) for(int %1=1;%1<=MaxClients;++%1)\
if(IsClientInGame(%1))

Handle g_OnBuildTimeStart;
Handle g_OnPrepTimeStart;
Handle g_OnPrepTimeEnd;
Handle TimeTimer;

bool g_IsBuildTime;
bool g_IsPrepTime;
bool g_bWasBuilderThisRound[MAXPLAYERS + 1];

float g_fBuildTime;
float g_fPrepTime;
float CTSpawnOrg[3];
float CTSpawnAng[3];

char g_sBasebuilderConfig[PLATFORM_MAX_PATH];
char g_sBasebuilderConfig2[PLATFORM_MAX_PATH];
char g_sBasebuilderConfig3[PLATFORM_MAX_PATH];
char g_sBasebuilderConfig4[PLATFORM_MAX_PATH];

char g_sBuildTimeMsg[200];
char g_sPrepTimeMsg[200];
char g_sReleaseMsg[150];
char Prefix[150];
int BeamSprite;
bool g_buyOnceRound[MAXPLAYERS + 1];

int g_iCountdown;
int g_iRoundTime;
int g_iMaxLocks;
int g_iRemoveNotUsedBlocks;
int g_iRemoveBlockAfterDeath;
int g_iPushPlayersOfBlocks;

//Colors
int colorr[35] =  { 0,		25, 	255, 	255, 	30, 	255, 	255, 	0, 		4, 		105, 	139, 	110, 	25, 255, 255, 30, 255, 255, 0, 4, 105, 139, 110		, 25, 255, 255, 30, 255, 255, 0, 4, 105, 139, 110 	};
int colorg[35] =  { 0,		0, 		0, 		0, 		255, 	255, 	132, 	255, 	89, 	11, 	2, 		107,  	0, 0, 0, 255, 255, 132, 255, 89, 11, 2, 107 		, 0, 0, 0, 255, 255, 132, 255, 89, 11, 2, 107		};
int colorb[35] =  { 0,		255,	0, 		217, 	0, 		0, 		0, 		251, 	0, 		1, 		194, 	104, 	255, 0, 217, 0, 0, 0, 251, 0, 1, 194, 104 			, 255, 0, 217, 0, 0, 0, 251, 0, 1, 194, 104			};
char colors[][] =	{ "None", "Blue", "Red", "Pink", "Green", "Yellow", "Orange", "Light blue", "Dark green", "Dark red", "Purple", "Gray", "Blue", "Red", "Pink", "Green", "Yellow", "Orange", "Light blue", "Dark green", "Dark red", "Purple", "Gray", "Blue", "Red", "Pink", "Green", "Yellow", "Orange", "Light blue", "Dark green", "Dark red", "Purple", "Gray" };

int 	clientlocks			[MAXPLAYERS + 1];
int 	g_iClientClass		[MAXPLAYERS + 1];
bool 	g_bHasGoldenAK		[MAXPLAYERS + 1];
bool 	g_bHasSuperKnife	[MAXPLAYERS + 1];
int 	Golden_ViewModel;
int 	Golden_WorldModel;
int 	g_sprite;
int 	g_iMoneyPerRound;
bool 	g_bFirstTeamJoin	[MAXPLAYERS + 1];

bool g_bIsInParty[MAXPLAYERS + 1];
int g_iInPartyWith[MAXPLAYERS + 1];