#include "\a3\ui_f\hpp\defineResincl.inc"

if (!hasInterface) exitWith { false };

params [
	["_unit", objNull, [objNull]],
	["_primaryContainer", objNull, [objNull]]
];

if ((isNull _unit) or { isNull _primaryContainer }) exitWith { false };

_this spawn {
	params ["_unit"];

	_display = displayNull;

	waitUntil [
		{
			_display = findDisplay IDD_FUTURAGEAR;

			!(isNull _display)
		},
		3
	];

	if (isNull _display) exitWith { };

	_idcs = [IDC_FG_GROUND_TAB, IDC_FG_CHOSEN_TAB];

	_isContainer = (_idcs findIf { !(ctrlVisible _x) }) < 0;

	_display setVariable ["SCH_magazinesReloading_var_isContainer", _isContainer];
	_display setVariable ["SCH_magazinesReloading_var_activeTab", _idcs select _isContainer];

	_display setVariable ["SCH_magazinesReloading_var_unit", _unit];
	_display setVariable ["SCH_magazinesReloading_var_containers", _this select [1]];

	[["Weapons_basic", "SCH_magazinesReloading"], nil, nil, nil, nil, nil, nil, true] call BIS_fnc_advHint;
};

false
