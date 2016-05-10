/*  
	fn_startHack.sqf
	
	Copyright 2016 Jan Babor

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

		http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.
*/
private ["_object","_player","_laptops","_pos","_laptop"];

_object = objectFromNetId ([_this, 0, "",[""]] call BIS_fnc_param);
_player = objectFromNetId ([_this, 1, "",[""]] call BIS_fnc_param);

if(isNull _object || isNull _player)exitWith{false};

if(((((getPos _object) nearObjects ["Exile_Construction_Flag_Static", 150]) select 0) getVariable ["ExAd_HACKS_SUCCEEDED",0]) >= ExAd_HACKING_TERRITORY_MAX)exitWith{
	["Connection failed! Territory Wi-Fi is down!" ,0,0.6,2,0] remoteExec ["BIS_fnc_dynamicText",owner _player];
};

_laptops = nearestObjects [getPos _object, ["Exile_Construction_Laptop_Static"], 200];
if(({(_x getVariable ["ExAd_HACKING_IN_PROGRESS", false])}count _laptops) >= 1)exitWith{
		[STR_ExAd_HACKING_NOTI_TERRITORY_ONE_HACK,0,0.6,2,0] remoteExec ["BIS_fnc_dynamicText",owner _player];
		false
};

if(isNil "ExAd_HACKS_IN_PROGRESS")then{
	ExAd_HACKS_IN_PROGRESS = 0;
};

_pos = _player modelToWorld [0, +0.5, 0];
_pos set [2,((getPosATL _player) select 2)];

_laptop = createVehicle ["Exile_Construction_Laptop_Static", _pos, [], 0, "CAN_COLLIDE"];
_laptop setDir ((direction _player) - 90);

_laptop setVariable ["ExAd_HACKING_IN_PROGRESS", true, true];
_laptop animate ["LaptopLidRotation", 1];

_player removeItem "Exile_Item_Laptop";

[_object, _player, _laptop] spawn {
	private ["_object","_player","_laptop","_markers","_marker","_success","_ticks","_newSize","_destroy","_msg"];
	params ["_object","_player","_laptop"];
	UISleep 2;
	
	(parseText (format["<t color='%1' size='%2' font='%3'>%4</t><br/><t color='%5' size='%6' font='%7'>%8</t>", ExAd_Hint_Title_Color, ExAd_Hint_Title_Size, ExAd_Hint_Title_Font,STR_ExAd_HACKING_HINT_TITLE, ExAd_Hint_Msg_Color, ExAd_Hint_Msg_Size, ExAd_Hint_Msg_Font, STR_ExAd_HACKING_HINT_HACK_START])) remoteExec ["hint", -2];
	
	if(ExAd_HACKS_IN_PROGRESS >= ExAd_HACKING_ALLOWED_HACKS)exitWith{
		_laptop setVariable ["ExAd_HACKING_IN_PROGRESS", false, true];
		_laptop setDamage 1;
		[format[STR_ExAd_HACKING_NOTI_MAX_SIM_HACKS],0,0.6,2,0] remoteExec ["BIS_fnc_dynamicText",owner _player];
		false
	};
	
	ExAd_HACKS_IN_PROGRESS = ExAd_HACKS_IN_PROGRESS + 1;
	
	_markers = [getPos _laptop, ExAd_HACKING_MARKER_COLOR, 200, str (netId _object), ExAd_HACKING_MARKER_TITLE,true] call ExAdServer_fnc_createMarker;
	_marker = _markers select 0;
	_success = false;
	
	while {!(_laptop getVariable ["ExAd_HACK_INTERUPTED",false]) && _laptop getVariable ["ExAd_HACK", 0] <= ExAd_HACKING_MAX_TIME} do {
		UISleep 1;
		_ticks = (_laptop getVariable ["ExAd_HACK", 0]) + 1;
		_laptop setVariable ["ExAd_HACK", _ticks];
		
		if((_ticks % (ExAd_HACKING_MAX_TIME / 10)) == 0)then{
			_newSize = ((getMarkerSize _marker) select 0) - 20;
			_marker setMarkerSize [_newSize,_newSize];
		};
		
		if(_ticks >= ExAd_HACKING_MAX_TIME)exitWith{_success = true};
		
		waitUntil{{(_x distance (getPosATL _laptop)) < ExAd_HACKING_MAX_DISTANCE}count playableUnits > 0};
	};
	
	_laptop setVariable ["ExAd_HACKING_IN_PROGRESS", false, true];
	_laptop animate ["LaptopLidRotation", 0];
	_destroy = false;
	
	_msg = if(_success && ((random 1) > ExAd_HACKING_FAILED_HACK))then{
		_flag = ((getPos _object) nearObjects ["Exile_Construction_Flag_Static", 150]) select 0;
		_flag setVariable ["ExAd_HACKS_SUCCEEDED", (_flag getVariable ["ExAd_HACKS_SUCCEEDED",0]) + 1];
		if(_object isKindOf "Exile_Construction_Flag_Static")then{
			if(!isClass(configFile >> "CfgPatches" >> "ExAd_VG"))then{
				["startHack", "You are missing the ExAd_VG dependenci to run this function.", true] call ExAd_fnc_debugHandler;
				"This server isn't using the Virtual Garage"
			}else{			
				private ["_vehList","_objId","_vehObj","_extDB2Message","_pos"];
				_vehList = _object getVariable ["ExAdVGVeh", []];
				if((count _vehList) > 0)then{
					_objId = (_vehList call BIS_fnc_selectRandom) select 0;
					{
						if((_x select 0) isEqualTo _objId)exitWith{
							_vehList deleteAt _forEachIndex;
						}
					}forEach _vehList;
					_object setVariable ["ExAdVGVeh", _vehList, true];
					
					_vehObj = _objId call ExileServer_object_vehicle_database_load;
					_extDB2Message = ["loadVehFromVG", [_objId]] call ExileServer_util_extDB2_createMessage;
					_extDB2Message call ExileServer_system_database_query_fireAndForget;
					
					_pos = getPosATL _vehObj;
					_pos set [2, (_pos select 2) + 0.1];
					_vehObj setPosATL _pos;			
					_vehObj lock 0;
					
					format[STR_ExAd_HACKING_NOTI_VG_SUCCESS, (getText(ConfigFile >> "CfgVehicles" >> typeOf _vehObj >> "displayName"))]
				}else{
					STR_ExAd_HACKING_NOTI_VG_NO_VEH
				}
			}
		}else{
			_object setVariable ["ExileIsLocked",0,true];
			STR_ExAd_HACKING_NOTI_SAFE_SUCCESS
		}
	}else{
		if(_laptop getVariable ["ExAd_HACK_INTERUPTED",false])then{
			STR_ExAd_HACKING_NOTI_INTERUPTED
		}else{
			_destroy = true;
			STR_ExAd_HACKING_NOTI_FAILED
		}
	};
	
	if(_destroy)then{
		_laptop setDamage 1;
	}else{
		private ["_holderPos","_holder"];
		_holderPos = getPosATL _laptop;
		deleteVehicle _laptop;
		_holder = createVehicle ["GroundWeaponHolder", _holderPos, [], 0, "CAN_COLLIDE"];
		_holder addMagazineCargoGlobal ["Exile_Item_Laptop", 1];
	};	
	
	{
		if(((getPosATL _laptop) distance (getPosATL _x)) < ExAd_HACKING_MAX_DISTANCE)then{
			[_msg,0,0.6,2,0] remoteExec ["BIS_fnc_dynamicText", owner _x]
		}
	}forEach playableUnits;
	
	ExAd_HACKS_IN_PROGRESS = ExAd_HACKS_IN_PROGRESS - 1;
	{deleteMarker _x}forEach _markers;
};

true