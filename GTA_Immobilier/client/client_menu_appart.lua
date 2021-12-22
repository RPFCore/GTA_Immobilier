TriggerEvent('instance:registerType', 'appart')

RegisterNetEvent('instance:onCreate')
AddEventHandler('instance:onCreate', function(instance)
    if instance.type == 'appart' then
        TriggerEvent('instance:enter', instance)
    end
end)


mainStockage = RageUI.CreateMenu("Habitation", "Vos options.")
local subStockage =  RageUI.CreateSubMenu(mainStockage, "Petit", "- Petit coffre 100$\nVous pouvez en suite le retrouver dans votre inventaire et l'~g~UTILISER~w~ pour le palcer ou vous le souhaitez...")
local subStockage1 =  RageUI.CreateSubMenu(mainStockage, "Grande", "- Grande coffre 1000$\nVous pouvez en suite le retrouver dans votre inventaire et l'~g~UTILISER~w~ pour le palcer ou vous le souhaitez...")
local subStockage2 =  RageUI.CreateSubMenu(mainStockage, "Inviter", "Inviter un joueur a rentrer chez vous.")
--local subStockage3 =  RageUI.CreateSubMenu(mainStockage, "Garage", "Aller au garagre personnel.")

local index = 1
local secondIndex = 1

--MENU :
function OnMenuStockage()

    RageUI.IsVisible(mainStockage, function()
        RageUI.Button("Petit coffre", "Vous pouvez en suite le retrouver dans votre inventaire et l'~g~UTILISER~w~ pour le palcer ou vous le souhaitez...", {}, true, {onSelected = function() end}, subStockage)
        RageUI.Button("Grand coffre", "Vous pouvez en suite le retrouver dans votre inventaire et l'~g~UTILISER~w~ pour le palcer ou vous le souhaitez...", {}, true, {onSelected = function() end}, subStockage1)
        RageUI.Button("Inviter", "", {}, true, {onSelected = function() end}, subStockage2)
     --   RageUI.Button("Garage", "", {}, true, {onSelected = function() end}, subStockage3)
    end, function()end) 

    RageUI.IsVisible(subStockage, function()
        RageUI.Button("Petit", "- Prix du petit coffres ~y~100~w~$\n- Il dispose de ~y~100~w~kg de stockage\nVous pouvez en suite le retrouver dans votre inventaire et l'~g~UTILISER~w~ pour le palcer ou vous le souhaitez sur la map...\nVous pouvez le ~b~RENOMER~w~ et mettre un code de securité pour que personne ne puisse avoir acces ! ", "", true, { 
                        onSelected = function()
                        TriggerServerEvent("GTASuperette:RecevoirItem", 1, "coffre", 100)
           RageUI.CloseAll(true)
           end});
        end, function() 
    end)

    RageUI.IsVisible(subStockage1, function()
        RageUI.Button("Grande", "- Prix du petit coffres ~y~1000~w~$\n- il dispose de ~y~1000~w~kg de stockage\nVous pouvez en suite le retrouver dans votre inventaire et l'~g~UTILISER~w~ pour le palcer ou vous le souhaitez sur la map...\nVous pouvez le ~b~RENOMER~w~ et mettre un code de securité pour que personne ne puisse avoir acces !", "", true, { 
                        onSelected = function()
                        TriggerServerEvent("GTASuperette:RecevoirItem", 1, "grand_coffre", 1000)
           RageUI.CloseAll(true)
        end});
        end, function() 
    end)

    RageUI.IsVisible(subStockage2, function()
        RageUI.Button("Inviter", "Inviter un joueur a rentrer chez vous. Il doit ce trouver a votre porte !", "", true, { 
        onSelected = function()
        for shop = 1, #Config.Locations do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = GetDistanceBetweenCoords(plyCoords, sPed["x"], sPed["y"], sPed["z"], true)
            local sPed = Config.Locations[shop]["sPed"]
            local invit = Config.Locations[shop]["homeOut"]
            local player = GetPlayerPed(-1)
            local appart = player
            local inviter = sPed

            if dist <= 6.0 then
                DoScreenFadeOut(2000)
                Wait(2000)
                TriggerEvent('instance:invite', inviter, 'appart')
                SetEntityCoords(inviter, invit["x"], invit["y"], invit["z"])
                SetEntityHeading(inviter, invit["h"])
                Wait(5000)
                DoScreenFadeIn(2000)   
                RageUI.CloseAll(true)
            else
                TriggerEvent("NUI-Notification", {"Il y a personne a votre porte.", "warning"})    
                end
            end
        end});
        end, function() 
    end)

   -- RageUI.IsVisible(subStockage3, function()
    --    RageUI.Button("Garage", "Aller dans le garage.", "", true, { 
           -- onSelected = function()
             --   for shop = 1, #Config.Locations do
                --    local player = GetPlayerPed(-1)
               ---     local ghIn = Config.Locations[shop]["ghIn"]
               --     TriggerEvent('instance:leave')
               --     Wait(2000)
               --     TriggerEvent('instance:close')
               --     DoScreenFadeOut(2000)
               --     Wait(2000)
               --     SetEntityCoords(player, ghIn["x"], ghIn["y"], ghIn["z"])
              --      SetEntityHeading(player, ghIn["h"])
              --      Wait(5000)
              --      DoScreenFadeIn(2000) 
              --      RageUI.CloseAll(true) 
           --     end
               -- TriggerEvent("entreGarage") 
         --   end});
     --   end, function() 
   -- end)
end



Citizen.CreateThread(function()
    while true do
        Duree = 250
        OnMenuStockage()
        for shop = 1, #Config.Locations do
           local storage = Config.Locations[shop]["storage"]
           local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
           local dist = GetDistanceBetweenCoords(plyCoords, storage["x"], storage["y"], storage["z"], true)

            if dist <= 2.0 then
                Duree = 0
                if GetLastInputMethod(0) then
                    Ninja_Core__DisplayHelpAlert("~INPUT_PICKUP~ pour ~b~intéragir")
                else
                    Ninja_Core__DisplayHelpAlert("~INPUT_CELLPHONE_EXTRA_OPTION~ pour ~b~intéragir")
                end
           
               if (IsControlJustReleased(0, 38) or IsControlJustReleased(0, 214)) then 
                    RageUI.Visible(mainStockage, not RageUI.Visible(deposerMenu))
               end
            end
        end

        if RageUI.Visible(mainStockage) or RageUI.Visible(deposerMenu) == true then 
            DisableControlAction(0, 140, true) --> DESACTIVER LA TOUCHE POUR PUNCH
            DisableControlAction(0, 172,true) --DESACTIVE CONTROLL HAUT  
        end
       Citizen.Wait(Duree)
   end
end) 

function GetPlayers()
    local players = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        players[#players + 1] = player
    end
    return players
end

RoundNumber = function(value, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", value))
end

function RemoveItem(arg)
    local id = tonumber(arg[1])
    local lib = arg[2]
    local qtymax = arg[3]
    local vehFront = VehicleInFront()
    if vehFront > 0 then
        local qty = DisplayInput()
        if (type(qty) ~= "number") then
            TriggerEvent("NUI-Notification", {"Veuillez saisir un nombre correct.", "warning"})
            return false
        end
        if tonumber(qty) <= tonumber(qtymax) and tonumber(qty) > -1 then
            TriggerServerEvent("GTA_Coffre:looseItem", GetVehicleNumberPlateText(vehFront), id, tonumber(qty))
        else
            TriggerEvent("NUI-Notification", {"Il n'y a pas autant de " .. lib .. " dans votre inventaire", "warning"})
        end
    end
end

function AddItem(arg)
    local id = tonumber(arg[1])
    local lib = arg[2]
    local qtymax = arg[3]
    local vehFront = VehicleInFront()
    if vehFront > 0 then
        local qty = DisplayInput()
        if (type(qty) ~= "number") then
            TriggerEvent("NUI-Notification", {"Veuillez saisir un nombre correct.", "warning"})
            return false
        end
        if tonumber(qty) <= tonumber(qtymax) and tonumber(qty) > -1 then
            TriggerServerEvent("GTA_Coffre:receiveItem", GetVehicleClass(vehFront), GetVehicleNumberPlateText(vehFront), id, lib, tonumber(qty))
        else
            TriggerEvent("NUI-Notification", {"Il n'y a pas autant de " .. lib .. " dans le coffre", "warning"})
        end
    end
end


function VehicleInFront()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 3.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
    local a, b, c, d, result = GetRaycastResult(rayHandle)
    return result
end


function DisplayInput()
    DisplayOnscreenKeyboard(1, "FMMC_MPM_TYP8", "", "", "", "", "", 30)
    while UpdateOnscreenKeyboard() == 0 do
        DisableAllControlActions(0)
        Wait(1)
    end
    if GetOnscreenKeyboardResult() then
        return tonumber(GetOnscreenKeyboardResult())
    end
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if (IsControlJustReleased(0, 38) or IsControlJustReleased(0, 214)) then --> E
            local vehFront = VehicleInFront()
            if vehFront > 0 then
                lastPlate = vehFront
                if (RageUI.Visible(mainMenuCoffre) == false) then 
                    SetVehicleDoorOpen(lastPlate, 5, false, false)
                    TriggerServerEvent("GTA_Coffre:RequestPlayerInventory")
                    TriggerServerEvent("GTA_Coffre:RequestItemsCoffre", GetVehicleNumberPlateText(vehFront))
                    Wait(125)
                    RageUI.Visible(mainMenuCoffre, true)
                    SetVehicleDoorShut(lastPlate, 5, false)
                end
            end
        end
    end
end)




--> Executer une fois la ressource restart : 
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    TriggerServerEvent("GTA_Coffre:RequestPlayerInventory")
end)
