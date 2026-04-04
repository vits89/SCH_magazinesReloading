params [
    ["_magazineForInsertingAmmo", [], [[]], 3],
    ["_magazineForRemovingAmmo", [], [[]], 3],
    ["_container", objNull, [objNull]]
];

if ((_magazineForInsertingAmmo isEqualTo []) or { _magazineForRemovingAmmo isEqualTo [] }
    or { isNull _container }) exitWith { false };

privateAll;

_checkIfMagazineExist = {
	(_magazines findIf { ((_x select 0) == (_this select 0)) and { (_x select 1) == (_this select 2) } }) >= 0
};

_magazines = magazinesAmmoCargo _container;

if (!(_magazineForInsertingAmmo call _checkIfMagazineExist)
	or { !(_magazineForRemovingAmmo call _checkIfMagazineExist) }) exitWith { false };

_magazinesAreCompatible = [
	_magazineForInsertingAmmo select 0,
	_magazineForRemovingAmmo select 0
] call SCH_magazinesReloading_fnc_checkIfMagazinesAreCompatible;

if (!_magazinesAreCompatible) exitWith { false };

if ((_magazineForInsertingAmmo isEqualTo _magazineForRemovingAmmo)
	and { (_magazineForInsertingAmmo select 1) == 1 }) exitWith { false };

_ammoCount = getNumber (configFile >> "CfgMagazines" >> (_magazineForInsertingAmmo select 0) >> "count");

if (((_magazineForInsertingAmmo select 2) == _ammoCount)
	or { (_magazineForRemovingAmmo select 2) == 0 }) exitWith { false };

_container addMagazineAmmoCargo [_magazineForInsertingAmmo select 0, -1, _magazineForInsertingAmmo select 2];
_container addMagazineAmmoCargo [_magazineForRemovingAmmo select 0, -1, _magazineForRemovingAmmo select 2];

_magazineForInsertingAmmo set [2, (_magazineForInsertingAmmo select 2) + (_magazineForRemovingAmmo select 2)];

if ((_magazineForInsertingAmmo select 2) > _ammoCount) then {
	_magazineForRemovingAmmo set [2, (_magazineForInsertingAmmo select 2) - _ammoCount];
	_magazineForInsertingAmmo set [2, _ammoCount];
} else {
	_magazineForRemovingAmmo set [2, 0];
};

_container addMagazineAmmoCargo [_magazineForInsertingAmmo select 0, 1, _magazineForInsertingAmmo select 2];

if ((_magazineForRemovingAmmo select 2) > 0) then {
	_container addMagazineAmmoCargo [_magazineForRemovingAmmo select 0, 1, _magazineForRemovingAmmo select 2];
};

true
