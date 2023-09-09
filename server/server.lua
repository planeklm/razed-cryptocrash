local QBCore = exports['qb-core']:GetCoreObject()

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

RegisterNetEvent('razed-casino:server:startCrashGame', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Gamenotstarted = true
    local mathrandom = 1000
    local multiplier = 0.0

    QBCore.Functions.CreateCallback('razed-casino:server:checkGameStarted', function(source, cb)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local notstarted = Gamenotstarted
    
        cb(notstarted)
    end)

    QBCore.Functions.CreateCallback('razed-casino:server:checkMultiplier', function(source, cb)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local crashmultiplier = multiplier
    
        cb(crashmultiplier)
    end)

    TriggerClientEvent("ox_lib:notify", src, {
        title = 'Waiting for game...',
        description = 'Please wait while we get you into a game.',
        duration = mathrandom,
        type = 'info'
    })

    Wait(mathrandom)

    TriggerClientEvent("ox_lib:notify", src, {
        title = 'You joined a game.',
        duration = '300',
        type = 'success'
    })

    TriggerClientEvent('razed-casino:client:crashGame', src)

    Wait(1000)

    TriggerClientEvent("ox_lib:notify", src, {
        title = 'Game will start in 30 seconds.',
        description = 'Please place your bets now.',
        duration = 10000,
        type = 'info'
    })

    Wait(10000)

    TriggerClientEvent("ox_lib:notify", src, {
        title = 'Game will start in 20 seconds.',
        description = 'Please place your bets now.',
        duration = 10000,
        type = 'info'
    })

    Wait(10000)

    TriggerClientEvent("ox_lib:notify", src, {
        title = 'Game will start in 10 seconds.',
        description = 'Please place your bets now.',
        duration = 1000,
        type = 'info'
    })

    Wait(1000)

    TriggerClientEvent("ox_lib:notify", src, {
        title = 'Game will start in 9 seconds.',
        description = 'Please place your bets now.',
        duration = 1000,
        type = 'info'
    })

    Wait(1000)

    TriggerClientEvent("ox_lib:notify", src, {
        title = 'Game will start in 8 seconds.',
        description = 'Please place your bets now.',
        duration = 1000,
        type = 'info'
    })

    Wait(1000)

    TriggerClientEvent("ox_lib:notify", src, {
        title = 'Game will start in 7 seconds.',
        description = 'Please place your bets now.',
        duration = 1000,
        type = 'info'
    })

    Wait(1000)

    TriggerClientEvent("ox_lib:notify", src, {
        title = 'Game will start in 6 seconds.',
        description = 'Please place your bets now.',
        duration = 1000,
        type = 'info'
    })

    Wait(1000)

    TriggerClientEvent("ox_lib:notify", src, {
        title = 'Game will start in 5 seconds.',
        description = 'Please place your bets now.',
        duration = 1000,
        type = 'info'
    })

    Wait(1000)

    TriggerClientEvent("ox_lib:notify", src, {
        title = 'Game will start in 4 seconds.',
        description = 'Please place your bets now.',
        duration = 1000,
        type = 'info'
    })

    Wait(1000)

    TriggerClientEvent("ox_lib:notify", src, {
        title = 'Game will start in 3 seconds.',
        description = 'Please place your bets now.',
        duration = 1000,
        type = 'info'
    })

    Wait(1000)

    TriggerClientEvent("ox_lib:notify", src, {
        title = 'Game will start in 2 seconds.',
        description = 'Please place your bets now.',
        duration = 1000,
        type = 'info'
    })

    Wait(1000)

    TriggerClientEvent("ox_lib:notify", src, {
        title = 'Game will start in 1 seconds.',
        description = 'Please place your bets now.',
        duration = 1000,
        type = 'info'
    })

    Wait(1000)

    Gamenotstarted = false

    while Gamenotstarted == false do
        Wait(100)

    end
end)

RegisterNetEvent('razed-casino:server:crashCashout', function()
    Gamenotstarted = true

    
end)
