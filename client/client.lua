local QBCore = exports['qb-core']:GetCoreObject()
local CrashProp = Config.CrashProp

RegisterNetEvent('razed-casino:client:chooseGame', function()
    QBCore.Functions.TriggerCallback('razed-casino:server:showCasinoBalance', function(casinobalance)
    lib.registerContext({
        id = 'choosegame',
        title = Config.CasinoName,
        options = {
            {
                title = 'Casino Balance: '..casinobalance,
                icon = 'fa-brands fa-bitcoin',
                iconColor = Config.CasinoColor
            },
            {
                title = 'Crash',
                description = 'Like playing the stock market, the objective of crash is to buy low and sell high. Its all a game of luck!',
                icon = 'fa-solid fa-arrow-trend-up',
                arrow = true,
                iconColor = Config.CasinoColor,
                menu = 'crashmenu'
            },
            {
                title = 'Deposit Crypto',
                description = 'Deposit your crypto.',
                icon = 'money-bill-transfer',
                iconColor = Config.CasinoColor,
                event = 'razed-casino:client:depositCrypto'
            },
            {
                title = 'Withdraw Crypto',
                description = 'Withdraw your crypto: '..Config.CryptoWithdrawalFeeShown.. '% Fee. Minimum withdrawal is '..Config.MinimumWithdrawal..' coins.',
                icon = 'dollar-sign',
                iconColor = Config.CasinoColor,
                serverEvent = 'razed-casino:server:withdrawcrypto'
            }
      }}
    )

    lib.showContext('choosegame')

    TriggerEvent('razed-casino:client:casinoNotif')

    lib.registerContext({
        id = 'crashmenu',
        title = Config.CasinoName..' - Crash',
        options = {
            {
                title = 'Casino Balance: '..casinobalance,
                icon = 'fa-brands fa-bitcoin',
                iconColor = Config.CasinoColor
            },
            {
                title = 'Join a game',
                description = 'Quickly join a crash game with our hyper engine, only at '..Config.CasinoName..'.',
                icon = 'rocket',
                serverEvent = 'razed-casino:server:startCrashGame',
                iconColor = Config.CasinoColor
            },
            {
                title = 'Go back',
                icon = 'arrow-left',
                iconColor = Config.CasinoColor,
                event = 'razed-casino:client:chooseGame'
            }
      }}
    )
end)
end)

RegisterNetEvent('razed-casino:client:crashGame', function()
    QBCore.Functions.TriggerCallback('razed-casino:server:checkGameStarted', function(started)
    QBCore.Functions.TriggerCallback('razed-casino:server:checkMultiplier', function(crashmultiplier)
    lib.registerContext({
        id = 'crashgame',
        title = 'In Game - Crash',
        options = {
            {
                title = 'Multiplier: '..crashmultiplier..'x',
                icon = 'fa-brands fa-bitcoin',
                description = 'Shows the current multiplier for your crypto.',
                iconColor = Config.CasinoColor
            },
            {
                title = 'Bet',
                description = 'Choose the amount from your balance you want to bet.',
                icon = 'money-bill-wave',
                iconColor = Config.CasinoColor,
                event = 'razed-casino:client:betCrashCrypto'
            },
            {
                title = 'Cashout',
                description = 'Cashout your current multiplier.',
                icon = 'rocket',
                disabled = started,
                iconColor = Config.CasinoColor,
                serverEvent = 'razed-casino:server:crashCashout'
            },
            {
                title = 'Leave',
                icon = 'arrow-left',
                iconColor = Config.CasinoColor,
                event = 'razed-casino:client:chooseGame'
            }
      }}
    )
    lib.showContext('crashgame')
end)
end)
end)

RegisterNetEvent('razed-casino:client:betCrashCrypto', function()
    local input = lib.inputDialog('Bet Your Balance', {
        {type = 'number', label = 'Bet Amount', description = 'The amount of coins to bet. Minimum: '..Config.CrashBetMinimum..' coins to bet.', default = Config.CrashBetMinimum, min = Config.CrashBetMinimum, required = true, icon = 'fa-brands fa-bitcoin'}
    })
    if not input then
        TriggerEvent('razed-casino:client:crashGame')
    else
        TriggerServerEvent("razed-casino:server:crashBet", input[1])
        TriggerEvent('razed-casino:client:crashGame')
    end
end)

RegisterNetEvent('razed-casino:client:depositCrypto', function()
    local input = lib.inputDialog('Deposit Crypto', {
        {type = 'number', label = 'Crypto Amount', description = 'The amount of coins to deposit. Minimum: '..Config.MinimumDeposit..' coins to deposit.', default = Config.MinimumDeposit, min = Config.MinimumDeposit, required = true, icon = 'fa-brands fa-bitcoin'}
    })
    if not input then return end
        TriggerServerEvent("razed-casino:server:addCrypto", input[1])
end)

RegisterNetEvent('razed-casino:client:casinoNotif', function()
    lib.showTextUI('Welcome to '..Config.CasinoName..'!', {
        position = "top-center",
        icon = 'dice',
        style = {
            borderRadius = 3,
            backgroundColor = Config.CasinoColor,
            color = 'white'
        }
    })

    Wait(5000)

    lib.hideTextUI()
end)

CreateThread(function()
    if Config.Target == 'qb' then
    exports['qb-target']:AddTargetModel(CrashProp, {
        options = {
            { 
                icon = "fa-solid fa-arrow-trend-up",
                label = "Open Casino",
                event = "razed-casino:client:chooseGame"
            },
          },
          distance = 3.0,
    })
else if Config.Target == 'ox' then
    exports.ox_target:addModel(CrashProp, {
        options = {
            {
                icon = "fa-solid fa-arrow-trend-up",
                label = "Open casino",
                event = "razed-casino:client:chooseGame"
            },
        },
        distance = 3.0,
    })
    end
  end
end)
