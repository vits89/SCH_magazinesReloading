#include "\a3\ui_f\hpp\defineResincl.inc"

if (!hasInterface or { isNull player }) exitWith { };

player addEventHandler ["InventoryOpened", { call SCH_magazinesReloading_fnc_handleInventoryOpened; }];

[
	missionNamespace,
	"OnDisplayRegistered",
	{
		params ["_display", "_className"];

		if (_className != "RscDisplayInventory") exitWith { };

		_display displayAddEventHandler ["MouseButtonUp", { call SCH_magazinesReloading_fnc_handleMouseButtonUp; }];

		{
			_control = _display displayCtrl _x;

			_control ctrlAddEventHandler ["LBDrag", { call SCH_magazinesReloading_fnc_handleListBoxItemDrag; }];
			// _control ctrlAddEventHandler ["LBDrop", { call SCH_magazinesReloading_fnc_handleListBoxItemDrop; }]; // Currently doesn't work
		} forEach [IDC_FG_UNIFORM_CONTAINER, IDC_FG_VEST_CONTAINER, IDC_FG_BACKPACK_CONTAINER];
	}
] call BIS_fnc_addScriptedEventHandler;
