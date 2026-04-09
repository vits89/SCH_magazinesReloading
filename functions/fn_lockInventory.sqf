#include "\a3\ui_f\hpp\defineResincl.inc"

#include "..\definitions.hpp"

params [
	["_lock", true, [true]]
];

private _display = findDisplay IDD_FUTURAGEAR;

if (isNull _display) exitWith { false };

privateAll;

if (_lock) then {
	{
		_existingControlId = _x select 0;
		_lockControlId = _x select 1;

		_position = ctrlPosition (_display displayCtrl _existingControlId);

		_control = _display ctrlCreate ["RscText", _lockControlId];

		_control ctrlSetBackgroundColor [0, 0, 0, 0.25];
		_control ctrlSetPosition _position;

		_control ctrlCommit 0;
		_control ctrlEnable true;
	} forEach [[1001, CONTAINER_ITEMS_LOCK_IDC], [1002, PLAYER_INVENTORY_LOCK_IDC]];
} else {
	{
		ctrlDelete (_display displayCtrl _x);
	} forEach [CONTAINER_ITEMS_LOCK_IDC, PLAYER_INVENTORY_LOCK_IDC];
};

true
