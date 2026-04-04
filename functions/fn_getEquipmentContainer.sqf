#include "\a3\ui_f\hpp\defineResincl.inc"

if (isNull player) exitWith { objNull };

params [
	["_control", controlNull, [controlNull]]
];

if (isNull _control) exitWith { objNull };

switch (ctrlIDC _control) do {
	case IDC_FG_UNIFORM_CONTAINER: { uniformContainer player };
	case IDC_FG_VEST_CONTAINER: { vestContainer player };
	case IDC_FG_BACKPACK_CONTAINER: { backpackContainer player };
	default { objNull };
}
