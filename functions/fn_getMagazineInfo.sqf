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

privateAll;

_indices = [];

for "_i" from 0 to (_itemsCount - 1) do {
	if ((_control lbData _i) == _className) then {
		_indices pushBack _i;
	};
};

_magazines = (magazinesAmmoCargo _container) select { (_x select 0) == _className };

if ((count _magazines) == 0) exitWith { _magazineInfo };

_magazines = (_magazines call BIS_fnc_consolidateArray) apply { flatten _x };

_magazines sort false;

_magazineInfo = _magazines select (_indices find _index);

[_magazineInfo select 0, _magazineInfo select 2, _magazineInfo select 1]
