#include "\a3\ui_f\hpp\defineResincl.inc"

params [
	["_control", controlNull, [controlNull]],
	["_x", 0, [0]],
	["_y", 0, [0]],
	["_listBoxIdc", -1, [0]],
	["_itemsInfo", [], [[]]]
];

if ((isNull _control) or { _listBoxIdc < 0 } or { _itemsInfo isEqualTo [] }) exitWith { };

_display = ctrlParent _control;

(_itemsInfo select 0) params ["", ["_index", -1, [0]]];

_magazineForRemovingAmmo = [_display displayCtrl _listBoxIdc, _index] call SCH_magazinesReloading_fnc_getMagazineInfo;

_idcs = switch (ctrlIDC _control) do {
	case IDC_FG_CONTAINER_MARKER: { [IDC_FG_UNIFORM_CONTAINER, IDC_FG_VEST_CONTAINER, IDC_FG_BACKPACK_CONTAINER] };
	case IDC_FG_GROUND_MARKER: { [IDC_FG_CHOSEN_CONTAINER, IDC_FG_GROUND_ITEMS] };
	default { [] };
};

_index = _idcs findIf { ctrlVisible _x };

if (_index < 0) exitWith { };

_control = _display displayCtrl (_idcs select _index);

_itemHeight = getNumber (configFile >> "RscDisplayInventory" >> "Controls" >> (ctrlClassName _control) >> "rowHeight");

_index = [_control, [_x, _y], _itemHeight] call SCH_magazinesReloading_fnc_getListBoxItemIndex;
_magazineForInsertingAmmo = [_control, _index] call SCH_magazinesReloading_fnc_getMagazineInfo;

[_magazineForInsertingAmmo, _magazineForRemovingAmmo, _display] spawn SCH_magazinesReloading_fnc_reloadMagazines;
