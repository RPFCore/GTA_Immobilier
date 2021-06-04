
----> MENU :
mainStockage = RageUI.CreateMenu("Stockage", "Coffre habitation.")
local subStockage = RageUI.CreateSubMenu(mainStockage, "Stockage", "Deposer ou retirer.")

local index = 1
local secondIndex = 1
--> Main Menu :
function OnMenuStockage()
    RageUI.IsVisible(mainStockage, function()
        RageUI.Button("Vérifier le stock", "", {}, true, {onSelected = function() TriggerServerEvent("GTA_Immobilier:GetAllStock") end}, subStockage)
    end, function()end)


    RageUI.IsVisible(subStockage, function()
         for k, v in pairs(Config.Stockage) do 
            if (v.argent >= 0) then
                RageUI.List('💵  Argent Propre ~g~' ..v.argent .. "$", {
                    { Name = "Récuperer" },
                    { Name = "Déposer" }
                }, index, "", {}, true, {
                    onListChange = function(Index, Item) index = Index; end,
        
                    onSelected = function(Index, Item)
                        if Index == 1 then 
                            local qty = InputNombre("Montant à retirer")
                            if qty == nil then
                                TriggerEvent("NUI-Notification", {"Quantité non valide.", "warning", "fa fa-exclamation-circle fa-2x", "warning"})
                            else
                                TriggerServerEvent('GTA_Immobilier:RetirerArgentPropreStockage', tonumber(qty))
                            end
                            RageUI.CloseAll(true)
                        elseif Index == 2 then 
                            local qty = InputNombre("Montant à déposer")
                            if qty == nil then
                                TriggerEvent("NUI-Notification", {"Quantité non valide.", "warning", "fa fa-exclamation-circle fa-2x", "warning"})
                            else
                                TriggerServerEvent('GTA_Immobilier:DeposerArgentPropreStockage', tonumber(qty))
                            end
                            RageUI.CloseAll(true)
                        end
                    end,
                })
            end

            if (v.argent_sale >= 0) then
                RageUI.List('💴   Argent sale ~r~' ..v.argent_sale .. "$", {
                    { Name = "Récuperer" },
                    { Name = "Déposer" }
                }, secondIndex or 1, "", {}, true, {
                    onListChange = function(Index, Item) secondIndex = Index; end,
        
                    onSelected = function(Index, Item)
                        if Index == 1 then 
                            local qty = InputNombre("Montant à retirer")
                            if qty == nil then
                                TriggerEvent("NUI-Notification", {"Quantité non valide.", "warning", "fa fa-exclamation-circle fa-2x", "warning"})
                            else
                                TriggerServerEvent('GTA_Immobilier:RetirerArgentSaleStockage', tonumber(qty))
                            end
                            RageUI.CloseAll(true)
                        elseif Index == 2 then 
                            local qty = InputNombre("Montant à déposer")
                            if qty == nil then
                                TriggerEvent("NUI-Notification", {"Quantité non valide.", "warning", "fa fa-exclamation-circle fa-2x", "warning"})
                            else
                                TriggerServerEvent('GTA_Immobilier:DeposerArgentSaleStockage', tonumber(qty))
                            end
                            RageUI.CloseAll(true)
                        end
                    end,
                })
            end
        end
    end, function()end)
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
                    RageUI.Visible(mainStockage, not RageUI.Visible(subStockage))
               end
            end
        end

        if RageUI.Visible(mainStockage) or RageUI.Visible(subStockage) == true then 
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