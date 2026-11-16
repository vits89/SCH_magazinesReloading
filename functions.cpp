#include "definitions.hpp"

class SCH_magazinesReloading
{
	class All
	{
		file = __EVAL(PATH + "functions");

		class addEventHandlers
		{
			postInit = 1;
		};
		class addGroupEventHandlers { };
		class addInventoryOpenedEventHandler { };
		class checkIfMagazineCanBeReloaded { };
		class createListBoxesItemMarkers { };
		class createProgressBar { };
		class getContainer { };
		class getListBoxItemIndex { };
		class getMagazinesInfo { };
		class getVisibleListBoxItemPositions { };
		class lockInventory { };
		class reloadMagazines { };
		class removeGroupEventHandlers { };
		class removeInventoryOpenedEventHandler { };
		class removeListBoxesItemMarkers { };

		class handleInventoryDisplayRegistered { };
		class handleInventoryOpened { };
		class handleListBoxDoubleClick { };
		class handleListBoxItemDrag { };
		class handleListBoxItemDrop { };
		class handleMouseButtonUp { };
		class handleTabSwitch { };
	};
};
