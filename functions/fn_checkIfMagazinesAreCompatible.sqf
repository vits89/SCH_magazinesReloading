params [
	["_magazine1", "", [""]],
	["_magazine2", "", [""]]
];

if ((_magazine1 == "") or { _magazine2 == "" }) exitWith { false };

privateAll;

_magazine1Config = configFile >> "CfgMagazines" >> _magazine1;
_magazine2Config = configFile >> "CfgMagazines" >> _magazine2;

if (!(isClass _magazine1Config) or { !(isClass _magazine2Config) }) exitWith { false };

(getText (_magazine1Config >> "ammo")) == (getText (_magazine2Config >> "ammo"))
