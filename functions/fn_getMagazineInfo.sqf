#include "\a3\ui_f\hpp\defineResincl.inc"

private ["_itemsCount", "_magazineInfo"];

_magazineInfo = [];

params [
	["_control", controlNull, [controlNull]],
	["_index", -1, [0]]
];

if ((isNull _control) or { (ctrlType _control) != CT_LISTBOX } or {
	_itemsCount = lbSize _control;

	_itemsCount == 0
}) exitWith { _magazineInfo };

if (_index < 0) then {
	_index = lbCurSel _control;
};

if (_index < 0) exitWith { _magazineInfo };

private _className = _control lbData _index;

if (_className == "") exitWith { _magazineInfo };

private _container = [_control] call SCH_magazinesReloading_fnc_getEquipmentContainer;

if (isNull _container) exitWith { _magazineInfo };

private _magazines = (magazinesAmmoCargo _container) select { (_x select 0) == _className };

if ((count _magazines) == 0) exitWith { _magazineInfo };

privateAll;

_indices = [];

for "_i" from 0 to (_itemsCount - 1) do {
	if ((_control lbData _i) == _className) then {
		_indices pushBack _i;
	};
};

_index = _indices find _index;

_magazineCounts = createHashMapFromArray (_magazines call BIS_fnc_consolidateArray);

_magazineAmmoCounts = createHashMap;

{
	_className = _x select 0;
	_ammoCount = _x select 1;

	(_magazineAmmoCounts getOrDefault [_className, [], true]) pushBack _ammoCount;
} forEach (keys _magazineCounts);

_magazinesConfig = configFile >> "CfgMagazines";

_magazineNames = [];

{
	_y sort false;

	_magazineNames pushBack [getText (_magazinesConfig >> _x >> "displayName"), _x];
} forEach _magazineAmmoCounts;

_magazineNames sort true;

_i = 0;

{
	_className = _x select 1;

	{
		if (_i == _index) exitWith {
			_magazineInfo = [_className, _magazineCounts get [_className, _x], _x];
		};

		_i = _i + 1;
	} forEach (_magazineAmmoCounts get _className);

	if (_magazineInfo isNotEqualTo []) exitWith { };
} forEach _magazineNames;

_magazineInfo
