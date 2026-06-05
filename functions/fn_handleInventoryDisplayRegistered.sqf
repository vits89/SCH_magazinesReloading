#include "\a3\ui_f\hpp\defineResincl.inc"

params [
	["_display", displayNull, [displayNull]],
	["_className", "", [""]]
];

if ((isNull _display) or { _className != "RscDisplayInventory" }) exitWith { };

(_display displayCtrl IDC_FG_CONTAINER_MARKER) ctrlAddEventHandler [
	"LBDrop",
	{ call SCH_magazinesReloading_fnc_handleListBoxItemDrop; }
];
