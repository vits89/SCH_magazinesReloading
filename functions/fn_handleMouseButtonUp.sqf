#include "..\definitions.hpp"

params [
	["_display", displayNull, [displayNull]],
	["_button", -1, [0]],
	["_x", 0, [0]],
	["_y", 0, [0]]
];

if ((isNull _display) or { _button < 0 }) exitWith { };
if (!((_button + 65536) in (actionKeys "DefaultAction"))) exitWith { };
if (!(_display getVariable ["SCH_magazinesReloading_var_isDragging", false])) exitWith { };

_control = _display ctrlAt [_x, _y];

if (!(isNull _control) and { (ctrlIDC _control) == DUMMY_LIST_BOX_IDC }) exitWith { };

_display setVariable ["SCH_magazinesReloading_var_isDragging", false];
_display setVariable ["SCH_magazinesReloading_var_magazineInfo", nil];

_control = _display displayCtrl DUMMY_LIST_BOX_IDC;

if (!(isNull _control)) then {
	ctrlDelete _control;
};
