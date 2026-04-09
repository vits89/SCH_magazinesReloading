#include "\a3\ui_f\hpp\defineResincl.inc"

#include "..\definitions.hpp"

private _controls = [];

params [
	["_display", displayNull, [displayNull]]
];

if ((isNull _display) or { (ctrlIDD _display) != IDD_FUTURAGEAR }) exitWith { _controls };

privateAll;

_position = ctrlPosition (_display displayCtrl 1020);

_position set [2, (_position select 2) - ((ctrlPosition (_display displayCtrl IDC_CANCEL)) select 2)];

_control = _display ctrlCreate ["RscProgress", PROGRESS_BAR_IDC];

_control ctrlSetPosition _position;
_control ctrlSetTextColor [1, 1, 1, 0.5];

_control progressSetPosition 0;

_control ctrlCommit 0;

_controls pushBack _control;

_control = _display ctrlCreate ["RscStructuredText", PROGRESS_VALUE_IDC];

_control ctrlSetPosition _position;

_control ctrlCommit 0;

_controls pushBack _control;

_controls
