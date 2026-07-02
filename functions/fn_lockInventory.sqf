#include "\a3\ui_f\hpp\defineResincl.inc"

params [
	["_lock", true, [true]],
	["_display", displayNull, [displayNull]]
];

if (isNull _display) then {
	_display = findDisplay IDD_FUTURAGEAR;
};

private _result = false;

if (isNull _display) exitWith { _result };

privateAll;

if (_lock) then {
	_controls = [1001, 1002] select { (ctrlVisible _x) and {
		_position = ctrlPosition (_display displayCtrl _x);

		((_position select [2]) findIf { _x == 0 }) < 0
	} };

	if ((count _controls) == 0) then {
		_controls = [
			IDC_FG_UNIFORM_CONTAINER,
			IDC_FG_VEST_CONTAINER,
			IDC_FG_BACKPACK_CONTAINER,
			IDC_FG_CHOSEN_CONTAINER,

			IDC_FG_GROUND_ITEMS
		];
	};

	_controls = _controls apply {
		_position = ctrlPosition (_display displayCtrl _x);

		_control = _display ctrlCreate ["RscText", -1];

		_control ctrlSetBackgroundColor [0, 0, 0, 0.25];
		_control ctrlSetPosition _position;

		_control ctrlCommit 0;
		_control ctrlEnable true;

		_control
	};

	_display setVariable ["SCH_magazinesReloading_var_lockingControls", _controls];

	_result = true;
} else {
	_controls = _display getVariable ["SCH_magazinesReloading_var_lockingControls", []];

	if ((count _controls) == 0) exitWith { };

	{
		ctrlDelete _x;
	} forEach _controls;

	_display setVariable ["SCH_magazinesReloading_var_lockingControls", nil];

	_result = true;
};

_result
