removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

_RandomVest = selectRandom ["FGN_AAF_CIRAS_RF01","FGN_AAF_CIRAS_RF01_Belt","FGN_AAF_CIRAS_RF01_Belt_CamB","FGN_AAF_CIRAS_RF01_CamB"];
this addVest _RandomVest;
_RandomHeadgear = selectRandom ["FGN_AAF_PASGT","FGN_AAF_PASGT_ESS","FGN_AAF_PASGT_ESS_2","FGN_AAF_PASGT_Type07","FGN_AAF_PASGT_Type07_ESS","FGN_AAF_PASGT_Type07_ESS_2"];
this addHeadgear _RandomHeadgear;
_RandomGoggles = selectRandom ["FGN_AAF_Shemag_tan","FGN_AAF_Shemag","rhs_scarf","","",""];
this addGoggles _RandomGoggles;
this forceAddUniform "FGN_AAF_M10_Type07_Summer";

this addWeapon "rhs_weap_ak74m_npz";
this addPrimaryWeaponItem "rhs_30Rnd_545x39_7N10_AK";
this addPrimaryWeaponItem "rhs_acc_2dpZenit";

_RandomScope = selectRandom ["rhs_acc_racurspm", "rhs_acc_racurspm", "rhs_acc_racurspm", "rhs_acc_racurspm", "rhs_acc_racurspm", "rhs_acc_racurspm", "rhsusf_acc_su230"];
this addPrimaryWeaponItem _RandomScope;

_RandomMuzzle = selectRandom ["rhs_acc_dtk", "rhs_acc_dtk", "rhs_acc_dtk", "rhs_acc_dtk", "rhs_acc_dtk", "rhs_acc_dtk", "rhs_acc_dtk", "rhs_acc_dtk", "rhs_acc_tgpa"];
this addPrimaryWeaponItem _RandomMuzzle;

this addItemToUniform "FirstAidKit";
this addItemToUniform "FGN_AAF_PatrolCap_Type07";
for "_i" from 1 to 6 do {this addItemToVest "rhs_30Rnd_545x39_7N10_AK";};
for "_i" from 1 to 2 do {this addItemToVest "rhs_grenade_mkii_mag";};
this linkItem "ItemWatch";
this linkItem "ItemRadio";
