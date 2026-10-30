params [
	["_magazineForInsertingAmmo", [], [[]]],
	["_magazineForRemovingAmmo", [], [[]]]
];

private _types = ["", 0, 0];

if (!(_magazineForInsertingAmmo isEqualTypeParams _types)
	or { !(_magazineForRemovingAmmo isEqualTypeParams _types) }) exitWith { false };

if (((_magazineForInsertingAmmo select 0) == "") or { (_magazineForRemovingAmmo select 0) == "" }) exitWith { false };

private ["_magazineForInsertingAmmoConfig", "_magazineForRemovingAmmoConfig"];

_magazineForInsertingAmmoConfig = configFile >> "CfgMagazines" >> (_magazineForInsertingAmmo select 0);
_magazineForRemovingAmmoConfig = configFile >> "CfgMagazines" >> (_magazineForRemovingAmmo select 0);

if (!(isClass _magazineForInsertingAmmoConfig) or { !(isClass _magazineForRemovingAmmoConfig) }) exitWith { false };
if ((getText (_magazineForInsertingAmmoConfig >> "ammo"))
	!= (getText (_magazineForRemovingAmmoConfig >> "ammo"))) exitWith { false };
if (((_magazineForInsertingAmmo select 1) <= 0) or { (_magazineForRemovingAmmo select 1) <= 0 }) exitWith { false };

private _typesCount = count _types;

if (((_magazineForInsertingAmmo select [0, _typesCount]) isEqualTo (_magazineForRemovingAmmo select [0, _typesCount]))
	and { (_magazineForInsertingAmmo select 1) == 1 }) exitWith { false };

((_magazineForInsertingAmmo select 2) < (getNumber (_magazineForInsertingAmmoConfig >> "count")))
	and { (_magazineForRemovingAmmo select 2) > 0 }
