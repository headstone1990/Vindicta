if (!isServer) exitWith {};
call compile preprocessFileLineNumbers "vScripts\vAiDriving\vAiDriving.sqf";
waitUntil {sleep 1; time > 1};
[] call vAiDriving_init;