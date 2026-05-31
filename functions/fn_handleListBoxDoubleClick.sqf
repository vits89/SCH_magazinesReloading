#include "\a3\ui_f\hpp\defineResincl.inc"

params [
	["_control", controlNull, [controlNull]],
	["_index", -1, [0]]
];

if ((isNull _control) or { _index < 0 }) exitWith { };

_className = _control lbData _index;

if (_className == "") exitWith { };

_activeTab = if ((_className isKindOf "Bag_Base") or {
	_config = configFile >> "CfgWeapons" >> _className;

	(isClass _config) and {
		((count ("true" configClasses (_config >> "WeaponSlotsInfo"))) > 0)
			or { (getText (_config >> "ItemInfo" >> "containerClass")) != "" }
	}
}) then { IDC_FG_CHOSEN_TAB } else { IDC_FG_GROUND_TAB };

(ctrlParent _control) setVariable ["SCH_magazinesReloading_var_activeTab", _activeTab];
