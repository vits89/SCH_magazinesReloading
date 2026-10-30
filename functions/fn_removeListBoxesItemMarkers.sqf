#include "\a3\ui_f\hpp\defineResincl.inc"

params [
	["_control", displayNull, [displayNull, controlNull]]
];

if (isNull _control) exitWith { false };

private _isDisplay = _control isEqualType displayNull;

if (_isDisplay and { (ctrlIDD _control) != IDD_FUTURAGEAR }) exitWith { false };

private _removeItemMarkers = {
	params ["_control"];

	private _controls = _control getVariable ["SCH_magazinesReloading_var_itemMarkerControls", []];

	{
		ctrlDelete _x;
	} forEach _controls;

	_control setVariable ["SCH_magazinesReloading_var_itemMarkerControls", nil];
};

if (_isDisplay) then {
	private _handle =
		_control getVariable ["SCH_magazinesReloading_var_listBoxesItemMarkersUpdaterHandle", scriptNull];

	if (!(scriptDone _handle)) then {
		terminate _handle;
	};

	{
		[_control displayCtrl _x] call _removeItemMarkers;
	} forEach [
		IDC_FG_UNIFORM_CONTAINER,
		IDC_FG_VEST_CONTAINER,
		IDC_FG_BACKPACK_CONTAINER,

		IDC_FG_CHOSEN_CONTAINER,
		IDC_FG_GROUND_ITEMS
	];

	_control setVariable ["SCH_magazinesReloading_var_listBoxesItemMarkersUpdaterHandle", nil];
} else {
	[_control] call _removeItemMarkers;
};

true
