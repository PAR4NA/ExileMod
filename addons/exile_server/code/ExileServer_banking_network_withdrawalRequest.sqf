/*

 	Name: ExileServer_banking_network_withdrawalRequest.sqf

 	Author(s): Shix and WolfkillArcadia
    Copyright (c) 2016 Shix and WolfkillArcadia

    This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.

 	Description:
    Process deposit request from Client

*/
private["_sessionID","_parameters","_moneyRequest","_playerObject","_playerWallet","_playerBank"];
_sessionID = _this select 0;
_parameters = _this select 1;
_moneyRequest = parseNumber (_parameters select 0);

try {
    if (ADVBANKING_SERVER_DEBUG) then {[format["Withdrawal Request enacted. Package: %1",_parameters],"WithdrawalRequest"] call ExileServer_banking_utils_diagLog;};
    _playerObject = _sessionID call ExileServer_system_session_getPlayerObject;
    if (isNull _playerObject) then
	{
		throw 1;
	};
	if !(alive _playerObject) then
	{
		throw 2;
	};
    _playerWallet = _playerObject getVariable ["ExilePurse", 0];
    _playerBank = _playerObject getVariable ["ExileBank", 0];
    if (_playerWallet < 0) then {
        throw 3;
    };
    if (_moneyRequest > _playerBank) then {
        throw "You can't withdrawal more than you have in your bank";
    };
    _playerWallet = _playerWallet + _moneyRequest;
    _playerBank = _playerBank - _moneyRequest;
    _playerObject setVariable ["ExilePurse", _playerWallet];
    _playerObject setVariable ["ExileBank",_playerBank];
    format["updateWallet:%1:%2:%3",_playerWallet,(getPlayerUID _playerObject)] call ExileServer_system_database_query_fireAndForget;
    format["updateBank:%1:%2:%3",_playerBank,(getPlayerUID _playerObject)] call ExileServer_system_database_query_fireAndForget;
    [_sessionID,"updateATMResponse",[str(_playerWallet),str(_playerBank)]] call ExileServer_system_network_send_to;
} catch {
    [_sessionID,"handleATMMessage", ["Error",_exception]] call ExileServer_system_network_send_to;
    [_exception,"WithdrawalRequest"] call ExileServer_banking_utils_diagLog;
};
