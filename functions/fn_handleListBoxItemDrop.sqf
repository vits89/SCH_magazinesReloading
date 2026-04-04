params [
	["_control", controlNull, [controlNull]],
	["_x", 0, [0]],
	["_y", 0, [0]],
	["_listBoxIdc", -1, [0]]
];

if ((isNull _control) or { _listBoxIdc < 0 }) exitWith { };

_display = ctrlParent _control;

_display setVariable ["SCH_magazinesReloading_var_isDragging", false];

_control spawn {
	ctrlDelete _this;
};

_control = _display displayCtrl _listBoxIdc;

_itemHeight = getNumber (configFile >> "RscDisplayInventory" >> "Controls" >> (ctrlClassName _control) >> "rowHeight");

_index = [_control, [_x, _y], _itemHeight] call SCH_magazinesReloading_fnc_getListBoxItemIndex;

_magazineForInsertingAmmo = [_control, _index] call SCH_magazinesReloading_fnc_getMagazineInfo;
_magazineForRemovingAmmo = _display getVariable ["SCH_magazinesReloading_var_magazineInfo", []];

if ((_magazineForInsertingAmmo isEqualTo []) or { _magazineForRemovingAmmo isEqualTo [] }) exitWith {
	_display setVariable ["SCH_magazinesReloading_var_magazineInfo", nil];
};

[
	_magazineForInsertingAmmo,
	_magazineForRemovingAmmo,
	[_control] call SCH_magazinesReloading_fnc_getEquipmentContainer
] call SCH_magazinesReloading_fnc_reloadMagazines;

_display setVariable ["SCH_magazinesReloading_var_magazineInfo", nil];
