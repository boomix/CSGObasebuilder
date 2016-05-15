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
Handle g_hTimer_Query[MAXPLAYERS + 1];

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
bool g_buyOnceRoundGravity[MAXPLAYERS + 1];

int g_iCountdown;
int g_iRoundTime;
int g_iMaxLocks;
int g_iRemoveNotUsedBlocks;
int g_iRemoveBlockAfterDeath;
int g_iPushPlayersOfBlocks;

//Colors
int colorr[52] =  	{ 
						0,	243, 232, 155, 102, 62, 32, 2, 0, 0, 75, 138, 204, 254, 254, 254, 254, 120, 
							243, 232, 155, 102, 62, 32, 2, 0, 0, 75, 138, 204, 254, 254, 254, 254, 120,
							243, 232, 155, 102, 62, 32, 2, 0, 0, 75, 138, 204, 254, 254, 254, 254, 120
					};
						
int colorg[52] =  	{
						0, 	66, 29, 38, 57, 80, 149, 168, 187, 149, 174, 194, 219, 234, 192, 151, 86, 84,
							66, 29, 38, 57, 80, 149, 168, 187, 149, 174, 194, 219, 234, 192, 151, 86, 84,
							66, 29, 38, 57, 80, 149, 168, 187, 149, 174, 194, 219, 234, 192, 151, 86, 84
				
					};

int colorb[52] =  	{ 
						0, 	53, 98, 175, 182, 180, 242, 243, 211, 135, 79, 73, 56, 58, 6, 0, 33, 71,
							53, 98, 175, 182, 180, 242, 243, 211, 135, 79, 73, 56, 58, 6, 0, 33, 71,
							53, 98, 175, 182, 180, 242, 243, 211, 135, 79, 73, 56, 58, 6, 0, 33, 71
					};

char colors[][] = 	{ 
						"None", "Red", 	"Pink", "Purple", "Deep purple", "Indigo", "Blue", "Light blue", "Cyan", "Teal", "Green", "Light green", "Lime", "Yellow", "Amber", "Orange", "Deep orange", "Brown",  
								"Red", 	"Pink", "Purple", "Deep purple", "Indigo", "Blue", "Light blue", "Cyan", "Teal", "Green", "Light green", "Lime", "Yellow", "Amber", "Orange", "Deep orange", "Brown", 
								"Red", 	"Pink", "Purple", "Deep purple", "Indigo", "Blue", "Light blue", "Cyan", "Teal", "Green", "Light green", "Lime", "Yellow", "Amber", "Orange", "Deep orange", "Brown"
					};
					
int 	clientlocks			[MAXPLAYERS + 1];
int 	g_iClientClass		[MAXPLAYERS + 1];
bool 	g_bHasGoldenAK		[MAXPLAYERS + 1];
bool 	g_bHasSuperKnife	[MAXPLAYERS + 1];
//int 	Golden_ViewModel;
//int 	Golden_WorldModel;
int 	g_sprite;
int 	g_iMoneyPerRound;
bool 	g_bFirstTeamJoin	[MAXPLAYERS + 1];

bool g_bIsInParty[MAXPLAYERS + 1];
int g_iInPartyWith[MAXPLAYERS + 1];
int g_iDecalEntity[MAXPLAYERS + 1] = 1;