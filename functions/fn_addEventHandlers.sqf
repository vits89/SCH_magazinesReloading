if (!hasInterface or { isNull player }) exitWith { false };

[group player] call SCH_magazinesReloading_fnc_addGroupEventHandlers;

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
