#include "\a3\ui_f\hpp\defineResincl.inc"

params [
	["_control", controlNull, [controlNull]],
	["_x", 0, [0]],
	["_y", 0, [0]]
];

if (isNull _control) exitWith { };

_display = ctrlParent _control;

[_display] call SCH_magazinesReloading_fnc_removeListBoxesItemMarkers;

_magazineForRemovingAmmo = _display getVariable ["SCH_magazinesReloading_var_magazineInfo", []];

_display setVariable ["SCH_magazinesReloading_var_isDragging", false];
_display setVariable ["SCH_magazinesReloading_var_magazineInfo", nil];

if (_magazineForRemovingAmmo isEqualTo []) exitWith { };

_idc = ctrlIDC _control;

_idcs = switch (_idc) do {
	case IDC_FG_CONTAINER_MARKER: { [IDC_FG_UNIFORM_CONTAINER, IDC_FG_VEST_CONTAINER, IDC_FG_BACKPACK_CONTAINER] };
	case IDC_FG_GROUND_MARKER: { [IDC_FG_CHOSEN_CONTAINER, IDC_FG_GROUND_ITEMS] };
	case IDC_FG_UNIFORM_CONTAINER;
	case IDC_FG_VEST_CONTAINER;
	case IDC_FG_BACKPACK_CONTAINER: { [_idc] };
	default { [] };
};

_index = switch (count _idcs) do {
	case 0: { -1 };
	case 1: { 0 };
	default { _idcs findIf { ctrlVisible _x } };
};

if (_index < 0) exitWith { };

_control = _display displayCtrl (_idcs select _index);

_itemHeight = getNumber (configFile >> "RscDisplayInventory" >> "Controls" >> (ctrlClassName _control) >> "rowHeight");

_index = [_control, [_x, _y], _itemHeight] call SCH_magazinesReloading_fnc_getListBoxItemIndex;

if (_index < 0) exitWith { };

_magazineForInsertingAmmo = [_control, _index] call SCH_magazinesReloading_fnc_getMagazinesInfo;

if (_magazineForInsertingAmmo isEqualTo []) exitWith { };

_sameContainer = (_magazineForRemovingAmmo select 3) == (_magazineForInsertingAmmo select 3);

_magazineRemoved = if (!_sameContainer) then {
	(_magazineForInsertingAmmo select 3) canAdd [_magazineForRemovingAmmo select 0, 1, true]
} else { false };

_magazineForRemovingAmmo pushBack _magazineRemoved;

[_magazineForInsertingAmmo, _magazineForRemovingAmmo, _display] spawn SCH_magazinesReloading_fnc_reloadMagazines;
