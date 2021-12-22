local instance, instancedPlayers, registeredInstanceTypes, playersToHide = {}, {}, {}, {}
local instanceInvite, insideInstance

function GetInstance()
	return instance
end

function CreateInstance(type, data)
	TriggerServerEvent('instance:create', type, data)
	print("creation instance")
end

function CloseInstance()
	instance = {}
	TriggerServerEvent('instance:close')
	insideInstance = false
	print("close instance")
end

function EnterInstance(instance)
	insideInstance = true
	Citizen.CreateThread(function()
		while insideInstance do
			Citizen.Wait(0)

			SetVehicleDensityMultiplierThisFrame(0.0)
			SetParkedVehicleDensityMultiplierThisFrame(0.0)

			local pos = GetEntityCoords(PlayerPedId())
			RemoveVehiclesFromGeneratorsInArea(pos.x - 900.0, pos.y - 900.0, pos.z - 900.0, pos.x + 900.0, pos.y + 900.0, pos.z + 900.0)
		end
	end)
	TriggerServerEvent('instance:enter', instance.host)
		print("entre instance")

	if registeredInstanceTypes[instance.type].enter then
		registeredInstanceTypes[instance.type].enter(instance)
	end
end

function LeaveInstance()
	if instance.host then
		if registeredInstanceTypes[instance.type].exit then
			registeredInstanceTypes[instance.type].exit(instance)
		end

		TriggerServerEvent('instance:leave', instance.host)
		print("leave instance")
	end

	insideInstance = false
end

function InviteToInstance(type, player, data)
	TriggerServerEvent('instance:invite', instance.host, type, player, data)
end

function RegisterInstanceType(type, enter, exit)
	registeredInstanceTypes[type] = {
		enter = enter,
		exit  = exit
	}
end

AddEventHandler('instance:get', function(cb)
	cb(GetInstance())
end)

AddEventHandler('instance:create', function(type, data)
	CreateInstance(type, data)
end)

AddEventHandler('instance:close', function()
	CloseInstance()
end)

AddEventHandler('instance:enter', function(_instance)
	EnterInstance(_instance)
end)

AddEventHandler('instance:leave', function()
	LeaveInstance()
end)

AddEventHandler('instance:invite', function(type, player, data)
	InviteToInstance(type, player, data)
end)

AddEventHandler('instance:registerType', function(name, enter, exit)
	RegisterInstanceType(name, enter, exit)
end)

RegisterNetEvent('instance:onInstancedPlayersData')
AddEventHandler('instance:onInstancedPlayersData', function(_instancedPlayers)
	instancedPlayers = _instancedPlayers
end)

RegisterNetEvent('instance:onCreate')
AddEventHandler('instance:onCreate', function(_instance)
	instance = {}
end)

RegisterNetEvent('instance:onEnter')
AddEventHandler('instance:onEnter', function(_instance)
	instance = _instance
end)

RegisterNetEvent('instance:onLeave')
AddEventHandler('instance:onLeave', function(_instance)
	instance = {}
end)

RegisterNetEvent('instance:onClose')
AddEventHandler('instance:onClose', function(_instance)
	instance = {}
end)

RegisterNetEvent('instance:onPlayerEntered')
AddEventHandler('instance:onPlayerEntered', function(_instance, player)
	instance = _instance
end)

RegisterNetEvent('instance:onPlayerLeft')
AddEventHandler('instance:onPlayerLeft', function(_instance, player)
	instance = _instance
end)

RegisterNetEvent('instance:onInvite')
AddEventHandler('instance:onInvite', function(_instance, type, data)
	instanceInvite = {
		type = type,
		host = _instance,
		data = data
	}
	Citizen.CreateThread(function()
		while instanceInvite do
			Citizen.Wait(0)

			if GetLastInputMethod(0) then
                TriggerEvent("GTA-Notification:InfoInteraction", "~INPUT_PICKUP~ pour entrer.")
            else
                TriggerEvent("GTA-Notification:InfoInteraction", "~INPUT_CELLPHONE_EXTRA_OPTION~ pour entrer.")
            end

			if (IsControlJustReleased(0, 38) or IsControlJustReleased(0, 214)) then --> E
				EnterInstance(instanceInvite)
				instanceInvite = nil
			end
		end
	end)
	
	Citizen.CreateThread(function()
		Citizen.Wait(10000)

		if instanceInvite then
            TriggerEvent("NUI-Notification", {"L'invitation à expirer."})
			instanceInvite = nil
		end
	end)
		
end)

RegisterInstanceType('default')

-- Instance players
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		playersToHide = {}

		if instance.host then
			-- Get players and sets them as pairs
			for _,v in ipairs(GetActivePlayers()) do
				playersToHide[GetPlayerServerId(v)] = true
			end

			-- Dont set our instanced players invisible
			for _,player in ipairs(instance.players) do
				playersToHide[player] = nil
			end
		else
			for player in pairs(instancedPlayers) do
				playersToHide[player] = true
			end
		end
	end
end)

local optiTime = 1000
Citizen.CreateThread(function()
	while true do
		optiTime = 1000

		local playerPed = PlayerPedId()

		-- Hide all these players
		for serverId in pairs(playersToHide) do
			local player = GetPlayerFromServerId(serverId)

			if NetworkIsPlayerActive(player) then
				optiTime = 0
				local otherPlayerPed = GetPlayerPed(player)
				SetEntityVisible(otherPlayerPed, false, false)
				SetEntityNoCollisionEntity(otherPlayerPed, playerPed, true)
			end
		end

		Citizen.Wait(optiTime)
	end
end)

Citizen.CreateThread(function()
	TriggerEvent('instance:loaded')
end)