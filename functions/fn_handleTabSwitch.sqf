#include "\a3\ui_f\hpp\defineResincl.inc"

params [
	["_control", controlNull, [controlNull]]
];

if (isNull _control) exitWith { };

(ctrlParent _control) setVariable ["SCH_magazinesReloading_var_activeTab", ctrlIDC _control];
