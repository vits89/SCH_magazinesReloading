private _index = -1;

if (!hasInterface or { isNull player }) exitWith { _index };

params [
	["_unit", objNull, [objNull]]
];

if ((isNull _unit) or { !(_unit getEntityInfo 0) }) exitWith { _index };

private _isPlayer = isPlayer [_unit];

if ((!_isPlayer and { !(local _unit) }) or { _isPlayer and { _unit != player } }) exitWith { _index };

_index = _unit getVariable ["SCH_magazinesReloading_var_inventoryOpenedEventHandlerIndex", -1];

if (_index >= 0) exitWith { _index };

_index = _unit addEventHandler ["InventoryOpened", { call SCH_magazinesReloading_fnc_handleInventoryOpened; }];

_unit setVariable ["SCH_magazinesReloading_var_inventoryOpenedEventHandlerIndex", _index];

_index
