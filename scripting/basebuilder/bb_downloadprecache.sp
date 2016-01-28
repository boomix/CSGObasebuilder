public void OnMapStart()
{

	// ** 	SOUNDS 		** //
	AddFileToDownloadsTable("sound/sourcemod/basebuilder/1min.mp3");
	AddFileToDownloadsTable("sound/sourcemod/basebuilder/2min.mp3"); 
	AddFileToDownloadsTable("sound/sourcemod/basebuilder/5sec.mp3"); 
	AddFileToDownloadsTable("sound/sourcemod/basebuilder/10sec.mp3"); 
	AddFileToDownloadsTable("sound/sourcemod/basebuilder/30sec.mp3"); 
	AddFileToDownloadsTable("sound/sourcemod/basebuilder/block_drop.mp3"); 
	AddFileToDownloadsTable("sound/sourcemod/basebuilder/block_grab.mp3"); 
	AddFileToDownloadsTable("sound/sourcemod/basebuilder/hit.mp3"); 
	AddFileToDownloadsTable("sound/sourcemod/basebuilder/phase_build.mp3"); 
	AddFileToDownloadsTable("sound/sourcemod/basebuilder/phase_prep.mp3"); 
	AddFileToDownloadsTable("sound/sourcemod/basebuilder/round_start.mp3"); 
	AddFileToDownloadsTable("sound/sourcemod/basebuilder/round_start2.mp3"); 
	AddFileToDownloadsTable("sound/sourcemod/basebuilder/win_builders.mp3"); 
	AddFileToDownloadsTable("sound/sourcemod/basebuilder/win_zombies.mp3"); 
	AddFileToDownloadsTable("sound/sourcemod/basebuilder/zombie_kill.mp3");
	
	PrecacheSoundAny("sourcemod/basebuilder/1min.mp3");
	PrecacheSoundAny("sourcemod/basebuilder/2min.mp3");
	PrecacheSoundAny("sourcemod/basebuilder/5sec.mp3");
	PrecacheSoundAny("sourcemod/basebuilder/10sec.mp3");
	PrecacheSoundAny("sourcemod/basebuilder/30sec.mp3");
	PrecacheSoundAny("sourcemod/basebuilder/block_drop.mp3");
	PrecacheSoundAny("sourcemod/basebuilder/block_grab.mp3"); 
	PrecacheSoundAny("sourcemod/basebuilder/hit.mp3");
	PrecacheSoundAny("sourcemod/basebuilder/phase_build.mp3");
	PrecacheSoundAny("sourcemod/basebuilder/phase_prep.mp3");
	PrecacheSoundAny("sourcemod/basebuilder/round_start.mp3");
	PrecacheSoundAny("sourcemod/basebuilder/round_start2.mp3");
	PrecacheSoundAny("sourcemod/basebuilder/win_builders.mp3");
	PrecacheSoundAny("sourcemod/basebuilder/win_zombies.mp3");
	PrecacheSoundAny("sourcemod/basebuilder/zombie_kill.mp3");
	
	PrecacheSound(SOUND_FREEZE);
	PrecacheSoundAny(SOUND_FREEZE);
	PrecacheSound(SOUND_FREEZE_EXPLODE);
	PrecacheSoundAny(SOUND_FREEZE_EXPLODE);
	
	// **	ZOMBIES		** //
	
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/mummy/mummy.vmt");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/mummy/mummy.vtf");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/mummy/mummy_n.vtf");
	AddFileToDownloadsTable("models/player/custom_player/zombie/mummy/mummy.dx90.vtx");
	AddFileToDownloadsTable("models/player/custom_player/zombie/mummy/mummy.mdl");
	AddFileToDownloadsTable("models/player/custom_player/zombie/mummy/mummy.phy");
	AddFileToDownloadsTable("models/player/custom_player/zombie/mummy/mummy.vvd");
	AddFileToDownloadsTable("models/player/custom_player/zombie/mummy/mummy_arms.dx90.vtx");
	AddFileToDownloadsTable("models/player/custom_player/zombie/mummy/mummy_arms.mdl");
	AddFileToDownloadsTable("models/player/custom_player/zombie/mummy/mummy_arms.vvd");
	
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/crimsonhead/crimsonheadhead_d.vmt");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/crimsonhead/crimsonheadhead_d.vtf");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/crimsonhead/crimsonheadhead_n.vtf");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/crimsonhead/crimsonheadhead_s.vtf");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/crimsonhead/crimsonheadtorso_d.vmt");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/crimsonhead/crimsonheadtorso_d.vtf");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/crimsonhead/crimsonheadtorso_n.vtf");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/crimsonhead/crimsonheadtorso_s.vtf");
	AddFileToDownloadsTable("models/player/custom_player/zombie/crimsonhead/crimsonhead.dx90.vtx");
	AddFileToDownloadsTable("models/player/custom_player/zombie/crimsonhead/crimsonhead.mdl");
	AddFileToDownloadsTable("models/player/custom_player/zombie/crimsonhead/crimsonhead.phy");
	AddFileToDownloadsTable("models/player/custom_player/zombie/crimsonhead/crimsonhead.vvd");
	AddFileToDownloadsTable("models/player/custom_player/zombie/crimsonhead/crimsonhead_arms.dx90.vtx");
	AddFileToDownloadsTable("models/player/custom_player/zombie/crimsonhead/crimsonhead_arms.mdl");
	AddFileToDownloadsTable("models/player/custom_player/zombie/crimsonhead/crimsonhead_arms.vvd");
	
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/revenant/body.vmt");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/revenant/body.vtf");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/revenant/body_n.vtf");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/revenant/body_s.vtf");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/revenant/hat.vmt");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/revenant/hat.vtf");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/revenant/hat_n.vtf");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/revenant/hat_s.vtf");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/revenant/head.vmt");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/revenant/head.vtf");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/revenant/head_n.vtf");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/revenant/head_s.vtf");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/revenant/head_glow.vtf");
	AddFileToDownloadsTable("models/player/custom_player/zombie/revenant/revenant_v2.mdl");
	AddFileToDownloadsTable("models/player/custom_player/zombie/revenant/revenant_v2.dx90.vtx");
	AddFileToDownloadsTable("models/player/custom_player/zombie/revenant/revenant_v2.phy");
	AddFileToDownloadsTable("models/player/custom_player/zombie/revenant/revenant_v2.vvd");
	AddFileToDownloadsTable("models/player/custom_player/zombie/revenant/revenant_arms.mdl");
	AddFileToDownloadsTable("models/player/custom_player/zombie/revenant/revenant_arms.dx90.vtx");
	AddFileToDownloadsTable("models/player/custom_player/zombie/revenant/revenant_arms.vvd");
	
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/romeo_zombie/cloth.vtf");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/romeo_zombie/cloth_n.vtf");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/romeo_zombie/cloth.vmt");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/romeo_zombie/face.vtf");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/romeo_zombie/face_n.vtf");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/romeo_zombie/face.vmt");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/romeo_zombie/hair.vtf");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/romeo_zombie/hair_n.vtf");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/romeo_zombie/hair.vmt");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/romeo_zombie/hands.vtf");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/romeo_zombie/hands_n.vtf");
	AddFileToDownloadsTable("materials/models/player/custom_player/zombie/romeo_zombie/hands.vmt");
	AddFileToDownloadsTable("models/player/custom_player/zombie/romeo_zombie/romeo_zombie.dx90.vtx");
	AddFileToDownloadsTable("models/player/custom_player/zombie/romeo_zombie/romeo_zombie.mdl");
	AddFileToDownloadsTable("models/player/custom_player/zombie/romeo_zombie/romeo_zombie.phy");
	AddFileToDownloadsTable("models/player/custom_player/zombie/romeo_zombie/romeo_zombie.vvd");
	AddFileToDownloadsTable("models/player/custom_player/zombie/romeo_zombie/romeo_zombie_arms.dx90.vtx");
	AddFileToDownloadsTable("models/player/custom_player/zombie/romeo_zombie/romeo_zombie_arms.mdl");
	AddFileToDownloadsTable("models/player/custom_player/zombie/romeo_zombie/romeo_zombie_arms.vvd");

	

	PrecacheModel("materials/models/player/custom_player/zombie/mummy/mummy.vmt");
	PrecacheModel("materials/models/player/custom_player/zombie/mummy/mummy.vtf");
	PrecacheModel("materials/models/player/custom_player/zombie/mummy/mummy_n.vtf");
	PrecacheModel("models/player/custom_player/zombie/mummy/mummy.dx90.vtx");
	PrecacheModel("models/player/custom_player/zombie/mummy/mummy.mdl");
	PrecacheModel("models/player/custom_player/zombie/mummy/mummy.phy");
	PrecacheModel("models/player/custom_player/zombie/mummy/mummy.vvd");
	PrecacheModel("models/player/custom_player/zombie/mummy/mummy_arms.dx90.vtx");
	PrecacheModel("models/player/custom_player/zombie/mummy/mummy_arms.mdl");
	PrecacheModel("models/player/custom_player/zombie/mummy/mummy_arms.vvd");
	
	PrecacheModel("materials/models/player/custom_player/zombie/crimsonhead/crimsonheadhead_d.vmt");
	PrecacheModel("materials/models/player/custom_player/zombie/crimsonhead/crimsonheadhead_d.vtf");
	PrecacheModel("materials/models/player/custom_player/zombie/crimsonhead/crimsonheadhead_n.vtf");
	PrecacheModel("materials/models/player/custom_player/zombie/crimsonhead/crimsonheadhead_s.vtf");
	PrecacheModel("materials/models/player/custom_player/zombie/crimsonhead/crimsonheadtorso_d.vmt");
	PrecacheModel("materials/models/player/custom_player/zombie/crimsonhead/crimsonheadtorso_d.vtf");
	PrecacheModel("materials/models/player/custom_player/zombie/crimsonhead/crimsonheadtorso_n.vtf");
	PrecacheModel("materials/models/player/custom_player/zombie/crimsonhead/crimsonheadtorso_s.vtf");
	PrecacheModel("models/player/custom_player/zombie/crimsonhead/crimsonhead.dx90.vtx");
	PrecacheModel("models/player/custom_player/zombie/crimsonhead/crimsonhead.mdl");
	PrecacheModel("models/player/custom_player/zombie/crimsonhead/crimsonhead.phy");
	PrecacheModel("models/player/custom_player/zombie/crimsonhead/crimsonhead.vvd");
	PrecacheModel("models/player/custom_player/zombie/crimsonhead/crimsonhead_arms.dx90.vtx");
	PrecacheModel("models/player/custom_player/zombie/crimsonhead/crimsonhead_arms.mdl");
	PrecacheModel("models/player/custom_player/zombie/crimsonhead/crimsonhead_arms.vvd");
	
	PrecacheModel("materials/models/player/custom_player/zombie/revenant/body.vmt");
	PrecacheModel("materials/models/player/custom_player/zombie/revenant/body.vtf");
	PrecacheModel("materials/models/player/custom_player/zombie/revenant/body_n.vtf");
	PrecacheModel("materials/models/player/custom_player/zombie/revenant/body_s.vtf");
	PrecacheModel("materials/models/player/custom_player/zombie/revenant/hat.vmt");
	PrecacheModel("materials/models/player/custom_player/zombie/revenant/hat.vtf");
	PrecacheModel("materials/models/player/custom_player/zombie/revenant/hat_n.vtf");
	PrecacheModel("materials/models/player/custom_player/zombie/revenant/hat_s.vtf");
	PrecacheModel("materials/models/player/custom_player/zombie/revenant/head.vmt");
	PrecacheModel("materials/models/player/custom_player/zombie/revenant/head.vtf");
	PrecacheModel("materials/models/player/custom_player/zombie/revenant/head_n.vtf");
	PrecacheModel("materials/models/player/custom_player/zombie/revenant/head_s.vtf");
	PrecacheModel("materials/models/player/custom_player/zombie/revenant/head_glow.vtf");
	PrecacheModel("models/player/custom_player/zombie/revenant/revenant_v2.mdl");
	PrecacheModel("models/player/custom_player/zombie/revenant/revenant_v2.dx90.vtx");
	PrecacheModel("models/player/custom_player/zombie/revenant/revenant_v2.phy");
	PrecacheModel("models/player/custom_player/zombie/revenant/revenant_v2.vvd");
	PrecacheModel("models/player/custom_player/zombie/revenant/revenant_arms.mdl");
	PrecacheModel("models/player/custom_player/zombie/revenant/revenant_arms.dx90.vtx");
	PrecacheModel("models/player/custom_player/zombie/revenant/revenant_arms.vvd");
	
	//ROMEO ZOMBIE
	PrecacheModel("materials/models/player/custom_player/zombie/romeo_zombie/cloth.vtf");
	PrecacheModel("materials/models/player/custom_player/zombie/romeo_zombie/cloth_n.vtf");
	PrecacheModel("materials/models/player/custom_player/zombie/romeo_zombie/cloth.vmt");
	PrecacheModel("materials/models/player/custom_player/zombie/romeo_zombie/face.vtf");
	PrecacheModel("materials/models/player/custom_player/zombie/romeo_zombie/face_n.vtf");
	PrecacheModel("materials/models/player/custom_player/zombie/romeo_zombie/face.vmt");
	PrecacheModel("materials/models/player/custom_player/zombie/romeo_zombie/hair.vtf");
	PrecacheModel("materials/models/player/custom_player/zombie/romeo_zombie/hair_n.vtf");
	PrecacheModel("materials/models/player/custom_player/zombie/romeo_zombie/hair.vmt");
	PrecacheModel("materials/models/player/custom_player/zombie/romeo_zombie/hands.vtf");
	PrecacheModel("materials/models/player/custom_player/zombie/romeo_zombie/hands_n.vtf");
	PrecacheModel("materials/models/player/custom_player/zombie/romeo_zombie/hands.vmt");
	PrecacheModel("models/player/custom_player/zombie/romeo_zombie/romeo_zombie.dx90.vtx");
	PrecacheModel("models/player/custom_player/zombie/romeo_zombie/romeo_zombie.mdl");
	PrecacheModel("models/player/custom_player/zombie/romeo_zombie/romeo_zombie.phy");
	PrecacheModel("models/player/custom_player/zombie/romeo_zombie/romeo_zombie.vvd");
	PrecacheModel("models/player/custom_player/zombie/romeo_zombie/romeo_zombie_arms.dx90.vtx");
	PrecacheModel("models/player/custom_player/zombie/romeo_zombie/romeo_zombie_arms.mdl");
	PrecacheModel("models/player/custom_player/zombie/romeo_zombie/romeo_zombie_arms.vvd");

	
	g_sprite = PrecacheModel("materials/sprites/laserbeam.vmt");
	PrecacheModel("models/weapons/t_arms_professional.mdl");
	
	BeamSprite = PrecacheModel("materials/sprites/laserbeam.vmt");
	//PrecacheModel("models/player/forest/zombie.mdl");


}