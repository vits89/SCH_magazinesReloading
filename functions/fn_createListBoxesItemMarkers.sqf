#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\a3\ui_f\hpp\defineResincl.inc"

#include "..\definitions.hpp"

params [
	["_display", displayNull, [displayNull]]
];

if ((isNull _display) or { (ctrlIDD _display) != IDD_FUTURAGEAR }) exitWith { false };

privateAll;

_createItemMarkers = {
	params ["_listBox", "_itemHeight", "_scrollBarWidth", "_magazineForRemovingAmmo"];

	private _visibleItemPositions =
		[_listBox, _itemHeight, _scrollBarWidth] call SCH_magazinesReloading_fnc_getVisibleListBoxItemPositions;

	if ((count _visibleItemPositions) == 0) exitWith {
		[_listBox] call SCH_magazinesReloading_fnc_removeListBoxesItemMarkers;
	};

	([_listBox] call SCH_magazinesReloading_fnc_getMagazinesInfo) params [["_magazinesInfo", []]];

	if (_magazinesInfo isEqualTo []) exitWith {
		[_listBox] call SCH_magazinesReloading_fnc_removeListBoxesItemMarkers;
	};

	_magazinesInfo = (_magazinesInfo apply { _x select 3 }) createHashMapFromArray _magazinesInfo;

	_visibleItemPositions = _visibleItemPositions select { [
		_magazinesInfo getOrDefault [_x select 0, []],
		_magazineForRemovingAmmo
	] call SCH_magazinesReloading_fnc_checkIfMagazineCanBeReloaded };

	private _visibleItemPositionsCount = count _visibleItemPositions;

	if (_visibleItemPositionsCount == 0) exitWith {
		[_listBox] call SCH_magazinesReloading_fnc_removeListBoxesItemMarkers;
	};

	privateAll;

	(ctrlPosition _listBox) params ["_listBoxX", "_listBoxY"];

	_ammoBarWidth = 0.2 * GUI_GRID_W;
	_x0 = _listBoxX + _ammoBarWidth;

	_controls = _listBox getVariable ["SCH_magazinesReloading_var_itemMarkerControls", []];
	_controlsCount = count _controls;

	if (_visibleItemPositionsCount >= _controlsCount) then {
		_display = ctrlParent _listBox;

		for "_n" from 1 to (_visibleItemPositionsCount - _controlsCount) do {
			_controls pushBack (_display ctrlCreate ["RscText", -1]);
		};
	} else {
		for "_i" from (_controlsCount - 1) to _visibleItemPositionsCount step -1 do {
			ctrlDelete (_controls deleteAt _i);
		};
	};

	{
		_control = _controls select _forEachIndex;

		_control ctrlSetPosition [
			_x0 + (_x select 0),
			_listBoxY + (_x select 1),
			(_x select 2) - _ammoBarWidth,
			_x select 3
		];

		_control ctrlCommit 0;

		_control ctrlSetBackgroundColor [0.35, 0.75, 0.3, 0.5];
	} forEach (_visibleItemPositions apply { _x select 1 });

	_listBox setVariable ["SCH_magazinesReloading_var_itemMarkerControls", _controls];
};

_handle = [_display, _createItemMarkers] spawn {
	params ["_display", "_createItemMarkers"];

	_scrollBarWidth = 0.75 * GUI_GRID_W;

	_unit = _display getVariable ["SCH_magazinesReloading_var_unit", objNull];
	_magazineInfo = _display getVariable ["SCH_magazinesReloading_var_magazineInfo", []];

	_controlsConfig = configFile >> "RscDisplayInventory" >> "Controls";

	_controlsInfo = (CONTAINER_IDCS select { ctrlVisible _x }) apply {
		_control = _display displayCtrl _x;

		[_control, getNumber (_controlsConfig >> (ctrlClassName _control) >> "rowHeight")]
	};

	while { !(isNull _unit) and { (lifeState _unit) in ["HEALTHY", "INJURED"] } and { !(isNull _display) }
		and { _display getVariable ["SCH_magazinesReloading_var_isDragging", false] }
		and { _magazineInfo isNotEqualTo [] } } do {
		{
			(_x + [_scrollBarWidth, _magazineInfo]) call _createItemMarkers;
		} forEach _controlsInfo;

		uiSleep 0.02;
	};

	[_display] call SCH_magazinesReloading_fnc_removeListBoxesItemMarkers;
};

_display setVariable ["SCH_magazinesReloading_var_listBoxesItemMarkersUpdaterHandle", _handle];

true
