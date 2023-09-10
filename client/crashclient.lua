local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('razed-casino:client:crashMenu', function()
QBCore.Functions.TriggerCallback('razed-casino:server:showCasinoBalance', function(casinobalance)
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
            description = 'Quickly join a crash game with our hyper engine technology, only at '..Config.CasinoName..'.',
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

lib.showContext('crashmenu')
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
        {type = 'number', label = 'Bet Amount', description = 'The amount of coins to bet. Minimum: '..Config.CrashBetMinimum..' coins to bet.', default = 1, min = Config.CrashBetMinimum, required = true, icon = 'fa-brands fa-bitcoin'}
    })
    if not input then
        TriggerEvent('razed-casino:client:crashGame')
    else
        TriggerServerEvent("razed-casino:server:crashBet", input[1])
        TriggerEvent('razed-casino:client:crashGame')
    end
end)