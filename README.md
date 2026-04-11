# SCH_magazinesReloading

This is a scripted solution for reloading magazines for [Arma 3](https://arma3.com). It extends the standard inventory interface and requires nothing additional. To reload, simply drag a magazine from which rounds will be removed onto a magazine into which rounds will be inserted. Magazines must be in the same player's equipment.

## Demo mission

Demo mission can be downloaded from [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3701411741).

## Installation

- Copy the solution to your mission, for example, to *client\addons\SCH_magazinesReloading* folder.
- Change the path to the solution in the `PATH` definition in *definitions.hpp* file, for example, to `"client\addons\SCH_magazinesReloading\"`.
- Include the solution files in `CfgFunctions` and `CfgHints` classes in *description.ext* file:
```cpp
class CfgFunctions
{
	#include "client\addons\SCH_magazinesReloading\functions.cpp"
};

class CfgHints
{
	#include "client\addons\SCH_magazinesReloading\hints.cpp"
};
```
- Move localization resources from the solution's *stringtable.xml* file to your mission's one.

## Support

If you want to support me, you can donate:
- [PayPal](https://paypal.me/vitalisarokin)
- [WebMoney](https://pay.web.money/157076088165)
- [YooMoney](https://yoomoney.ru/to/410016769347513)
