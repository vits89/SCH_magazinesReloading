#include "..\definitions.hpp"

if (!canSuspend) exitWith { };

params [
    ["_magazineForInsertingAmmo", [], [[]], 3],
    ["_magazineForRemovingAmmo", [], [[]], 3],
    ["_container", objNull, [objNull]],
	["_display", displayNull, [displayNull]]
];

if ((_magazineForInsertingAmmo isEqualTo []) or { _magazineForRemovingAmmo isEqualTo [] }
    or { isNull _container } or { isNull _display }) exitWith { };

_checkIfMagazineExist = {
	(_magazines findIf { ((_x select 0) == (_this select 0)) and { (_x select 1) == (_this select 2) } }) >= 0
};

_magazines = magazinesAmmoCargo _container;

if (!(_magazineForInsertingAmmo call _checkIfMagazineExist)
	or { !(_magazineForRemovingAmmo call _checkIfMagazineExist) }) exitWith { };

_magazinesAreCompatible = [
	_magazineForInsertingAmmo select 0,
	_magazineForRemovingAmmo select 0
] call SCH_magazinesReloading_fnc_checkIfMagazinesAreCompatible;

if (!_magazinesAreCompatible) exitWith { };

if ((_magazineForInsertingAmmo isEqualTo _magazineForRemovingAmmo)
	and { (_magazineForInsertingAmmo select 1) == 1 }) exitWith { };

_ammoCountMax = getNumber (configFile >> "CfgMagazines" >> (_magazineForInsertingAmmo select 0) >> "count");

if (((_magazineForInsertingAmmo select 2) == _ammoCountMax)
	or { (_magazineForRemovingAmmo select 2) == 0 }) exitWith { };

_ammoCount = (_magazineForInsertingAmmo select 2) + (_magazineForRemovingAmmo select 2);

_ammoCount = if (_ammoCount > _ammoCountMax) then {
	_ammoCountMax - (_magazineForInsertingAmmo select 2)
} else { _magazineForRemovingAmmo select 2 };

_progress = 0;
_progressInc = PROGRESS_UPDATE_PERIOD / (SECONDS_PER_ROUND * _ammoCount);

localNamespace setVariable ["SCH_magazinesReloading_var_isReloading", true];

[] call SCH_magazinesReloading_fnc_lockInventory;

_controls = [_display] call SCH_magazinesReloading_fnc_createProgressBar;

_controls params ["_progressBar", "_progressValue"];

_container addMagazineAmmoCargo [_magazineForInsertingAmmo select 0, -1, _magazineForInsertingAmmo select 2];
_container addMagazineAmmoCargo [_magazineForRemovingAmmo select 0, -1, _magazineForRemovingAmmo select 2];

_progressValue ctrlSetStructuredText (parseText (format [
	PROGRESS_VALUE_FORMAT,
	_magazineForInsertingAmmo select 2,
	_ammoCountMax
]));

for "_n" from 1 to _ammoCount do {
	for "_m" from 1 to SECONDS_PER_ROUND / PROGRESS_UPDATE_PERIOD do {
		uiSleep PROGRESS_UPDATE_PERIOD;

		_progress = _progress + _progressInc;

		_progressBar progressSetPosition _progress;
	};

	if ((isNull _display) or { isNull _container }) exitWith { };

	_magazineForRemovingAmmo set [2, (_magazineForRemovingAmmo select 2) - 1];
	_magazineForInsertingAmmo set [2, (_magazineForInsertingAmmo select 2) + 1];

	_progressValue ctrlSetStructuredText (parseText (format [
		PROGRESS_VALUE_FORMAT,
		_magazineForInsertingAmmo select 2,
		_ammoCountMax
	]));
};

if (!(isNull _display)) then {
	uiSleep 0.25;
};

if (!(isNull _container)) then {
	_container addMagazineAmmoCargo [_magazineForInsertingAmmo select 0, 1, _magazineForInsertingAmmo select 2];

	if ((_magazineForRemovingAmmo select 2) > 0) then {
		_container addMagazineAmmoCargo [_magazineForRemovingAmmo select 0, 1, _magazineForRemovingAmmo select 2];
	};
};

if (!(isNull _display)) then {
	{
		ctrlDelete _x;
	} forEach _controls;

	[false] call SCH_magazinesReloading_fnc_lockInventory;

	_display setVariable ["SCH_magazinesReloading_var_magazineInfo", nil];
};

localNamespace setVariable ["SCH_magazinesReloading_var_isReloading", false];
