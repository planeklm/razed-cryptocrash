local QBCore = exports['qb-core']:GetCoreObject()
local BetAmount = 0.0

RegisterNetEvent('razed-casino:server:withdrawcrypto', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local row = MySQL.single.await('SELECT `casinobalance` FROM `players` WHERE `citizenid` = ?', {
        Player.PlayerData.citizenid
    })
    local notif1 = {
        title = 'Withdrawal Failed',
        description = 'You have insuffient withdrawal funds.',
        duration = '500',
        type = 'error'
    }
    local notif2 = {
        title = 'Withdrawal Successfull',
        description = 'The funds have been successfully withdrew! '..math.floor(row.casinobalance * Config.CryptoWithdrawalFee+0.5)..' coins withdrew, with a '..Config.CryptoWithdrawalFeeShown..'% fee.',
        duration = '500',
        type = 'success'
    }

if Config.Crypto == 'qb' then
    if row.casinobalance > Config.MinimumWithdrawal then
    local id = MySQL.update.await('UPDATE players SET casinobalance = ? WHERE citizenid = ?', {
        0, Player.PlayerData.citizenid
    })
    Player.Functions.AddMoney('crypto', math.floor(row.casinobalance * Config.CryptoWithdrawalFee+0.5))
    row.casinobalance = row.casinobalance - row.casinobalance
    TriggerClientEvent("ox_lib:notify", src, notif2)
    else if row.casinobalance < Config.MinimumWithdrawal then
        TriggerClientEvent("ox_lib:notify", src, notif1)
    else
    TriggerClientEvent("ox_lib:notify", src, notif1)
    end
end
else if Config.Crypto == 'renewed-phone' then
    if row.casinobalance > Config.MinimumWithdrawal then 
        exports['qb-phone']:AddCrypto(src, Config.RenewedCryptoType, row.casinobalance * Config.CryptoWithdrawalFee)
        row.casinobalance = row.casinobalance - row.casinobalance
        local id = MySQL.update.await('UPDATE players SET casinobalance = ? WHERE citizenid = ?', {
            0, Player.PlayerData.citizenid
        })        TriggerClientEvent("ox_lib:notify", src, notif2)
        else if row.casinobalance < Config.MinimumWithdrawal then
            TriggerClientEvent("ox_lib:notify", src, notif1)
        else
        TriggerClientEvent("ox_lib:notify", src, notif1)
        end
    end
  end
 end
end)

RegisterNetEvent('razed-casino:server:addCrypto', function(id1)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local PlayerBalance = Player.Functions.GetMoney('crypto')
    local row = MySQL.single.await('SELECT `casinobalance` FROM `players` WHERE `citizenid` = ?', {
        Player.PlayerData.citizenid
    })
    local notif1 = {
        title = 'Deposit Failed',
        description = 'You cannot deposit less than '..Config.MinimumDeposit..' coins!',
        duration = '500',
        type = 'error'
    }
    local notif2 = {
        title = 'Deposit Failed',
        description = 'You do not have enough coins to deposit!',
        duration = '500',
        type = 'error'
    }
    local notif3 = {
        title = 'Deposit Successfull',
        description = id1..' coins successfully added to your casino wallet!',
        duration = '500',
        type = 'success'
    }
    
    if id1 > 5 then
        if PlayerBalance > id1 then
        Player.Functions.RemoveMoney('crypto', id1)
        row.casinobalance = row.casinobalance + id1
        local id = MySQL.update.await('UPDATE players SET casinobalance = ? WHERE citizenid = ?', {
            row.casinobalance, Player.PlayerData.citizenid
        })
        TriggerClientEvent("ox_lib:notify", src, notif3)
        else if PlayerBalance < id1 then
            TriggerClientEvent("ox_lib:notify", src, notif2)
    else
        TriggerClientEvent("ox_lib:notify", src, notif1)
    end
end
end
end)

QBCore.Functions.CreateCallback('razed-casino:server:showCasinoBalance', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local PlayerCitizenID = Player.PlayerData.citizenid
    local row = MySQL.single.await('SELECT `casinobalance` FROM `players` WHERE `citizenid` = ?', {
        Player.PlayerData.citizenid
    })    
    local casinobalance = row.casinobalance

    cb(casinobalance)
end)
