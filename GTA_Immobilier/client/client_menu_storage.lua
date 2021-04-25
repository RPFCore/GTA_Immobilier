----------------------||Coffre||--------------------
ITEMS = {}
NewItems = {}
local maxCapacity = 500 -->Max the slot dans votre inventaire par item
local indexInv = 1

--[[INFO : TYPE 1 = SOIF, TYPE 2 = FOOD, TYPE 3 = OBJECT,  TYPE 4 = UTILISATION OBJET POUR TARGET]]

mainStorage = RageUI.CreateMenu("Coffre personnel",  "Renger vos affaire !")

local subStorage = RageUI.CreateSubMenu(mainStorage, "Ouvrir", "Voir votre coffre !")
local subInterphone = RageUI.CreateSubMenu(mainStorage, "Ouvrir", "Voir votre coffre !")

local prix = nil
local itemName = " "
local Duree = 0

Citizen.CreateThread(function()
    while (true) do
        RageUI.IsVisible(mainStorage, function()
        RageUI.Button('Interphone', "Faire rentre un autre joueur", {}, true, {}, subInterphone);
        RageUI.Button('Stockage', "Bienvenue dans coffre, vous pouvez prendre ou mettre le contenue de votre sac", {}, true, {
            onSelected = function()
            TriggerServerEvent("item:getItems")
            end}, subStorage);
        end, function()end)

        RageUI.IsVisible(subStorage, function()
            afficherMarkerTarget()
            for k, v in pairs(ITEMS) do
                if v.quantity > 0 then 
                    RageUI.List(v.libelle .. " ".. v.quantity, {
                            { Name = "~h~~b~Utiliser~w~"},
                            { Name = "~h~~g~Donner~w~"},
                            { Name = "~h~~r~Jeter~w~"},
                        }, v.index or 1, "", {}, true, {
                            onListChange = function(Index, Item)
                                v.index = Index;
                            end,

                            onSelected = function(Index, Item)
                                if Index == 1 then  --> Utiliser
                                    exports.rprogress:Start("Intéraction en cours", 1000)
                                    use(k, 1)
                                elseif Index == 2 then --> Donner
                                    local ClosestPlayerSID = GetPlayerServerId(-1)
                                    if ClosestPlayerSID ~= 0 then
                                        local result = InputNombre("Montant : ")
                        
                                        if tonumber(result) == nil then
                                            exports.nCoreGTA:ShowNotification("Veuillez inserer un nombre correct !")
                                            return nil
                                        end
                        
                                        if tonumber(v.quantity) >= tonumber(result) and tonumber(result) > 0 then
                                            exports.rprogress:Start("Intéraction en cours", 1000)
                                            TriggerServerEvent('player:storage',ClosestPlayerSID,k,v.libelle,tonumber(result))
                                        else
                                            exports.nCoreGTA:ShowNotification("~r~Vous n'avez pas assez d'items.")
                                        end
                                    else
                                        exports.nCoreGTA:ShowNotification("~y~ Aucune personne devant vous !")
                                    end
                                    Wait(250)
                                    TriggerEvent("GTA:LoadWeaponPlayer")
                                elseif Index == 3 then --> Jeter
                                    local result = InputNombre("Montant : ")

                                    if tonumber(result) == nil then
                                        exports.nCoreGTA:ShowNotification("Veuillez inserer un nombre correct !")
                                        return nil
                                    end
                        
                                    if tonumber(v.quantity) >= tonumber(result) and tonumber(result) > 0 then
                                        exports.rprogress:Start("Intéraction en cours", 1000)

                                        TriggerEvent('player:looseItem',k,tonumber(result))
                                        exports.nCoreGTA:ShowNotification("~h~Vous avez ~r~jeter ~b~ x".. tonumber(result) .. " "..v.libelle)
                                    else
                                        exports.nCoreGTA:ShowNotification("~r~Vous n'avez pas tout ça sur vous d'items.")
                                    end
                                    Wait(250)
                                    TriggerEvent("GTA:LoadWeaponPlayer")
                                end
                        end,
                    })
                end
            end
        end, function() end)
    Citizen.Wait(Duree)
    end
end)


Citizen.CreateThread(function()
    while true do
        Duree = 250
        for shop = 1, #Config.Locations do
           local storage = Config.Locations[shop]["storage"]
           local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
         --  local dist = GetDistanceBetweenCoords(plyCoords, sPed["x"], sPed["y"], sPed["z"], true)
           local dist = GetDistanceBetweenCoords(plyCoords, storage["x"], storage["y"], storage["z"], true)

            if dist <= 2.0 then
                Duree = 0
                if GetLastInputMethod(0) then
                    Ninja_Core__DisplayHelpAlert("~INPUT_PICKUP~ pour ~b~intéragir")
                else
                    Ninja_Core__DisplayHelpAlert("~INPUT_CELLPHONE_EXTRA_OPTION~ pour ~b~intéragir")
                end
           
               if (IsControlJustReleased(0, 38) or IsControlJustReleased(0, 214)) then 
                    RageUI.Visible(mainStorage, not RageUI.Visible(mainStorage))
               end
            end
        end

        if RageUI.Visible(mainStorage) or RageUI.Visible(subStorage) == true then 
            TriggerServerEvent("item:getItems")
            TriggerServerEvent("GTA_Interaction:GetinfoPlayers")
            TriggerServerEvent("GTA:GetPlayerSexServer")
            DisableControlAction(0, 140, true) --> DESACTIVER LA TOUCHE POUR PUNCH
            DisableControlAction(0, 172,true) --DESACTIVE CONTROLL HAUT  
        end
       Citizen.Wait(Duree)
   end
end) 

function afficherMarkerTarget()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)

    for _,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = getDistance(targetCoords, plyCoords, true)
            if distance < 2 then
                if(closestDistance == -1 or closestDistance > distance) then
                    closestPlayer = value
                    closestDistance = distance
                    DrawMarker(0, targetCoords["x"], targetCoords["y"], targetCoords["z"] + 1, 0, 0, 0, 0, 0, 0, 0.1, 0.1, 0.1, 255, 255, 255, 200, 0, 0, 0, 0)
                end
            end
        end
    end
end

function GetPlayers()
    local players = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        players[#players + 1] = player
    end
    return players
end