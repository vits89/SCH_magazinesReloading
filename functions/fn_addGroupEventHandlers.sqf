if (!hasInterface or { isNull player }) exitWith { false };

params [
	["_group", grpNull, [grpNull]]
];

if (isNull _group) exitWith { false };

private _units = units _group;

if (((count _units) == 0) or { !(player in _units) }) exitWith { false };

private _index = _group getVariable ["SCH_magazinesReloading_var_leaderChangedEventHandlerIndex", -1];

if (_index < 0) then {
	_index = _group addEventHandler [
		"LeaderChanged",
		{
			params ["_group", "_leader"];

			if (_leader == player) then {
				[_group] call SCH_magazinesReloading_fnc_addGroupEventHandlers;
			} else {
				[_group, false] call SCH_magazinesReloading_fnc_removeGroupEventHandlers;
			};
		}
	];

	_group setVariable ["SCH_magazinesReloading_var_leaderChangedEventHandlerIndex", _index];
};

[player] call SCH_magazinesReloading_fnc_addInventoryOpenedEventHandler;

if ((leader _group) != player) exitWith { true };

_index = _group getVariable ["SCH_magazinesReloading_var_unitJoinedEventHandlerIndex", -1];

if (_index < 0) then {
	_index = _group addEventHandler [
		"UnitJoined",
		{
			params ["", "_unit"];

			[_unit] call SCH_magazinesReloading_fnc_addInventoryOpenedEventHandler;
		}
	];

	_group setVariable ["SCH_magazinesReloading_var_unitJoinedEventHandlerIndex", _index];
};

_index = _group getVariable ["SCH_magazinesReloading_var_unitLeftEventHandlerIndex", -1];

if (_index < 0) then {
	_index = _group addEventHandler [
		"UnitLeft",
		{
			params ["_group", "_unit"];

			if (_unit == player) then {
				[_group] call SCH_magazinesReloading_fnc_removeGroupEventHandlers;

				spawn {
					[group player] call SCH_magazinesReloading_fnc_addGroupEventHandlers;
				};
			} else {
				[_unit] call SCH_magazinesReloading_fnc_removeInventoryOpenedEventHandler;
			};
		}
	];

	_group setVariable ["SCH_magazinesReloading_var_unitLeftEventHandlerIndex", _index];
};

{
	[_x] call SCH_magazinesReloading_fnc_addInventoryOpenedEventHandler;
} forEach (_units - [player]);

true
