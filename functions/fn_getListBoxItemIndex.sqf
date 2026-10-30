#include "\a3\ui_f\hpp\defineResincl.inc"

private ["_index", "_itemsCount"];

_index = -1;

params [
	["_control", controlNull, [controlNull]],
	["_coordinates", [], [[]], 2],
	["_itemHeight", getNumber (configFile >> "RscListBox" >> "rowHeight"), [0]]
];

if ((isNull _control) or { (ctrlType _control) != CT_LISTBOX } or {
	_itemsCount = lbSize _control;

	_itemsCount == 0
}) exitWith { _index };
if (_itemHeight <= 0) exitWith { _index };

_itemHeight = _itemHeight + (_itemHeight mod pixelH);

privateAll;

(ctrlPosition _control) params ["", "_controlY", "", "_controlH"];
((ctrlScrollValues _control) apply { [0, _x] select (_x >= 0) }) params ["_scrollValueV"];

_coordinates params ["", "_y"];

_y = _y - _controlY;

_contentHeight = _itemsCount * _itemHeight;

_offset = if (_contentHeight > _controlH) then {
	_scrollValueV * (_contentHeight - (floor (_controlH / _itemHeight)) * _itemHeight)
} else { 0 };

if (_y <= (_contentHeight - _offset)) then {
	_index = floor ((_offset + _y) / _itemHeight);
};

_index
