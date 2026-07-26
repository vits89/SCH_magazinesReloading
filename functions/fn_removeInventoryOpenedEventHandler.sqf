params [
	["_unit", objNull, [objNull]]
];

if (isNull _unit) exitWith { false };

private _index = _unit getVariable ["SCH_magazinesReloading_var_inventoryOpenedEventHandlerIndex", -1];

if (_index < 0) exitWith { true };

_unit removeEventHandler ["InventoryOpened", _index];

_unit setVariable ["SCH_magazinesReloading_var_inventoryOpenedEventHandlerIndex", nil];

true
