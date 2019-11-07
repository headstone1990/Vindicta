removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

_RandomHeadgear = ["rhs_zsh7a","rhs_zsh7a_alt"] call BIS_fnc_selectRandom;
this addHeadgear _RandomHeadgear;
this forceAddUniform "U_I_pilotCoveralls";

this addWeapon "rhs_weap_tt33";
this addHandgunItem "rhs_mag_762x25_8";

this addItemToUniform "FirstAidKit";
this addItemToUniform "rhs_grenade_anm8_mag";
this addItemToUniform "rhs_grenade_mki_mag";
this addItemToUniform "rhs_mag_nspn_green";
for "_i" from 1 to 3 do {this addItemToUniform "rhs_mag_762x25_8";};

this linkItem "ItemMap";
this linkItem "ItemCompass";
this linkItem "ItemWatch";
this linkItem "ItemRadio";