params [
	["_group", grpNull, [grpNull]],
	["_removeAll", true, [true]]
];

if (isNull _group) exitWith { false };

privateAll;

_events = ["UnitJoined", "UnitLeft"];

_units = (units _group) select { !(_x in switchableUnits) };

if (_removeAll) then {
	_events insert [0, ["LeaderChanged"]];
} else {
	_units = _units - [player];
};

{
	_varName = format ["SCH_magazinesReloading_var_%1EventHandlerIndex", _x];

	_index = _group getVariable [_varName, -1];

	if (_index < 0) then {
		continue;
	};

	_group removeEventHandler [_x, _index];

	_group setVariable [_varName, nil];
} forEach _events;

{
	[_x] call SCH_magazinesReloading_fnc_removeInventoryOpenedEventHandler;
} forEach _units;

true
