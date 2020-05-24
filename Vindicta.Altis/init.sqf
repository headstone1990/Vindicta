#define OOP_INFO
#define OOP_DEBUG
#include "common.h"

CHVD_allowNoGrass = true;
CHBN_adjustBrightness = 1;
CHBN_adjustColor = [0.5,0.7,1];

[] execVM "CHBN.sqf";

// Most normal init code is handled in GameMode init functions.

// Code which adds all objects to be edited by zeus
if (isServer) then {  
    [] spawn { 
        scriptName "Add Curator Objects";
        sleep 5;
        while {true} do {  
            {  
                _x addCuratorEditableObjects [allUnits, true];
                _x addCuratorEditableObjects [vehicles, true];
                sleep 10;
            } forEach allCurators;
        };
    };
};

CALLM0(gGameManager, "init");
