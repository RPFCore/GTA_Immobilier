RegisterServerEvent("GTASuperette:RecevoirItem")
AddEventHandler("GTASuperette:RecevoirItem", function(quantityItems, nameItem, prixItem)
	local source = source
	local prixTotal = prixItem * tonumber(quantityItems)

	TriggerEvent('GTA:GetInfoJoueurs', source, function(data)
		local cash = data.argent_propre

		if (tonumber(cash) >= prixTotal) then
			TriggerClientEvent("GTASuperette:Achat", source, quantityItems, nameItem)
			TriggerClientEvent('nMenuNotif:showNotification', source, " + "..quantityItems .. " ".. nameItem)
			TriggerEvent('GTA:RetirerArgentPropre', source, tonumber(prixTotal))
		else
			TriggerClientEvent('GTASuperette:AchatFail', source)
			TriggerClientEvent('GTA_NUI_ShowNotif_client', source, "~r~Tu n'as pas suffisamment d'argent !")
		end
	end)
end)


RegisterNetEvent("GTA_Immobilier:GetAllStock")
AddEventHandler("GTA_Immobilier:GetAllStock", function()
    local source = source
    MySQL.Async.fetchAll('SELECT * FROM gta_immo_stockage',{}, function(res2)
        TriggerClientEvent("GTA_Immobilier:RefreshStockage", source, res2)
    end)
end)

RegisterNetEvent("GTA_Immobilier:RetirerArgentPropreStockage")
AddEventHandler("GTA_Immobilier:RetirerArgentPropreStockage", function(qty)
    local source = source
    MySQL.Async.fetchAll('SELECT * FROM gta_immo_stockage',{}, function(res2)
        local argentPropre = res2[1].argent
        print(argentPropre)
        if (argentPropre >= qty) then
            argentPropre = argentPropre - qty
            MySQL.Async.execute("UPDATE gta_immo_stockage SET argent=@newArgent", {['@newArgent'] = tonumber(argentPropre)})
            TriggerEvent("GTA:AjoutArgentPropre", source, qty)
            TriggerEvent("NUI-Notification", {"Vous avez retirer de l'argent propre dans le coffre."})
        else
            TriggerClientEvent("NUI-Notification", source, {"Montant supérieur au montant disponible.", "warning"})
        end
    end)
end)

RegisterNetEvent("GTA_Immobilier:RetirerArgentSaleStockage")
AddEventHandler("GTA_Immobilier:RetirerArgentSaleStockage", function(qty)
    local source = source
    MySQL.Async.fetchAll('SELECT * FROM gta_immo_stockage',{}, function(res2)
        local argentSale = res2[1].argent_sale
        print(argentSale)
        if (argentSale >= qty) then
            argentSale = argentSale - qty
            MySQL.Async.execute("UPDATE gta_immo_stockage SET argent_sale=@newArgent", {['@newArgent'] = tonumber(argentSale)})
            TriggerEvent("GTA:AjoutArgentSale", source, qty)
            TriggerEvent("NUI-Notification", {"Vous avez retirer de l'argent sale dans le coffre."})
        else
            TriggerClientEvent("NUI-Notification", source, {"Montant supérieur au montant disponible.", "warning"})
        end
    end)
end)

RegisterNetEvent("GTA_Immobilier:DeposerArgentPropreStockage")
AddEventHandler("GTA_Immobilier:DeposerArgentPropreStockage", function(qty)
    local source = source

    TriggerEvent('GTA:GetInfoJoueurs', source, function(data)
        if (data.argent_propre >= qty) then 
            MySQL.Async.fetchAll('SELECT * FROM gta_immo_stockage',{}, function(res2)
                local argentPropre = res2[1].argent
                argentPropre = argentPropre + qty
                MySQL.Async.execute("UPDATE gta_immo_stockage SET argent=@newArgent", {['@newArgent'] = tonumber(argentPropre)})
                TriggerEvent('GTA:RetirerArgentPropre', source, tonumber(qty))
                TriggerEvent("NUI-Notification", {"Vous avez deposer de l'argent propre dans le coffre."})
            end)
        else
			TriggerClientEvent("GTA_NUI_ShowNotif_client", source, "Montant supérieur au montant disponible.", "warning", "fa fa-exclamation-circle fa-2x")
        end
    end)
end)


RegisterNetEvent("GTA_Immobilier:DeposerArgentSaleStockage")
AddEventHandler("GTA_Immobilier:DeposerArgentSaleStockage", function(qty)
    local source = source

    TriggerEvent('GTA:GetInfoJoueurs', source, function(data)
        if (data.argent_sale >= qty) then 
            MySQL.Async.fetchAll('SELECT * FROM gta_immo_stockage',{}, function(res2)
                local argentSale = res2[1].argent_sale
                argentSale = argentSale + qty
                MySQL.Async.execute("UPDATE gta_immo_stockage SET argent_sale=@newArgent", {['@newArgent'] = tonumber(argentSale)})
                TriggerEvent('GTA:RetirerArgentSale', source, tonumber(qty))
                TriggerEvent("NUI-Notification", {"Vous avez deposer de l'argent sale dans le coffre."})
            end)
        else
			TriggerClientEvent("GTA_NUI_ShowNotif_client", source, "Montant supérieur au montant disponible.", "warning", "fa fa-exclamation-circle fa-2x")
        end
    end)
end)


