#include "\a3\ui_f\hpp\defineResincl.inc"

#include "..\definitions.hpp"

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
} forEach TAB_IDCS;

{
	(_display displayCtrl _x) ctrlAddEventHandler [
		"LBDblClick",
		{ call SCH_magazinesReloading_fnc_handleListBoxDoubleClick; }
	];
} forEach CRATE_CONTAINER_IDCS;

{
	(_display displayCtrl _x) ctrlAddEventHandler [
		"LBDrop",
		{ call SCH_magazinesReloading_fnc_handleListBoxItemDrop; }
	];
} forEach ([IDC_FG_CONTAINER_MARKER, IDC_FG_GROUND_MARKER] + UNIT_CONTAINER_IDCS);
