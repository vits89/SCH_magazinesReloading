#include "\a3\ui_f\hpp\defineResincl.inc"

if (!hasInterface) exitWith { false };

params [
	"",
	["_primaryContainer", objNull, [objNull]],
	["_secondaryContainer", objNull, [objNull]]
];

if (isNull _primaryContainer) exitWith { false };

[_primaryContainer, _secondaryContainer] spawn {
	params ["_primaryContainer"];

	_display = displayNull;

	_time = time + 3;

	waitUntil {
		_display = findDisplay IDD_FUTURAGEAR;

		!(isNull _display) or { time >= _time }
	};

	if (isNull _display) exitWith { };

	_tabsCount = [2, 1] select (([0, 11] findIf { _primaryContainer getEntityInfo _x }) >= 0);
	_activeTab = [IDC_FG_GROUND_TAB, IDC_FG_CHOSEN_TAB] select (_tabsCount == 2);

	_display setVariable ["SCH_magazinesReloading_var_tabsCount", _tabsCount];
	_display setVariable ["SCH_magazinesReloading_var_activeTab", _activeTab];

	_display setVariable ["SCH_magazinesReloading_var_containers", _this];

	[["Weapons_basic", "SCH_magazinesReloading"], nil, nil, nil, nil, nil, nil, true] call BIS_fnc_advHint;
};

false
