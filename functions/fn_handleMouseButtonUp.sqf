#define IDCS [\
	IDC_FG_CONTAINER_MARKER,\
	IDC_FG_GROUND_MARKER,\
	\
	IDC_FG_UNIFORM_CONTAINER,\
	IDC_FG_VEST_CONTAINER,\
	IDC_FG_BACKPACK_CONTAINER\
]

params [
	["_display", displayNull, [displayNull]],
	["_button", -1, [0]],
	["_x", 0, [0]],
	["_y", 0, [0]]
];

if ((isNull _display) or { _button < 0 }) exitWith { };

if (!((_button + 65536) in (actionKeys "DefaultAction"))
	or { !(_display getVariable ["SCH_magazinesReloading_var_isDragging", false]) }) exitWith { };

_control = _display ctrlAt [_x, _y];

if (!(isNull _control) and { (ctrlIDC _control) in IDCS }) exitWith { };

[_display] call SCH_magazinesReloading_fnc_removeListBoxesItemMarkers;

_display setVariable ["SCH_magazinesReloading_var_isDragging", false];
_display setVariable ["SCH_magazinesReloading_var_magazineInfo", nil];
