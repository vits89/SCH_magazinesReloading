#include "..\definitions.hpp"

if (!canSuspend) exitWith { scriptNull };

if (localNamespace getVariable ["SCH_magazinesReloading_var_isReloading", false]) exitWith { };

params [
    ["_magazineForInsertingAmmo", [], [[]], 4],
    ["_magazineForRemovingAmmo", [], [[]], 4],
	["_display", displayNull, [displayNull]]
];

if ((_magazineForInsertingAmmo isEqualTo []) or { _magazineForRemovingAmmo isEqualTo [] }
    or { isNull _display }) exitWith { };

_countMagazines = {
	params ["_magazineInfo", ["_container", objNull]];

	if (isNull _container) then {
		_container = _magazineInfo select 3;
	};

	{
		((_x select 0) == (_magazineInfo select 0)) and { (_x select 1) == (_magazineInfo select 2) }
	} count (magazinesAmmoCargo _container)
};

_magazineRemoved = if ((_magazineForInsertingAmmo select 3) != (_magazineForRemovingAmmo select 3)) then {
	([_magazineForRemovingAmmo] call _countMagazines) < (_magazineForRemovingAmmo select 1)
} else { false };
_container =
	if (_magazineRemoved) then { _magazineForInsertingAmmo select 3 } else { _magazineForRemovingAmmo select 3 };

if ((([_magazineForInsertingAmmo] call _countMagazines) == 0)
	or { ([_magazineForRemovingAmmo, _container] call _countMagazines) == 0 }) exitWith { };

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

[true, _display] call SCH_magazinesReloading_fnc_lockInventory;

_controls = [_display] call SCH_magazinesReloading_fnc_createProgressBar;

_controls params ["_progressBar", "_progressValue"];

(_magazineForInsertingAmmo select 3) addMagazineAmmoCargo [
	_magazineForInsertingAmmo select 0,
	-1,
	_magazineForInsertingAmmo select 2
];
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

	if ((isNull _display) or { isNull (_magazineForInsertingAmmo select 3) }
		or { isNull (_magazineForRemovingAmmo select 3) }) exitWith { };

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

if (!(isNull (_magazineForInsertingAmmo select 3))) then {
	(_magazineForInsertingAmmo select 3) addMagazineAmmoCargo [
		_magazineForInsertingAmmo select 0,
		1,
		_magazineForInsertingAmmo select 2
	];
};

if (((_magazineForRemovingAmmo select 2) > 0) and { !(isNull (_magazineForRemovingAmmo select 3)) }) then {
	(_magazineForRemovingAmmo select 3) addMagazineAmmoCargo [
		_magazineForRemovingAmmo select 0,
		1,
		_magazineForRemovingAmmo select 2
	];
};

if (!(isNull _display)) then {
	{
		ctrlDelete _x;
	} forEach _controls;

	[false, _display] call SCH_magazinesReloading_fnc_lockInventory;
};

localNamespace setVariable ["SCH_magazinesReloading_var_isReloading", false];
