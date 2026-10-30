#include "\a3\ui_f\hpp\defineResincl.inc"

#include "..\definitions.hpp"

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
} forEach TAB_IDCS;

{
	_control = _display displayCtrl _x;

	_control ctrlAddEventHandler ["LBDblClick", { call SCH_magazinesReloading_fnc_handleListBoxDoubleClick; }];
	_control ctrlAddEventHandler ["LBDrag", { call SCH_magazinesReloading_fnc_handleListBoxItemDrag; }];
} forEach CRATE_CONTAINER_IDCS;

{
	_control = _display displayCtrl _x;

	_control ctrlAddEventHandler ["LBDrag", { call SCH_magazinesReloading_fnc_handleListBoxItemDrag; }];
	_control ctrlAddEventHandler ["LBDrop", { call SCH_magazinesReloading_fnc_handleListBoxItemDrop; }];
} forEach UNIT_CONTAINER_IDCS;

{
	(_display displayCtrl _x) ctrlAddEventHandler [
		"LBDrop",
		{ call SCH_magazinesReloading_fnc_handleListBoxItemDrop; }
	];
} forEach MARKER_IDCS;
