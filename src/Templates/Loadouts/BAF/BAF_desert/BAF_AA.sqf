removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

this addHeadgear "UK3CB_BAF_H_Mk6_DDPM_C";
this forceAddUniform "UK3CB_BAF_U_CombatUniform_DDPM";
this addVest "UK3CB_BAF_V_Osprey_DDPM8";
this addBackpack "UK3CB_BAF_B_Bergen_TAN_Rifleman_B";

this addWeapon "UK3CB_BAF_L85A3";
this addWeapon "rhs_weap_fim92";
this addPrimaryWeaponItem "rhs_mag_30Rnd_556x45_M855A1_Stanag";
this addSecondaryWeaponItem "rhs_fim92_mag";

for "_i" from 1 to 10 do {this addItemToUniform "ACE_fieldDressing";};
for "_i" from 1 to 2 do {this addItemToUniform "ACE_epinephrine";};
for "_i" from 1 to 2 do {this addItemToUniform "ACE_splint";};
for "_i" from 1 to 4 do {this addItemToUniform "ACE_tourniquet";};
this addItemToUniform "ACE_morphine";
this addItemToUniform "ACE_EntrenchingTool";
this addItemToUniform "ACE_EarPlugs";
this addItemToUniform "ACRE_PRC152";

for "_i" from 1 to 8 do {this addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag";};
for "_i" from 1 to 2 do {this addItemToVest "rhs_mag_30Rnd_556x45_Mk262_Stanag";};
for "_i" from 1 to 2 do {this addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red";};
for "_i" from 1 to 2 do {this addItemToVest "UK3CB_BAF_SmokeShellOrange";};
for "_i" from 1 to 2 do {this addItemToVest "rhs_mag_m67";};

for "_i" from 1 to 2 do {this addItemToBackpack "rhs_fim92_mag";};

this linkItem "ItemMap";
this linkItem "ItemGPS";
this linkItem "ItemRadio";
this linkItem "ItemCompass";
this linkItem "ItemWatch";
