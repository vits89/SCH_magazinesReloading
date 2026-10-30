#include "\a3\ui_f\hpp\defineResincl.inc"

private ["_itemsCount", "_listBoxConfig", "_positions"];

_positions = [];

_listBoxConfig = configFile >> "RscListBox";

params [
	["_control", controlNull, [controlNull]],
	["_itemHeight", getNumber (_listBoxConfig >> "rowHeight"), [0]],
	["_scrollBarWidth", getNumber (_listBoxConfig >> "ListScrollBar" >> "width"), [0]]
];

if ((isNull _control) or { (ctrlType _control) != CT_LISTBOX } or {
	_itemsCount = lbSize _control;

	_itemsCount == 0
}) exitWith { _positions };
if (_itemHeight <= 0) exitWith { _positions };

_itemHeight = _itemHeight + (_itemHeight mod pixelH);

if (_scrollBarWidth < 0) then {
	_scrollBarWidth = 0;
};

privateAll;

_offsetV = 0;

(ctrlPosition _control) params ["", "", "_controlWidth", "_controlHeight"];
((ctrlScrollValues _control) apply { [0, _x] select (_x >= 0) }) params ["_scrollValueV"];

_contentHeight = _itemsCount * _itemHeight;
_itemWidth = _controlWidth;

if (_contentHeight > _controlHeight) then {
	_offsetV = _scrollValueV * (_contentHeight - (floor (_controlHeight / _itemHeight)) * _itemHeight);
	_itemWidth = _itemWidth - _scrollBarWidth;
};

_indexFirst = floor (_offsetV / _itemHeight);
_indexLast = (floor ((_offsetV + _controlHeight) / _itemHeight)) min (_itemsCount - 1);

for "_i" from _indexFirst to _indexLast do {
	_y = _i * _itemHeight - _offsetV;

	_y0 = _y max 0;
	_y1 = (_y + _itemHeight) min _controlHeight;

	_positions pushBack [_i, [0, _y0, _itemWidth, _y1 - _y0]];
};

_positions
