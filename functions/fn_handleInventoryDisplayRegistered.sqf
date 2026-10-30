#include "\a3\ui_f\hpp\defineResincl.inc"

params [
	["_display", displayNull, [displayNull]],
	["_className", "", [""]]
];

if ((isNull _display) or { _className != "RscDisplayInventory" }) exitWith { };

_display displayAddEventHandler ["MouseButtonUp", { call SCH_magazinesReloading_fnc_handleMouseButtonUp; }];

{
	(_display displayCtrl _x) ctrlAddEventHandler [
		"ButtonClick",
		{ call SCH_magazinesReloading_fnc_handleTabSwitch; }
	];
} forEach [IDC_FG_CHOSEN_TAB, IDC_FG_GROUND_TAB];

{
	_control = _display displayCtrl _x;

	_control ctrlAddEventHandler ["LBDblClick", { call SCH_magazinesReloading_fnc_handleListBoxDoubleClick; }];
	_control ctrlAddEventHandler ["LBDrag", { call SCH_magazinesReloading_fnc_handleListBoxItemDrag; }];
} forEach [IDC_FG_CHOSEN_CONTAINER, IDC_FG_GROUND_ITEMS];

{
	_control = _display displayCtrl _x;

	_control ctrlAddEventHandler ["LBDrag", { call SCH_magazinesReloading_fnc_handleListBoxItemDrag; }];
	_control ctrlAddEventHandler ["LBDrop", { call SCH_magazinesReloading_fnc_handleListBoxItemDrop; }];
} forEach [IDC_FG_UNIFORM_CONTAINER, IDC_FG_VEST_CONTAINER, IDC_FG_BACKPACK_CONTAINER];

{
	(_display displayCtrl _x) ctrlAddEventHandler [
		"LBDrop",
		{ call SCH_magazinesReloading_fnc_handleListBoxItemDrop; }
	];
} forEach [IDC_FG_CONTAINER_MARKER, IDC_FG_GROUND_MARKER];
