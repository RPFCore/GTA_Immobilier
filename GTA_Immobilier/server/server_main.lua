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
			TriggerClientEvent('nMenuNotif:showNotification', source, "~r~Tu n'as pas suffisamment d'argent !")
		end
	end)
end)