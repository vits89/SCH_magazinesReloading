params [
	["_control", controlNull, [controlNull]],
	["_itemsInfo", [], [[]]]
];

if ((isNull _control) or { _itemsInfo isEqualTo [] }) exitWith { };

(_itemsInfo select 0) params ["", ["_index", -1, [0]]];

if (_index < 0) exitWith { };

_magazineInfo = [_control, _index] call SCH_magazinesReloading_fnc_getMagazinesInfo;

if ((_magazineInfo isEqualTo []) or { (_magazineInfo select 2) == 0 }) exitWith { };

_display = ctrlParent _control;

_display setVariable ["SCH_magazinesReloading_var_isDragging", true];
_display setVariable ["SCH_magazinesReloading_var_magazineInfo", _magazineInfo];

[_display] call SCH_magazinesReloading_fnc_createListBoxesItemMarkers;
