#include "\a3\ui_f\hpp\defineResincl.inc"

if (!hasInterface) exitWith { false };

params [
	["_unit", objNull, [objNull]]
];

if (isNull _unit) exitWith { false };

[] spawn {
	_display = displayNull;

	_time = time + 3;

	waitUntil {
		_display = findDisplay IDD_FUTURAGEAR;

		!(isNull _display) or { time >= _time }
	};

	if (!(isNull _display)) then {
		[["SCH_magazinesReloading", "Info"]] call BIS_fnc_advHint;
	};
};

_unit removeEventHandler [_thisEvent, _thisEventHandler];

false
