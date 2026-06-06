#include "\a3\ui_f\hpp\defineResincl.inc"

params [
	["_control", controlNull, [controlNull]]
];

if (isNull _control) exitWith { };

_idc = ctrlIDC _control;
_display = ctrlParent _control;

_containers = _display getVariable ["SCH_magazinesReloading_var_containers", []];

if ((_containers param [0, objNull]) isKindOf "Bag_Base") then {
	_idc = [IDC_FG_GROUND_TAB, IDC_FG_CHOSEN_TAB] select (_idc == IDC_FG_GROUND_TAB);
};

_display setVariable ["SCH_magazinesReloading_var_activeTab", _idc];
