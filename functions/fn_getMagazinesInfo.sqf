#include "\a3\ui_f\hpp\defineResincl.inc"

private ["_itemsCount", "_magazinesInfo"];

_magazinesInfo = [];

params [
	["_control", controlNull, [controlNull]],
	["_index", -1, [0]]
];

if ((isNull _control) or { (ctrlType _control) != CT_LISTBOX } or {
	_itemsCount = lbSize _control;

	_itemsCount == 0
}) exitWith { _magazinesInfo };

private ["_className", "_magazinesConfig"];

_className = "";

_magazinesConfig = configFile >> "CfgMagazines";

if ((_index >= 0) and {
	_className = _control lbData _index;

	(_className == "") or { !(isClass (_magazinesConfig >> _className)) }
}) exitWith { _magazinesInfo };

private _container = [_control] call SCH_magazinesReloading_fnc_getContainer;

if (isNull _container) exitWith { _magazinesInfo };

private _magazines = magazinesAmmoCargo _container;

if (_className != "") then {
	_magazines = _magazines select { (_x select 0) == _className };
};

if ((count _magazines) == 0) exitWith { _magazinesInfo };

privateAll;

_adjustedIndex = _index;

if (_className != "") then {
	_index = -1;

	for "_i" from 0 to (_itemsCount - 1) do {
		if ((_control lbData _i) == _className) then {
			_index = _index + 1;
		};

		if (_i == _adjustedIndex) exitWith {
			_adjustedIndex = _index;
		};
	};
} else {
	for "_i" from 0 to (_itemsCount - 1) do {
		_className = _control lbData _i;

		if (isClass (_magazinesConfig >> _className)) exitWith {
			_index = _i;
		};
	};

	_magazinesInfo append [[], _container];
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

scopeName "main";

_fillMagazinesInfo = if (_adjustedIndex >= 0) then {
	_index = 0;

	{
		if (_adjustedIndex >= (_index + _ammoCountsCount)) exitWith { };

		_ammoCount = _ammoCounts select (_adjustedIndex - _index);

		_magazinesInfo append [_className, _magazineCounts get [_className, _ammoCount], _ammoCount, _container];

		breakTo "main";
	}
} else {
	{
		{
			(_magazinesInfo select 0) pushBack [
				_className,
				_magazineCounts get [_className, _x],
				_x,
				_index + _forEachIndex
			];
		} forEach _ammoCounts;
	}
};

{
	_className = _x select 1;

	_ammoCounts = _magazineAmmoCounts get _className;
	_ammoCountsCount = count _ammoCounts;

	call _fillMagazinesInfo;

	_index = _index + _ammoCountsCount;
} forEach _magazineNames;

_magazinesInfo
