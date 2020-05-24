// on initServer.sqf add: [] call vAiDriving_init;

vAiDriving_init = {
	if !(isServer) exitWith {}; // Run on Server Only
	
	if !(isNil "vAiDrinvingScriptRunning") exitWith {}; //Script already running
	if (isNil "vAiDrinvingScriptRunning") then {vAiDrinvingScriptRunning = 1;}; // Prevent the loop from running several times.
	
	vAiDriving_useLinesIntersectWith = true; // Helps vehicles reduce speed when facing obstacles other than other vehicles and men.
	vAiDriving_show3DLine = true; // Set to true to draw a visual line for the LINES INTERSECT.
	vAiDriving_handleBargates = true; // Should the vehicles open BarGates automatically?
	vAiDriving_debug = true; // If true will show when Ai Drivers hit the brakes and/or their nearObjects.
	vAiDriving_handlePedestrians = true; // Set to true to optimize Ai Civilian units and give them waypoints to look "realistic".
	
	[{
		[] call vAiDriving_postInit;
	},[],5] call CBA_fnc_waitAndExecute; // Delay execution until all objects and vehicles are placed.
};

vAiDriving_postInit = {
	if !(isServer) exitWith {}; // Run on Server Only
	
	if (vAiDriving_handleBargates) then {
		[] spawn vAiDriving_handleBargatesFnc;
	};
	
	if (vAiDriving_handlePedestrians) then {
		[] spawn vAiDriving_handlePedestrianFnc;
	};
	
	private _aiDrivenVeh = [];
	_aiDrivenVeh = vehicles select {(alive driver _x && !(isPlayer driver _x) && (local driver _x) && (_x isKindOf "Car" || _x isKindOf "Motorcycle" || _x isKindOf "Tank"))}; //Select all vehicles being driven by Ai.
	if (_aiDrivenVeh isEqualTo []) exitWith {[vAiDriving_postInit,[],300] call CBA_fnc_waitAndExecute;}; //If no candidate found recheck 300 seconds later!
	
	{
		if (isNil {_x getVariable "vAiDrivingSet"}) then {
			_x setVariable ["vAiDrivingSet",0];
			_x setConvoySeparation 20;
			//_x forceFollowRoad true;
			_x setSpeedMode "LIMITED";
			//Add Event Handler
			_x addEventHandler ["GetIn", {_this spawn vAiDriving_loop;}];
			_x addEventHandler ["HandleDamage", {params ["","","","","_p","","",""]; if (_p isEqualTo "") exitWith {false};}];
			if (isNil {driver _x getVariable "vAiDrivingSet"}) then {
				driver _x setVariable ["vAiDrivingSet",0];
				driver _x addEventHandler ["GetOutMan", {_this spawn vAiDriving_restoreDriver;}];
				[driver _x] spawn vAiDriving_setDriver;
				//Start function if driver inside
				if !(isNull (driver _x)) then{null=[_x,"driver",(driver _x)] spawn vAiDriving_loop;};					
			};
		};
	} forEach _aiDrivenVeh;
	
	[vAiDriving_postInit,[],300] call CBA_fnc_waitAndExecute; // Check again Later if new veh or barGates were placed!
};

vAiDriving_loop = {

	if !(isServer) exitWith {}; // Run on Server Only
	
	if (diag_fps < 15) exitWith {[{[] spawn vAiDriving_loop;},[],60] call CBA_fnc_waitAndExecute;}; // Server FPS too low, save resources and restart the loop until FPS gets better

	params ["_car", "_role", "_driver"];
	
	if (!(_car isKindOf "Car" || _car isKindOf "Motorcycle" || _car isKindOf "Tank") || {!(_role isEqualTo "driver")} || {isPlayer _driver} || {!(local _driver)}) exitWith{};

	while {alive _driver && !(isNull (objectParent _driver))} do {
		// If FPS too low let the Drivers be stupid again to save performance.
		if (diag_fps > 15) then {
			private _fuel = fuel _car;
			if (_fuel isEqualTo 0) exitWith {private _crew = crew _car; {unassignVehicle _x} forEach _crew; _crew allowGetIn false;}; //Basically exit the while loop if out of fuel!
			_speed = speed _car;
			// Static Vehicles do not need brakes applied!
			if (_speed > 1) then {		
				_objectsIntersected = [];
				// Extra measure to reduce speed if a object is in the way, quite performance friendly!
				if (vAiDriving_useLinesIntersectWith) then {			
					private _carFrontPos = ATLToASL (_car modelToWorld [0, 2, -0.2]);
					private _distanceToCheck = 10;
					_distanceToCheck = ((_speed)*1.1);
					if (_distanceToCheck < 10) then {_distanceToCheck = 10;};
					private _carFrontDistanceToCheck = ATLToASL (_car modelToWorld [0, _distanceToCheck, 0.5]); //position far in front of vehicle
					_objectsIntersected = lineIntersectsWith [_carFrontPos, _carFrontDistanceToCheck, _car, _driver, true];
					if (vAiDriving_show3DLine) then {drawLine3D [ASLToATL _carFrontPos, ASLToATL _carFrontDistanceToCheck, [1,0,0,1]];};
				};
				// If vehicle already slowing down because of linesIntersect no point in searching for other Entities (Reduces resources usage!)
				if !(_objectsIntersected isEqualTo []) then {	
					_car setSpeedMode "LIMITED";
					_car forceSpeed 1;
					_car limitSpeed 5;
					_car enableSimulationGlobal false;
					_car setVelocityModelSpace [0, 0, 0];
					if (vAiDriving_debug) then { systemChat format ["Car hit the BRAKE due to: LINESINTERSECT",""]; };
					sleep 1; // Do not overwhelm the server.			
				} else {
					_nearestObjects = [];
					private _radius = 6;
					_radius = _speed * 0.3;
					if (_radius < 6) then {_radius = 6;};
					if (_radius > 20) then {_radius = 20;};
					if (vAiDriving_handleBargates) then {
						_nearestObjects = ((nearestObjects[_car getRelPos [5,0],["CAManBase","Car","Wall_F"],_radius]) select {alive _x && !(_car isEqualTo _x)});
					} else {
						_nearestObjects = ((nearestObjects[_car getRelPos [5,0],["CAManBase","Car"],_radius]) select {alive _x && !(_car isEqualTo _x)});
					};
					sleep 0.5;
					if !(_nearestObjects isEqualTo []) then {
					if (vAiDriving_debug) then { systemChat format ["NEARESTOBJ COUNT: %1",count _nearestObjects]; };
						_car setSpeedMode "LIMITED";
						_car forceSpeed 1;
						_car limitSpeed 5;
						_car enableSimulationGlobal false;
						_car setVelocityModelSpace [0, 0, 0];
						if (vAiDriving_debug) then { systemChat format ["Car hit the BRAKE due to: NEAROBJECT",""]; };
						if (random 5 > 4) then {driver _car forceWeaponFire [currentWeapon _car ,currentWeapon _car ];}; // Blow the horn for those pesky pedestrians!
						{
							switch (true) do {
								case (_x isKindOf "CAManBase" && {isNull (objectParent _x)}): {				// Pedestrian, try to save him!
									//if ((side _x isEqualTo "CIVILIAN" && (currentWeapon _x isEqualTo ""))) then {_x allowDamage false;};
									[_x, _car] spawn vAiPedestrian_runToNearestBuilding;
									if (vAiDriving_debug) then { systemChat format ["NEAROBJECTS: MEN",""]; };
								};
								case (_x isKindOf "Car" && !(isPlayer driver _x)): {											// Helps cars avoid other cars.
									if (speed _car < 5 && speed _x < 5) then {
										//_car setDir ((getposatl _car) getDir ((_x modelToWorld [-3, 0, 0])));			// This causes more troubles than it solves! Need a better way to unstuck vehicles.
										if (vAiDriving_debug) then { systemChat format ["NEAROBJECTS: CAR",""]; };
									};
								};
								case (vAiDriving_handleBargates && _x in vAiDriving_barGates): {_x animateSource ["Door_1_source", 1];};	// If it is a BarGate, open it!
							};
						sleep 0.3;
						} forEach _nearestObjects;
					} else {
						_car enableSimulationGlobal true;
						_car forceSpeed -1;
						_car limitSpeed 30;						// Now restore speed
						_car setSpeedMode "NORMAL";
						if (((getPos _car) getEnvSoundController "houses") >= 0.7) then {
							_car limitSpeed 20;					// In cities reduce speed limit a little bit.
						};		
					};
				};
			};	
		};
	sleep 1; // Do not overwhelm the server.	
	};
};

vAiDriving_handleBargatesFnc = {
	if (diag_fps < 15) exitWith {};
	private _bargatetypes = ["Land_BarGate_01_open_F", "Land_BarGate_F", "Land_RoadBarrier_01_F"];
	vAiDriving_barGates = (allMissionObjects "Wall_F") select {private _object = _x; !(_bargatetypes findIf {_object isKindOf _x} isEqualTo -1)};
	//Add Event Handler
	{
		_driver addEventHandler ["HandleDamage", {params ["","","","","_projectile","","",""]; if (_projectile isEqualTo "") then {_d=0; _d};}];
	sleep 1;	
	} forEach vAiDriving_barGates;
};

vAiDriving_setDriver = {
	params ["_driver"];
	if !(local _driver) exitWith {};
	if (isPlayer _driver) exitWith {};
	if !(isNil {_driver getVariable "vDriverSet"}) exitWith {};
	_driver setVariable ["vDriverSet", 0];
	_driver disableAi "ALL";
	{_driver enableAI _x} forEach ["MOVE","PATH","TEAMSWITCH"];
	[_driver] spawn {params ["_driver"]; sleep 5; _driver doMove (getPos _driver);};
	_driver setCombatMode "BLUE";
	_driver setBehaviour "CARELESS";
	_driver allowFleeing 0;
	_driver setSkill 0.0;
	(group _driver) enableDynamicSimulation true;
	(group _driver) deleteGroupWhenEmpty true;
	_driver setVariable ["BIS_noCoreConversations", true];
	_driver disableConversation true;
	_driver setSpeaker "NoVoice";
	_driver removeAllEventHandlers "HandleDamage";
	_driver addEventHandler ["HandleDamage", {params ["","","","","_projectile","","",""]; if (_projectile isEqualTo "") then {_d=0; _d};}];
};

vAiDriving_restoreDriver = {
	params ["_unit", "_role", "_vehicle", ""];
	if !(local _unit) exitWith {};
	if (isPlayer _unit) exitWith {};
	if (isNil {_unit getVariable "vDriverSet"}) exitWith {};
	_unit setVariable ["vDriverSet", nil];
	{_unit enableAI _x} forEach ["MOVE","PATH","ANIM","TEAMSWITCH"];
	_unit setCombatMode "YELLOW";
	_unit setBehaviour "SAFE";
	_unit allowFleeing 0;
	if (side group _unit isEqualTo CIVILIAN) then {
		[group _unit, getPos _unit, 100] call BIS_fnc_taskPatrol;
	} else {
		{_unit enableAi _x} forEach ["WEAPONAIM","FSM","AIMINGERROR","SUPPRESSION","AUTOCOMBAT","CHECKVISIBLE","TARGET","AUTOTARGET"];
	};
};

vAiDriving_handlePedestrianFnc = {
	private _aiPedestrians = [];
	_aiPedestrians = allUnits select {(alive _x && (_x isKindOf "CAManBase") && !(isAgent teamMember _x) && !(isPlayer _x) && (local _x) && (isNull (objectParent _x)) && !(_x in playableUnits) && (currentWeapon _x isEqualTo "") && (side group _x isEqualTo CIVILIAN))}; //Select all Ai Civs.
	if !(_aiPedestrians isEqualTo []) then {
		{
			if (isNil {_x getVariable "vAiPedestrianSet"}) then {
				_x setVariable ["vAiPedestrianSet",0];
				[_x] call vAiDriving_setPedestrian;
			};
		sleep (1 + (random 1));	
		} forEach _aiPedestrians;
	};
};

vAiDriving_setPedestrian = {
	params ["_aiPedestrian"];
	if !(local _aiPedestrian) exitWith {};
	if (isPlayer _aiPedestrian) exitWith {};
	if (_aiPedestrian in playableUnits) exitWith {};
	if !(side group _aiPedestrian isEqualTo CIVILIAN) exitWith {};
	
	[group _aiPedestrian, getPos _aiPedestrian, 100] call BIS_fnc_taskPatrol; // Set the Pedestrian WayPoints
	private _unitType = typeOf _aiPedestrian;
	private _aiPedestrianPos = getPos _aiPedestrian;
	private _aiPedestrianDir = getDir _aiPedestrian;
	
	// just in case
	private _attachMents = attachedObjects _aiPedestrian;
	if (count _attachMents > 0) then {
		{detach _x;} forEach _attachMents;
		{deleteVehicle _x;} forEach _attachMents;
	};
	
	private _agentPedestrian = objNull;
	_agentPedestrian = createAgent [_unitType, [0,0,0], [], 0, "CAN_COLLIDE"];
	_agentPedestrian disableAi "ALL";
	{_agentPedestrian enableAI _x} forEach ["MOVE","PATH","ANIM","TEAMSWITCH"];
	[_agentPedestrian] spawn {params ["_unit"]; sleep 3; _unit moveTo (getPos _unit);};
	removeAllWeapons _agentPedestrian;
	removeAllItems _agentPedestrian;
	removeAllAssignedItems _agentPedestrian;
	removeVest _agentPedestrian;
	removeBackpack _agentPedestrian;
	removeHeadgear _agentPedestrian;
	removeGoggles _agentPedestrian;
	_agentPedestrian disablecollisionwith _aiPedestrian;
	_aiPedestrian disablecollisionwith _agentPedestrian;
	[_agentPedestrian] joinSilent _aiPedestrian; // to get its waypoints!
	_agentPedestrian switchMove "";
	_agentPedestrian enableStamina false;
	_agentPedestrian setanimspeedcoef 0.7;
	_agentPedestrian setCombatMode "BLUE";
	_agentPedestrian setBehaviour "CARELESS";
	_agentPedestrian setSpeedMode "LIMITED";
	_agentPedestrian forcespeed -1;
	_agentPedestrian allowFleeing 0;
	_agentPedestrian setSkill 0.0;
	(group _agentPedestrian) enableDynamicSimulation true;
	(group _agentPedestrian) deleteGroupWhenEmpty true;
	_agentPedestrian setVariable ["BIS_noCoreConversations", true];
	_agentPedestrian disableConversation true;
	_agentPedestrian setSpeaker "NoVoice";
	_agentPedestrian removeAllEventHandlers "HandleDamage";
	_agentPedestrian addEventHandler ["HandleDamage", {params ["","","","","_projectile","","",""]; if (_projectile isEqualTo "") then {_d=0; _d};}];
	deleteVehicle _aiPedestrian;
	_agentPedestrian setpos _aiPedestrianPos;
	_agentPedestrian setdir _aiPedestrianDir;
	_agentPedestrian setVariable ["vAiPedestrianSet",0];
	[_agentPedestrian,50,8,8] spawn vPedestrianPatrol;
};

vPedestrianPatrol = {
	params ["_agent","_radius","_waypoints","_timeOut"];
	if !(isAgent teamMember _agent) exitWith {};
	private _agentMoveCount = _waypoints;
	private _origAgentPos = getPos _agent;
	while {alive _agent} do {
		if (simulationEnabled _agent && diag_fps > 15 && speed _agent < 2) then {
			if (random 10>1) then {
				private _nOa = [];
				_nOa = nearestObjects [_agent, ["house"], _radius];
				if !(_nOa isEqualTo []) then {
					private _rdmO = selectRandom _nOa; 
					private _aDest = getPos _rdmO;
					if !(surfaceIsWater _aDest) then {
						_agent setDestination [_aDest, "LEADER PLANNED", true]; if (random 3 > 1) then {_agent forceWalk false;} else {_agent forceWalk true;};
						private _forcedTimeOut = time + 60;
						waitUntil {sleep (2 + (random 4)); (_agent distance2d _aDest < 10 OR time > _forcedTimeOut)};
						if (isOnRoad (ASLToAGL getPosASL _agent)) then {sleep 0.1;} else {sleep _timeOut;};
					};
				};
			} else {
				_goTalkTo = objNull;
				_goTalkTo = nearestObject [_agent, "CAManBase"];
				if (!(isNull _goTalkTo) && (_goTalkTo distance2d _agent < _radius) && (side _goTalkTo isEqualTo side _agent)) then {
					if (vAiDriving_debug) then { systemChat format ["GOTALKTO: %1",name _goTalkTo]; };
					private _goTalkToPos = getPos _goTalkTo;
					_agent setDestination [_goTalkToPos, "LEADER PLANNED", true]; if (random 3 > 1) then {_agent forceWalk false;} else {_agent forceWalk true;};
					private _forcedTimeOutB = time + 60;
					waitUntil {sleep (2 + (random 4)); (_agent distance2d _goTalkToPos < 10 OR time > _forcedTimeOutB)};
					waitUntil {sleep (2 + (random 2)); (speed _agent < 2 OR time > _forcedTimeOutB)};
					if (_agent distance2d _goTalkTo < 5) then {_agent setDir (getDir _goTalkTo); _goTalkTo setDir (getDir _agent);};
					if (isOnRoad (ASLToAGL getPosASL _agent)) then {sleep 0.1;} else {sleep _timeOut;};
				};
			};
			_agentMoveCount = _agentMoveCount - 1;
			if (vAiDriving_debug) then { systemChat format ["AGENT MOVE COUNT: %1",_agentMoveCount]; };
			if (_agentMoveCount < 1) then {_agent setDestination [_origAgentPos, "LEADER PLANNED", true]; _agentMoveCount = _waypoints; sleep (10 + (random 10));};
			sleep (2 + (random 2));
		} else {sleep (5 + (random 5));};
	 sleep (1 + (random 1));
	};
};

vAiPedestrian_runToNearestBuilding = {
	params ["_aiPedestrian", "_car"];
	if !(isNil {_aiPedestrian getVariable "vIsAvoidingVeh"}) exitWith {};
	if (lifeState _aiPedestrian isEqualTo "INCAPACITATED" OR !(canStand _aiPedestrian)) exitWith {};
	private _onFoot = isNull (objectParent _aiPedestrian); // check for vehicle
	if (!_onFoot) exitWith {}; 	// no further action if unit in vehicle
	if (isPlayer _aiPedestrian) exitWith {};
	
	_aiPedestrian setVariable ["vIsAvoidingVeh", 0];
	if (vAiDriving_debug) then { systemChat format ["PEDESTRIAN RUNNING!",""]; };
	
	private _fleeDir = 180 + (_aiPedestrian getDir _car); //direction opposite to car
	private _fleePos = _aiPedestrian getrelPos [30,_fleeDir]; //finds location at 30 mtrs in established direction.
	
	// nearBuildings
	_NearestBuilding = [];
	_NearestBuilding = _fleePos call CBA_fnc_getNearestBuilding;
	sleep 1;
	if (_NearestBuilding isEqualTo []) exitWith {};
	private _Building = _NearestBuilding select 0;
	if (_aiPedestrian distance2D _Building > 30) exitWith {};
	private _BuildingPositions = [];
	_BuildingPositionsCount = _NearestBuilding select 1;
	
	// pick a random building spot and move!
	_BuildingPosition = getPos _aiPedestrian;
	if (_BuildingPositionsCount > 1) then {_BuildingPosition = (selectRandom (_Building buildingPos -1));} else {_BuildingPosition = getPos _Building;};
	private _previousGroup = group _aiPedestrian;
	
	// Just in case...
	if (count attachedObjects _aiPedestrian > 0) then {
		{detach _x;} forEach attachedObjects _aiPedestrian;
	};	
	// Prepare the Civie so he is able to run!
	_previousGroup deleteGroupWhenEmpty false;
	[_aiPedestrian] join grpNull;
	{_aiPedestrian enableAI _x} forEach ["MOVE","PATH","ANIM","AUTOTARGET","TARGET"];
	_aiPedestrian forceWalk false;
	_aiPedestrian switchMove "";
	_aiPedestrian setUnitPos "UP";
	_aiPedestrian setBehaviour "CARELESS";
	_aiPedestrian forceSpeed -1;
	_aiPedestrian forcespeed 30;
	_aiPedestrian setSpeedMode "FULL";
	if (isAgent teamMember _aiPedestrian) then {
		_aiPedestrian moveTo _BuildingPosition; // agents only move with moveTo.
	} else {
		_aiPedestrian doMove _BuildingPosition;
	};
	[_aiPedestrian, _previousGroup] spawn {
		params ["_aiPedestrian", "_previousGroup"];
		sleep 20;
		_aiPedestrian switchMove "";
		_aiPedestrian allowDamage true;
		_aiPedestrian setVariable ["vIsAvoidingVeh", nil];
		_aiPedestrian setBehaviour "AWARE";
		[_aiPedestrian] join _previousGroup;
		_previousGroup deleteGroupWhenEmpty true;
		_aiPedestrian setUnitPos "AUTO";
		_aiPedestrian forceSpeed -1;
		[group _aiPedestrian, getPos _aiPedestrian, 100] call BIS_fnc_taskPatrol;
	};
};