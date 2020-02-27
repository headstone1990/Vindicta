/*
custom Altis Armed Forces v 2020 template for ARMA III (AAF2017)
*/

_array = [];

_array set [T_SIZE-1, nil];									//Make an array having the size equal to the number of categories first

// Name, description, faction, addons, etc
_array set [T_NAME, "tRHS_AAF_URF"];
_array set [T_DESCRIPTION, "Units using AAF 2017 and RHS. Based on 2020 variant but include almost all RHS vehicles both USAF and AFRF."];
_array set [T_DISPLAY_NAME, "RHS AAF Ultimate RHS Faction"];
_array set [T_FACTION, T_FACTION_Military];
_array set [T_REQUIRED_ADDONS, [
								"FGN_AAF_Troops",	// AAF 2017
								"rhs_c_troops",		// RHS AFRF
								"rhsusf_c_troops",
								"rhssaf_c_troops",
								"rhsgref_c_troops"]];


//==== Infantry ====
_inf = [];
_inf resize T_INF_SIZE;
_inf set [T_INF_DEFAULT, ["FGN_AAF_Inf_Rifleman"]];

_inf set [T_INF_SL, ["RHS_AAF_URF_SL"]];
_inf set [T_INF_TL, ["RHS_AAF_URF_TL"]];
_inf set [T_INF_officer, ["RHS_AAF_URF_officer"]];
_inf set [T_INF_GL, ["RHS_AAF_URF_grenadier"]];
_inf set [T_INF_rifleman, ["RHS_AAF_URF_rifleman", "RHS_AAF_URF_rifleman_2"]];
_inf set [T_INF_marksman, ["RHS_AAF_URF_marksman", "RHS_AAF_URF_marksman_2"]];
_inf set [T_INF_sniper, ["RHS_AAF_URF_sniper", "RHS_AAF_URF_sniper_2", "RHS_AAF_URF_sniper_3"]];
_inf set [T_INF_spotter, ["RHS_AAF_URF_spotter", "RHS_AAF_URF_spotter_2"]];
_inf set [T_INF_exp, ["RHS_AAF_URF_explosives", "RHS_AAF_URF_explosives_2", "RHS_AAF_URF_explosives_3"]];
_inf set [T_INF_ammo, ["RHS_AAF_URF_MG_2", "RHS_AAF_URF_AT_2", "RHS_AAF_URF_AT_5"]];
_inf set [T_INF_LAT, ["RHS_AAF_URF_LAT"]];
_inf set [T_INF_AT, ["RHS_AAF_URF_AT", "RHS_AAF_URF_AT_3", "RHS_AAF_URF_AT_4"]];
_inf set [T_INF_AA, ["RHS_AAF_URF_AA"]];
_inf set [T_INF_LMG, ["RHS_AAF_URF_LMG", "RHS_AAF_URF_LMG_2", "RHS_AAF_URF_LMG_3"]];
_inf set [T_INF_HMG, ["RHS_AAF_URF_MG", "RHS_AAF_URF_MG_3"]];
_inf set [T_INF_medic, ["RHS_AAF_URF_medic"]];
_inf set [T_INF_engineer, ["RHS_AAF_URF_engineer"]];
_inf set [T_INF_crew, ["RHS_AAF_URF_crew"]];
_inf set [T_INF_crew_heli, ["RHS_AAF_URF_helicrew"]];
_inf set [T_INF_pilot, ["RHS_AAF_URF_pilot"]];
_inf set [T_INF_pilot_heli, ["RHS_AAF_URF_helipilot"]];
//_inf set [T_INF_survivor, [""]];
//_inf set [T_INF_unarmed, [""]];

// Recon
_inf set [T_INF_recon_TL, ["RHS_AAF_URF_recon_TL"]];
_inf set [T_INF_recon_rifleman, ["RHS_AAF_URF_recon_LMG"]];
_inf set [T_INF_recon_medic, ["RHS_AAF_URF_recon_medic"]];
_inf set [T_INF_recon_exp, ["RHS_AAF_URF_recon_explosives"]];
_inf set [T_INF_recon_LAT, ["RHS_AAF_URF_recon_LAT"]];
_inf set [T_INF_recon_marksman, ["RHS_AAF_URF_recon_sniper", "RHS_AAF_URF_recon_sniper_2"]];
_inf set [T_INF_recon_JTAC, ["RHS_AAF_URF_recon_JTAC"]];


// Divers, still vanilla
//_inf set [T_INF_diver_TL, [""]];
//_inf set [T_INF_diver_rifleman, [""]];
//_inf set [T_INF_diver_exp, [""]];


//==== Vehicles ====
_veh = +(tDefault select T_VEH);
_veh set [T_VEH_SIZE-1, nil];
_veh set [T_VEH_DEFAULT, ["FGN_AAF_M1025_unarmed"]];

_veh set [T_VEH_car_unarmed, ["FGN_AAF_M1025_unarmed", "FGN_AAF_M998_2D_Fulltop", "FGN_AAF_M998_4D_Fulltop", "FGN_AAF_M998_2D_Halftop"]];
_veh set [T_VEH_car_armed, ["FGN_AAF_M1025_M2", "FGN_AAF_M1025_MK19"]];

//cars are in MRAPS until cars are added properly
_veh set [T_VEH_MRAP_unarmed, ["FGN_AAF_Tigr_M", "FGN_AAF_Tigr", "FGN_AAF_M1025_unarmed", "FGN_AAF_M998_2D_Fulltop", "FGN_AAF_M998_4D_Fulltop", "FGN_AAF_M998_2D_Halftop", "rhsusf_M1220_usarmy_d", "rhsusf_M1230a1_usarmy_d", "rhsusf_M1232_usarmy_d", "rhsusf_m1240a1_usarmy_d", "rhsusf_M1238A1_socom_d", "rhsgref_BRDM2UM_msv"]];
_veh set [T_VEH_MRAP_HMG, ["FGN_AAF_Tigr_STS", "rhsgref_BRDM2_HQ_msv", "rhsgref_BRDM2_msv", "FGN_AAF_M1025_M2", "rhsusf_M1220_M153_M2_usarmy_d", "rhsusf_M1220_M153_M2_usarmy_d", "rhsusf_M1230_M2_usarmy_d", "rhsusf_M1232_M2_usarmy_d", "rhsusf_M1237_M2_usarmy_d", "rhsusf_m1240a1_m2crows_usarmy_d", "rhsusf_m1240a1_m2_usarmy_d", "rhsusf_m1240a1_m240_usarmy_d", "rhsusf_infantry_socom_armysf_rifleman", "rhsusf_m1245_m2crows_socom_d"]];
_veh set [T_VEH_MRAP_GMG, ["rhsgref_BRDM2_ATGM_msv", "FGN_AAF_M1025_MK19", "rhsusf_m1045_d", "rhsusf_M1117_D", "rhsusf_M1220_M153_MK19_usarmy_d", "rhsusf_M1220_MK19_usarmy_d", "rhsusf_M1230_MK19_usarmy_d", "rhsusf_M1232_MK19_usarmy_d", "rhsusf_M1237_MK19_usarmy_d", "rhsusf_M1237_MK19_usarmy_d", "rhsusf_M1237_MK19_usarmy_d", "rhsusf_M1238A1_Mk19_socom_d", "rhsusf_m1245_mk19crows_socom_d"]];

_veh set [T_VEH_IFV, ["rhs_prp3_msv", "rhs_Ob_681_2", "rhs_brm1k_msv", "rhs_bmp1_msv", "rhs_bmp1d_msv", "rhs_bmp1k_msv", "rhs_bmp1p_msv", "rhs_bmp2e_msv", "rhs_bmp2_msv", "rhs_bmp2d_msv", "rhs_bmp2k_msv", "rhs_bmp3_msv", "rhs_bmp3_late_msv", "rhs_bmp3m_msv", "rhs_bmp3mera_msv", "rhs_bmd1", "rhs_bmd1k", "rhs_bmd1p", "rhs_bmd1pk", "rhs_bmd1r", "rhs_bmd2", "rhs_bmd2k", "rhs_bmd2m", "rhs_bmd4_vdv", "rhs_bmd4ma_vdv", "RHS_M2A2", "RHS_M2A2_BUSKI", "RHS_M2A3", "RHS_M2A3_BUSKI", "RHS_M2A3_BUSKIII"]]; 
_veh set [T_VEH_APC, ["rhs_btr60_msv", "rhs_btr70_msv", "rhs_btr80_msv", "rhs_btr80a_msv", "rhsusf_m113d_usarmy_supply", "rhsusf_m113d_usarmy", "rhsusf_m113d_usarmy_MK19", "rhsusf_m113d_usarmy_unarmed", "rhsusf_m113d_usarmy_M240", "rhsusf_stryker_m1126_m2_d"]];
_veh set [T_VEH_MBT, ["rhs_sprut_vdv", "rhs_t72ba_tv", "rhs_t72bb_tv", "rhs_t72bc_tv", "rhs_t72bd_tv", "rhs_t72be_tv", "rhs_t72ba_tv", "rhs_t72bb_tv", "rhs_t72bc_tv", "rhs_t72bd_tv", "rhs_t72be_tv", "rhs_t80", "rhs_t80a", "rhs_t80b", "rhs_t80bk", "rhs_t80bv", "rhs_t80bvk", "rhs_t80u", "rhs_t80u45m", "rhs_t80ue1", "rhs_t80uk", "rhs_t80um", "rhs_t90_tv", "rhs_t90a_tv", "rhs_t90am_tv", "rhs_t90saa_tv", "rhs_t90sab_tv", "rhs_t90sm_tv", "rhs_t14_tv", "rhsusf_m1a1aimd_usarmy", "rhsusf_m1a1aim_tuski_d", "rhsusf_m1a2sep1d_usarmy", "rhsusf_m1a2sep1tuskid_usarmy", "rhsusf_m1a2sep1tuskiid_usarmy", "rhsusf_m1a1fep_d"]]; 
_veh set [T_VEH_MRLS, ["FGN_AAF_BM21", "rhsusf_M142_usarmy_D"]];
_veh set [T_VEH_SPA, ["rhs_2s1_tv", "rhs_2s3_tv", "rhsusf_m109d_usarmy"]];
_veh set [T_VEH_SPAA, ["FGN_AAF_Ural_ZU23", "rhs_zsu234_aa"]]; 

_veh set [T_VEH_stat_HMG_high, ["RHS_M2StaticMG_D", "rhs_KORD_high_MSV", "rhsgref_ins_g_DSHKM"]];
//_veh set [T_VEH_stat_GMG_high, [""]];
_veh set [T_VEH_stat_HMG_low, ["RHS_M2StaticMG_MiniTripod_D"]];
_veh set [T_VEH_stat_GMG_low, ["RHS_MK19_TriPod_D", "rhsgref_ins_g_SPG9M"]]; 
_veh set [T_VEH_stat_AA, ["rhs_Igla_AA_pod_vmf"]];
_veh set [T_VEH_stat_AT, ["RHS_TOW_TriPod_D"]];

_veh set [T_VEH_stat_mortar_light, ["RHS_M252_D"]];
_veh set [T_VEH_stat_mortar_heavy, ["RHS_M119_D"]];

_veh set [T_VEH_heli_light, ["FGN_AAF_KA60_unarmed", "RHS_MELB_H6M", "RHS_MELB_MH6M"]];
_veh set [T_VEH_heli_heavy, ["FGN_AAF_KA60_dynamicLoadout", "RHS_MELB_AH6M"]]; 
_veh set [T_VEH_heli_cargo, ["FGN_AAF_KA60_unarmed"]];
_veh set [T_VEH_heli_attack, ["rhsgref_mi24g_CAS"]];

_veh set [T_VEH_plane_attack, ["FGN_AAF_L159_dynamicLoadout"]];
_veh set [T_VEH_plane_fighter, ["FGN_AAF_L159_dynamicLoadout"]];
//_veh set [T_VEH_plane_cargo, [""]];
//_veh set [T_VEH_plane_unarmed, [""]];
//_veh set [T_VEH_plane_VTOL, [""]];

_veh set [T_VEH_boat_unarmed, ["B_Boat_Transport_01_F", "I_C_Boat_Transport_02_F"]];
_veh set [T_VEH_boat_armed, ["rhsusf_mkvsoc"]];

_veh set [T_VEH_personal, ["B_Quadbike_01_F"]];

_veh set [T_VEH_truck_inf, ["FGN_AAF_Zamak_Open", "FGN_AAF_Zamak"]]; 
//_veh set [T_VEH_truck_cargo, [""]];
_veh set [T_VEH_truck_ammo, ["FGN_AAF_Zamak_Ammo"]];
_veh set [T_VEH_truck_repair, ["FGN_AAF_Zamak_Repair"]];
_veh set [T_VEH_truck_medical , ["FGN_AAF_Zamak_Medic", "rhsusf_m113d_usarmy_medical"]];
_veh set [T_VEH_truck_fuel, ["FGN_AAF_Zamak_Fuel"]];

//_veh set [T_VEH_submarine, [""]];


//==== Drones ====
_drone = +(tDefault select T_DRONE);
//_drone set [T_DRONE_SIZE-1, nil];
//_drone set [T_DRONE_DEFAULT, ["I_UGV_01_F"]];
//_drone set [T_DRONE_UGV_unarmed, ["I_UGV_01_F"]];
//_drone set [T_DRONE_UGV_armed, ["I_UGV_01_rcws_F"]];
//_drone set [T_DRONE_plane_attack, ["I_UAV_02_dynamicLoadout_F"]];
//_drone set [T_DRONE_plane_unarmed, ["I_UAV_02_dynamicLoadout_F"]];
//_drone set [T_DRONE_heli_attack, ["I_UAV_02_dynamicLoadout_F"]];
//_drone set [T_DRONE_quadcopter, ["I_UAV_01_F"]];
//_drone set [T_DRONE_designator, [""]];
//_drone set [T_DRONE_stat_HMG_low, ["I_HMG_01_A_F"]];
//_drone set [T_DRONE_stat_GMG_low, ["I_GMG_01_A_F"]];
//_drone set [T_DRONE_stat_AA, [""]];

//==== Cargo ====
_cargo = +(tDefault select T_CARGO);

//==== Groups ====
_group = +(tDefault select T_GROUP);

//==== Set arrays ====
_array set [T_INF, _inf];
_array set [T_VEH, _veh];
_array set [T_DRONE, _drone];
_array set [T_CARGO, _cargo];
_array set [T_GROUP, _group];

_array // End template
