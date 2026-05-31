#include "\a3\ui_f\hpp\defineResincl.inc"

if (isNull player) exitWith { objNull };

params [
	["_control", controlNull, [controlNull]]
];

if (isNull _control) exitWith { objNull };

privateAll;

_idc = ctrlIDC _control;

switch (_idc) do {
	case IDC_FG_UNIFORM_CONTAINER: { uniformContainer player };
	case IDC_FG_VEST_CONTAINER: { vestContainer player };
	case IDC_FG_BACKPACK_CONTAINER: { backpackContainer player };
	case IDC_FG_CHOSEN_CONTAINER;
	case IDC_FG_GROUND_ITEMS: {
		_display = ctrlParent _control;

		if (!((lbCurSel (_display displayCtrl IDC_FG_GROUND_FILTER)) in [1, 3])) exitWith { objNull };

		_activeTab = _display getVariable ["SCH_magazinesReloading_var_activeTab", -1];
		_containers = _display getVariable ["SCH_magazinesReloading_var_containers", []];

		if ((count _containers) == 0) exitWith { objNull };

		switch (_activeTab) do {
			case IDC_FG_CHOSEN_TAB: {
				_tabsCount = _display getVariable ["SCH_magazinesReloading_var_tabsCount", 0];

				if (_tabsCount == 2) then { _containers select (_idc == IDC_FG_GROUND_ITEMS) } else { objNull }
			};
			case IDC_FG_GROUND_TAB: { _containers select 1 };
			default { objNull };
		}
	};
	default { objNull };
}
