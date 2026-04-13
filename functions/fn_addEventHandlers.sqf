if (!hasInterface or { isNull player }) exitWith { false };

player addEventHandler ["InventoryOpened", { call SCH_magazinesReloading_fnc_handleInventoryOpened; }];

[
	missionNamespace,
	"OnDisplayRegistered",
	{
		with missionNamespace do {
			call SCH_magazinesReloading_fnc_handleInventoryDisplayRegistered;
		};
	}
] call BIS_fnc_addScriptedEventHandler;

true
