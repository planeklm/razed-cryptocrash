local QBCore = exports['qb-core']:GetCoreObject()
local BetAmount = 0.0

RegisterNetEvent('razed-casino:server:crashBet', function(id1)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local row = MySQL.single.await('SELECT `casinobalance` FROM `players` WHERE `citizenid` = ?', {
        Player.PlayerData.citizenid
    })

    if id1 < row.casinobalance + 0.10 then
        TriggerClientEvent("ox_lib:notify", src, {
            title = 'Successfull Bet!',
            description = 'You have successfully bet '..id1..' coins! Good luck!',
            duration = 2500,
            type = 'success'
        })
        BetAmount = id1
        local id = MySQL.update.await('UPDATE players SET casinobalance = ? WHERE citizenid = ?', {
            row.casinobalance - id1, Player.PlayerData.citizenid
        })
    else if id1 > row.casinobalance + 0.10 then
        TriggerClientEvent("ox_lib:notify", src, {
            title = 'Bet Failed!',
            description = 'You have do not have enough funds in you wallet. Please deposit more.',
            duration = 2500,
            type = 'error'
        })
    end

    QBCore.Functions.CreateCallback('razed-casino:server:showCrashBet', function(source, cb)
        local src = source
        local crashBetAmount = BetAmount
    
        cb(crashBetAmount)
    end)
end
end)

RegisterNetEvent('razed-casino:server:startCrashGame', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local mathrandom = math.random(1000, 5000)
    local row = MySQL.single.await('SELECT `casinobalance` FROM `players` WHERE `citizenid` = ?', {
        Player.PlayerData.citizenid
    })
    Gamenotstarted = true
    Multiplier = 1.0

    QBCore.Functions.CreateCallback('razed-casino:server:checkGameStarted', function(source, cb)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local notstarted = Gamenotstarted
    
        cb(notstarted)
    end)

    QBCore.Functions.CreateCallback('razed-casino:server:checkBet', function(source, cb)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local notstarted = Gamenotstarted
    
        cb(notstarted)
    end)

    QBCore.Functions.CreateCallback('razed-casino:server:checkMultiplier', function(source, cb)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local crashmultiplier = Multiplier

        cb(crashmultiplier)
    end)

    if row.casinobalance < Config.CrashBetMinimum then
        TriggerClientEvent("ox_lib:notify", src, {
            title = 'Insuffient Funds To Play',
            description = 'You need to have more than '..Config.CrashBetMinimum..' coins in your casino wallet.',
            duration = 3000,
            type = 'error'
        })
    else if row.casinobalance > Config.CrashBetMinimum then
        TriggerClientEvent("ox_lib:notify", src, {
            title = 'Waiting for game...',
            description = 'Please wait while we get you into a game.',
            duration = mathrandom,
            type = 'info'
        })

    Wait(mathrandom)

    TriggerClientEvent("ox_lib:notify", src, {
        title = 'You joined a game.',
        duration = 1000,
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

    TriggerClientEvent('razed-casino:client:crashGame', src)

    Wait(1000)

    while not Gamenotstarted do
        Wait(1000)
        if math.random(Config.CrashChanceFrom, Config.CrashChanceTo) == math.random(Config.CrashChanceFrom, Config.CrashChanceTo) then
            TriggerClientEvent("ox_lib:notify", src, {
                title = 'Rocket Crashed!',
                description = 'Ah damn, you lost!',
                duration = 5000,
                type = 'error'
            })
            Gamenotstarted = true
            TriggerClientEvent('razed-casino:client:chooseGame', src)
            Multiplier = 1.0
            break
        else
        Multiplier = Multiplier + math.random(1, 5) / 10
        TriggerClientEvent('razed-casino:client:crashGame', src)
        TriggerClientEvent('razed-casino:client:playSound', src)
        Wait(1000)
    end
end
end
end
end)

RegisterNetEvent('razed-casino:server:crashCashout', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local amount = BetAmount * Multiplier
    local row = MySQL.single.await('SELECT `casinobalance` FROM `players` WHERE `citizenid` = ?', {
        Player.PlayerData.citizenid
    })

    if Gamenotstarted == false then
        TriggerClientEvent('razed-casino:client:crashGame', src)
        Gamenotstarted = true
        row.casinobalance = row.casinobalance + amount
        print(Multiplier)
        Wait(500)
        local id = MySQL.update.await('UPDATE players SET casinobalance = ? WHERE citizenid = ?', {
            row.casinobalance, Player.PlayerData.citizenid
        })
        TriggerClientEvent("ox_lib:notify", src, {
            title = 'Successfull Cashout!',
            description = 'You have successfully cashed out '..amount..' coins with a multiplier of '..Multiplier..'x.',
            duration = 5000,
            type = 'success'
        })
    else
        TriggerClientEvent("ox_lib:notify", src, {
            title = 'Cashout Failed!',
            description = 'You cannot cashout when you lost!',
            duration = 2500,
            type = 'error'
        })
    end
end)