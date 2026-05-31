#include "\a3\ui_f\hpp\defineResincl.inc"

params [
	["_display", displayNull, [displayNull]],
	["_className", "", [""]]
];

if ((isNull _display) or { _className != "RscDisplayInventory" }) exitWith { };

{
	(_display displayCtrl _x) ctrlAddEventHandler [
		"ButtonClick",
		{ call SCH_magazinesReloading_fnc_handleTabSwitch; }
	];
} forEach [IDC_FG_CHOSEN_TAB, IDC_FG_GROUND_TAB];

{
	(_display displayCtrl _x) ctrlAddEventHandler [
		"LBDblClick",
		{ call SCH_magazinesReloading_fnc_handleListBoxDoubleClick; }
	];
} forEach [IDC_FG_CHOSEN_CONTAINER, IDC_FG_GROUND_ITEMS];

{
	(_display displayCtrl _x) ctrlAddEventHandler [
		"LBDrag",
		{ call SCH_magazinesReloading_fnc_handleListBoxItemDrag; }
	];
} forEach [
	IDC_FG_UNIFORM_CONTAINER,
	IDC_FG_VEST_CONTAINER,
	IDC_FG_BACKPACK_CONTAINER,
	IDC_FG_CHOSEN_CONTAINER,
	IDC_FG_GROUND_ITEMS
];

{
	(_display displayCtrl _x) ctrlAddEventHandler [
		"LBDrop",
		{ call SCH_magazinesReloading_fnc_handleListBoxItemDrop; }
	];
} forEach [IDC_FG_CONTAINER_MARKER, IDC_FG_GROUND_MARKER];
