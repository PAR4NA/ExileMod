/**
 * ExileServer_object_construction_network_addLockRequest
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_sessionID","_paramaters","_door","_pincode","_playerObject","_databaseID"];
_sessionID = _this select 0;
_paramaters = _this select 1;
_door = _paramaters select 0;
_pincode = _paramaters select 1;
try
{
	_playerObject = _sessionID call ExileServer_system_session_getPlayerObject;
	if !("Exile_Item_Codelock" in (_playerObject call ExileClient_util_playerCargo_list)) then 
	{
		throw "You dont have a code lock!";
	};
	if !(isNumber(configFile >> "CfgVehicles" >> (typeOf _door) >> "ExileIsDoor")) then 
	{
		throw "That is not a door!";
	};
	if !((_door getVariable ["ExileIsLocked",""]) isEqualTo "") then 
	{
		throw "Door is already locked";
	};
	if !((count _pincode) isEqualTo 4) then 
	{
		throw "Invalid PinCode";
	};
	if ((_door animationPhase 'DoorRotation') > 0.5) then 
	{
		throw "Close the door first!";
	};
	_databaseID = _door getVariable ["ExileDatabaseID",0];
	if(_databaseID isEqualTo 0) then 
	{
		throw "Smt went goof";
	};
	_door setVariable ["ExileIsLocked",-1,true];
	_door setVariable ["ExileAccessCode",_pincode];
	format ["addDoorLock:%1:%2",_pincode,_databaseID] call ExileServer_system_database_query_fireAndForget;
	[_sessionID,"addLockResponse",[_pincode]] call ExileServer_system_network_send_to;
}
catch
{
	[_sessionID,"notificationRequest",["Whoops",[_exception]]] call ExileServer_system_network_send_to;
	_exception call ExileServer_util_log;
};