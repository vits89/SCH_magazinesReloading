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

private ["_className", "_magazinesConfig"];

_className = _control lbData _index;

if ((_className == "") or {
	_magazinesConfig = configFile >> "CfgMagazines";

	!(isClass (_magazinesConfig >> _className))
}) exitWith { _magazineInfo };

private _container = [_control] call SCH_magazinesReloading_fnc_getContainer;

if (isNull _container) exitWith { _magazineInfo };

private _magazines = (magazinesAmmoCargo _container) select { (_x select 0) == _className };

if ((count _magazines) == 0) exitWith { _magazineInfo };

privateAll;

_i = -1;

for "_j" from 0 to (_itemsCount - 1) do {
	if ((_control lbData _j) == _className) then {
		_i = _i + 1;
	};

	if (_j == _index) exitWith {
		_index = _i;
	};
};

_magazineCounts = createHashMapFromArray (_magazines call BIS_fnc_consolidateArray);

_magazineAmmoCounts = createHashMap;

{
	_className = _x select 0;
	_ammoCount = _x select 1;

	(_magazineAmmoCounts getOrDefault [_className, [], true]) pushBack _ammoCount;
} forEach (keys _magazineCounts);

_magazineNames = [];

{
	_y sort false;

	_magazineNames pushBack [getText (_magazinesConfig >> _x >> "displayName"), _x];
} forEach _magazineAmmoCounts;

_magazineNames sort true;

_i = 0;

{
	_className = _x select 1;

	_ammoCounts = _magazineAmmoCounts get _className;
	_ammoCountsCount = count _ammoCounts;

	if (_index < (_i + _ammoCountsCount)) exitWith {
		_ammoCount = _ammoCounts select (_index - _i);

		_magazineInfo = [_className, _magazineCounts get [_className, _ammoCount], _ammoCount, _container];
	};

	_i = _i + _ammoCountsCount;
} forEach _magazineNames;

_magazineInfo
