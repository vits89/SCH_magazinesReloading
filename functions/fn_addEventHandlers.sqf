if (!hasInterface or { isNull player }) exitWith { false };

addMissionEventHandler [
	"TeamSwitch",
	{
		params ["_prevUnit", "_newUnit"];

		_prevUnitGroup = group _prevUnit;
		_newUnitGroup = group _newUnit;

		if (_prevUnitGroup == _newUnitGroup) exitWith { };

		[_prevUnitGroup] call SCH_magazinesReloading_fnc_removeGroupEventHandlers;
		[_newUnitGroup] call SCH_magazinesReloading_fnc_addGroupEventHandlers;
	}
];

[
	missionNamespace,
	"OnDisplayRegistered",
	{
		with missionNamespace do {
			call SCH_magazinesReloading_fnc_handleInventoryDisplayRegistered;
		};
	}
] call BIS_fnc_addScriptedEventHandler;

[group player] call SCH_magazinesReloading_fnc_addGroupEventHandlers;

true
