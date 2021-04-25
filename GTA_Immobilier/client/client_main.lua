--> Event : 
RegisterNetEvent("GTASuperette:Achat")
AddEventHandler("GTASuperette:Achat",  function(quantityItems, nameItem)
    TriggerEvent("player:receiveItem", nameItem, quantityItems)

    for shop = 1, #Config.Locations do
        local sPed = Config.Locations[shop]["sPed"]
        PlayAmbientSpeech2(sPed["entity"], "GENERIC_THANKS", "SPEECH_PARAMS_FORCE_SHOUTED") --> Sert a faire parler le ped plus l'animer.
    end

    PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", false)
    exports.nCoreGTA:Ninja_Core_PedsText("~b~Vendeur ~w~: ~g~Merci !", 1000)
end)

RegisterNetEvent("GTASuperette:AchatFail")
AddEventHandler("GTASuperette:AchatFail",  function()
    for shop = 1, #Config.Locations do
        local sPed = Config.Locations[shop]["sPed"]
        PlayAmbientSpeech2(sPed["entity"], "GENERIC_BYE", "SPEECH_PARAMS_FORCE_SHOUTED") --> Sert a faire parler le ped plus l'animer.
    end
    
    PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", false)
    exports.nCoreGTA:Ninja_Core_PedsText("~b~Vendeur ~w~: ~r~A bientôt !", 1000)
end)




--> Function : 
Ninja_Core__DisplayHelpAlert = function(msg)
	BeginTextCommandDisplayHelp("STRING");  
    AddTextComponentSubstringPlayerName(msg);  
    EndTextCommandDisplayHelp(0, 0, 1, -1);
end

_RequestModel = function(hash)
    if type(hash) == "string" then hash = GetHashKey(hash) end
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(0)
    end
end

DeleteCashier = function()
    for i=1, #Config.Locations do
        local sPed = Config.Locations[i]["sPed"]
        if DoesEntityExist(sPed["entity"]) then
            DeletePed(sPed["entity"])
            SetPedAsNoLongerNeeded(sPed["entity"])
        end
    end
end

function InputNombre(reason)
	local text = ""
	AddTextEntry('nombre', reason)
    DisplayOnscreenKeyboard(1, "nombre", "", "", "", "", "", 4)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0)
        Wait(10)
    end
    if (GetOnscreenKeyboardResult()) then
        text = GetOnscreenKeyboardResult()
    end
    return text
end

function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end
 
 function LocalPed()
     return GetPlayerPed(-1)
 end

Citizen.CreateThread(function()
    local defaultHash = 1567728751
    for i=1, #Config.Locations do
        local sPed = Config.Locations[i]["sPed"]
        if sPed then
            sPed["hash"] = sPed["hash"] or defaultHash
            _RequestModel(sPed["hash"])
            if not DoesEntityExist(sPed["entity"]) then
                sPed["entity"] = CreatePed(4, sPed["hash"], sPed["x"], sPed["y"], sPed["z"], sPed["h"])
                SetEntityAsMissionEntity(sPed["entity"])
                SetBlockingOfNonTemporaryEvents(sPed["entity"], true)
                FreezeEntityPosition(sPed["entity"], true)
                SetEntityInvincible(sPed["entity"], true)
            end
            SetModelAsNoLongerNeeded(sPed["hash"]) 
        end
    end
end)


Citizen.CreateThread(function()
    for shop = 1, #Config.Locations do
        local blip = Config.Locations[shop]["sPed"]
        blip = AddBlipForCoord(blip["x"], blip["y"], blip["z"])

        SetBlipSprite(blip, 476)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.9)
      --  SetBlipColour(blip, 24)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Agence Immobilière")
        EndTextCommandSetBlipName(blip)
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        DeleteCashier()
    end
end)

--------------------- spawn

local positionConfig = json.decode(LoadResourceFile(GetCurrentResourceName(), 'json/config.json'))
local Duree = 0
local square = math.sqrt

local function getDistance(a, b) 
    local x, y, z = a.x-b.x, a.y-b.y, a.z-b.z
    return square(x*x+y*y+z*z)
end

local function DisplayHelpAlert(msg)
    BeginTextCommandDisplayHelp("STRING");  
    AddTextComponentSubstringPlayerName(msg);  
    EndTextCommandDisplayHelp(0, 0, 1, -1);
end

Citizen.CreateThread(function ()
    while true do
        Duree = 1000
        local player = GetPlayerPed(-1)
        local playerLoc = GetEntityCoords(player)


        for home=1, #Config.Locations do

        local hIn = Config.Locations[home]["homeIn"]
        local hOut = Config.Locations[home]["homeOut"]

            local distanceZone2 = getDistance(playerLoc, hOut)
            local distanceZone1 = getDistance(playerLoc, hIn)
            local key = Config.Locations[home]["key"]

            if distanceZone1 <= 15 then
                Duree = 8
                DrawMarker(25, hIn.x, hIn.y, hIn.z, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, 20, 19,19, 0.5)
            end
            
            if distanceZone2 <= 15 then
                Duree = 8
                DrawMarker(25, hOut.x, hOut.y, hOut.z, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, 20, 19,19, 0.5)        
            end

            if distanceZone1 < 1 then
                Duree = 8

                if GetLastInputMethod(0) then
                    DisplayHelpAlert("~INPUT_PICKUP~ pour ~b~intéragir")
                else
                    DisplayHelpAlert("~INPUT_CELLPHONE_EXTRA_OPTION~ pour ~b~intéragir")
                end

                if (IsControlJustReleased(0, 38) or IsControlJustReleased(0, 214)) then  
                  if (exports.nMenuPersonnel:getQuantity(key["clef"]) > 0) then
                    if IsPedInAnyVehicle(player, true) then
                        SetEntityCoords(GetVehiclePedIsUsing(player), hOut["x"], hOut["y"], hOut["z"])
                        SetEntityHeading(GetVehiclePedIsUsing(player), hOut["h"])
                    else
                        SetEntityCoords(player, hOut["x"], hOut["y"], hOut["z"])
                        SetEntityHeading(player, hOut["h"])     
                    end
                  else
                  TriggerEvent("rpf:notify", "CHAR_DEVIN", 8, 41, "Achat Appartement", "Disponible !", "Tu doit avoir la clef,\nTrouve les ~b~agences immobiliere en ville~w~ pour acheter...")
                end
                end
            elseif distanceZone2 < 1 then
                Duree = 8

                if GetLastInputMethod(0) then
                    DisplayHelpAlert("~INPUT_PICKUP~ pour ~r~sortir")
                else
                    DisplayHelpAlert("~INPUT_CELLPHONE_EXTRA_OPTION~ pour ~r~sortir")
                end

                if (IsControlJustReleased(0, 38) or IsControlJustReleased(0, 214)) then 
                    if IsPedInAnyVehicle(player, true) then
                        SetEntityCoords(GetVehiclePedIsUsing(player),hIn["x"], hIn["y"], hIn["z"])
                        SetEntityHeading(GetVehiclePedIsUsing(player), hIn["h"])
                    else
                        SetEntityCoords(player, hIn["x"], hIn["y"], hIn["z"])
                        SetEntityHeading(player, hIn["h"])
                    end
                end
            end
        end
        Citizen.Wait(Duree)
    end
end)

RegisterNetEvent("rpf:notify")
AddEventHandler("rpf:notify", function(icon, type, color, sender, title, text)
    Citizen.InvokeNative(0x92F0DA1E27DB96DC, tonumber(color))
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    SetNotificationMessage(icon, icon, true, type, sender, title, text)
    DrawNotification(false, true)

    PlaySoundFrontend(GetSoundId(), "Text_Arrive_Tone", "Phone_SoundSet_Default", true)
end)

RegisterNetEvent("rpf:displayHelp")
    AddEventHandler("rpf:displayHelp", function(text)
     BeginTextCommandDisplayHelp("STRING")
     AddTextComponentScaleform(text)
     EndTextCommandDisplayHelp(0, 0, 1, -1)
end)  

RegisterNetEvent("rpf:displayPopup")
AddEventHandler("rpf:displayPopup", function(text)
    DrawPopup(text)
end)

function DrawPopup(text)
    ClearPrints()
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(0, 1)
end

Citizen.CreateThread(function()

for shop = 1, #Config.Locations do
local home = Config.Locations[shop]["homeIn"]
            local blip = AddBlipForCoord(home["x"], home["y"], home["z"])
            SetBlipSprite(blip, 375)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.5)
            SetBlipColour(blip, 24)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Logement Libre")
            EndTextCommandSetBlipName(blip)
    end
end)