#include "\a3\ui_f\hpp\defineResincl.inc"

if (!hasInterface or { isNull player }) exitWith { };

player addEventHandler ["InventoryOpened", { call SCH_magazinesReloading_fnc_handleInventoryOpened; }];

[
	missionNamespace,
	"OnDisplayRegistered",
	{
		params ["_display", "_className"];

		if (_className != "RscDisplayInventory") exitWith { };

		{
			(_display displayCtrl _x) ctrlAddEventHandler [
				"LBDrag",
				{ call SCH_magazinesReloading_fnc_handleListBoxItemDrag; }
			];
		} forEach [IDC_FG_UNIFORM_CONTAINER, IDC_FG_VEST_CONTAINER, IDC_FG_BACKPACK_CONTAINER];

		(_display displayCtrl IDC_FG_CONTAINER_MARKER) ctrlAddEventHandler [
			"LBDrop",
			{ call SCH_magazinesReloading_fnc_handleListBoxItemDrop; }
		];
	}
] call BIS_fnc_addScriptedEventHandler;
