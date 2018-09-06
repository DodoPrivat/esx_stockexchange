ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local result = MySQL.Sync.fetchAll(
    'SELECT COUNT(*) as count FROM bourse'
)
local count  = tonumber(result[1].count)


RegisterServerEvent('bourse:vente')
AddEventHandler('bourse:vente', function (item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.fetchAll(
        'SELECT * FROM bourse WHERE item = @item LIMIT 1',
        { ['@item'] = item },
        function (result)
            local item    = result[1].item
            local stock   = result[1].stock
            local prix = result[1].prix
            local prixbase = result[1].prixbase

            if stock > 0 then

            xPlayer.addMoney(math.floor(prix))
            xPlayer.removeInventoryItem(item, 1)
                TriggerClientEvent('esx:showNotification', _source, "Vous avez gagné : $"..(math.floor(prix)))
            else
                TriggerClientEvent('esx:showNotification', _source, "On a plus besoin de cargaison.")
            end

            MySQL.Async.execute("UPDATE bourse SET stock = stock - @a WHERE `item` = @item", {['@item'] = item, ['@a'] = count}) 
            MySQL.Async.execute("UPDATE bourse SET stock = stock + @a ", {['@a'] = 1})
            local nouveaumontant = ( stock / 20000 * prixbase )
            MySQL.Async.execute("UPDATE bourse SET prix =  @a WHERE `item` = @item", {['@item'] = item, ['@a'] = nouveaumontant}) 
        end
    )

end)
