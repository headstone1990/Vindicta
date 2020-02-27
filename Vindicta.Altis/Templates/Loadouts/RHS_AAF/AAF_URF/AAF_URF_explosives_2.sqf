removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

_RandomHeadgear = selectRandom ["FGN_AAF_PASGT","FGN_AAF_PASGT_ESS","FGN_AAF_PASGT_ESS_2","FGN_AAF_PASGT_Type07","FGN_AAF_PASGT_Type07_ESS","FGN_AAF_PASGT_Type07_ESS_2"];
this addHeadgear _RandomHeadgear;
_RandomGoggles = selectRandom ["rhs_scarf","","",""];
this addGoggles _RandomGoggles;
this forceAddUniform "FGN_AAF_M10_Type07_Summer";
this addVest "V_EOD_olive_F";
this addBackpack "FGN_AAF_Bergen_Engineer_Type07";

this addWeapon "rhs_weap_m21s";
this addPrimaryWeaponItem "rhs_acc_2dpZenit";
this addPrimaryWeaponItem "rhsgref_30rnd_556x45_m21";

this addItemToUniform "FirstAidKit";
this addItemToUniform "FGN_AAF_PatrolCap_Type07";
for "_i" from 1 to 2 do {this addItemToVest "rhsgref_30rnd_556x45_m21";};
for "_i" from 1 to 2 do {this addItemToBackpack "rhsgref_30rnd_556x45_m21";};
for "_i" from 1 to 2 do {this addItemToBackpack "rhs_grenade_mkii_mag";};
this addItemToBackpack "rhs_mine_ozm72_a_mag";
this addItemToBackpack "rhs_mine_ozm72_b_mag";
this addItemToBackpack "rhs_mine_msk40p_green_mag";
this addItemToBackpack "rhs_mine_sm320_green_mag";
for "_i" from 1 to 3 do {this addItemToBackpack "rhs_mag_mine_pfm1";};
for "_i" from 1 to 3 do {this addItemToBackpack "rhs_mine_pmn2_mag";};
this linkItem "ItemWatch";
this linkItem "ItemRadio";








