#include "..\definitions.hpp"

params [
	["_control", controlNull, [controlNull]],
	["_itemsInfo", [], [[]]]
];

if ((isNull _control) or { (count _itemsInfo) == 0 }) exitWith { };

(_itemsInfo select 0) params [
	"",
	["_index", -1, [0]],
	["_className", "", [""]]
];

if ((_index < 0) or { _className == "" }) exitWith { };
if (!(isClass (configFile >> "CfgMagazines" >> _className))) exitWith { };

_magazineInfo = [_control, _index] call SCH_magazinesReloading_fnc_getMagazineInfo;

if ((_magazineInfo isEqualTo []) or { (_magazineInfo param [2, 0]) == 0 }) exitWith { };

_display = ctrlParent _control;

_display setVariable ["SCH_magazinesReloading_var_isDragging", true];
_display setVariable ["SCH_magazinesReloading_var_magazineInfo", _magazineInfo];

// Workaround
_position = ctrlPosition _control;

_control = _display displayCtrl DUMMY_LIST_BOX_IDC;

if (isNull _control) then {
	_control = _display ctrlCreate ["RscListBox", DUMMY_LIST_BOX_IDC];

	_control ctrlSetBackgroundColor [0, 0, 0, 0];

	_control ctrlAddEventHandler ["LBDrop", { call SCH_magazinesReloading_fnc_handleListBoxItemDrop; }];
};

_control ctrlSetPosition _position;

_control ctrlCommit 0;
