params [
	["_control", controlNull, [controlNull]],
	["_itemsInfo", [], [[]]]
];

if ((isNull _control) or { _itemsInfo isEqualTo [] }) exitWith { };

(_itemsInfo select 0) params ["", ["_index", -1, [0]]];

_magazineInfo = [_control, _index] call SCH_magazinesReloading_fnc_getMagazineInfo;

if ((_magazineInfo isEqualTo []) or { (_magazineInfo param [2, 0]) == 0 }) exitWith { };

(ctrlParent _control) setVariable ["SCH_magazinesReloading_var_magazineInfo", _magazineInfo];
