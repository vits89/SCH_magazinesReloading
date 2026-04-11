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
		class checkIfMagazinesAreCompatible { };
		class createProgressBar { };
		class getEquipmentContainer { };
		class getListBoxItemIndex { };
		class getMagazineInfo { };
		class lockInventory { };
		class reloadMagazines { };

		class handleInventoryDisplayRegistered { };
		class handleInventoryOpened { };
		class handleListBoxItemDrag { };
		class handleListBoxItemDrop { };
	};
};
