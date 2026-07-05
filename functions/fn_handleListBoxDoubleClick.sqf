#include "\a3\ui_f\hpp\defineResincl.inc"

params [
	["_control", controlNull, [controlNull]],
	["_index", -1, [0]]
];

if ((isNull _control) or { _index < 0 }) exitWith { };

_className = _control lbData _index;

if (_className == "") exitWith { };

_display = ctrlParent _control;

_tabsCount = _display getVariable ["SCH_magazinesReloading_var_tabsCount", 1];
_containers = _display getVariable ["SCH_magazinesReloading_var_containers", []];

if ((_tabsCount == 2) or { (count _containers) < 2 }) exitWith { };

_container = objNull;
_isContainer = false;

_config = configFile >> "CfgWeapons" >> _className;
_configExists = isClass _config;

_activeTab = if ((_configExists and { (count ("true" configClasses (_config >> "WeaponSlotsInfo"))) > 0 }) or {
	_isContainer = (_configExists and { (getText (_config >> "ItemInfo" >> "containerClass")) != "" })
		or { _className isKindOf "Bag_Base" };

	_isContainer
}) then {
	if (_isContainer and { (_containers select 0) getEntityInfo 0 }) then {
		_unit = _containers select 0;

		if (_index >= ({ _x != "" } count [uniform _unit, vest _unit, backpack _unit])) exitWith { };

		_container = switch (_className) do {
			case (uniform _unit): { uniformContainer _unit };
			case (vest _unit): { vestContainer _unit };
			case (backpack _unit): { backpackContainer _unit };
			default { objNull };
		};
	};

	IDC_FG_CHOSEN_TAB
} else { IDC_FG_GROUND_TAB };

_display setVariable ["SCH_magazinesReloading_var_activeTab", _activeTab];

_containers set [2, _container];
