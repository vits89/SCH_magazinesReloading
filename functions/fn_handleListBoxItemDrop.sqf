params [
	["_control", controlNull, [controlNull]],
	["_x", 0, [0]],
	["_y", 0, [0]],
	["_listBoxIdc", -1, [0]],
	["_itemsInfo", [], [[]]]
];

if ((isNull _control) or { _listBoxIdc < 0 } or { _itemsInfo isEqualTo [] }) exitWith { };

_display = ctrlParent _control;

_control = _display displayCtrl _listBoxIdc;

_itemHeight = getNumber (configFile >> "RscDisplayInventory" >> "Controls" >> (ctrlClassName _control) >> "rowHeight");

(_itemsInfo select 0) params ["", ["_index", -1, [0]]];

_magazineForRemovingAmmo = [_control, _index] call SCH_magazinesReloading_fnc_getMagazineInfo;

_index = [_control, [_x, _y], _itemHeight] call SCH_magazinesReloading_fnc_getListBoxItemIndex;
_magazineForInsertingAmmo = [_control, _index] call SCH_magazinesReloading_fnc_getMagazineInfo;

[
	_magazineForInsertingAmmo,
	_magazineForRemovingAmmo,
	[_control] call SCH_magazinesReloading_fnc_getEquipmentContainer,
	_display
] spawn SCH_magazinesReloading_fnc_reloadMagazines;
