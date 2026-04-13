#define IS_MOD 1

class CfgPatches
{
	name = "$STR_SCH_magazinesReloading_about_name";
	author = "Schatten";
	url = "https://github.com/vits89";
	requiredVersion = 2.18;
	requiredAddons[] =
	{
		"A3_Language_F",
		"A3_Ui_F"
	};
	units[] = { };
	weapons[] = { };
};

class CfgFunctions
{
	#include "functions.cpp"
};

class CfgHints
{
	#include "hints.cpp"
};
