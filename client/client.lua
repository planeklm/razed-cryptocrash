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
                event = 'razed-casino:client:crashMenu'
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
end)
end)

RegisterNetEvent('razed-casino:client:playSound', function()
    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 0.5, 'shiftyclick', 0.5)
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
                event = "razed-casino:client:chooseGame",
                item = Config.AccessItem

            },
          },
          distance = 1.5,
    })
else if Config.Target == 'ox' then
    exports.ox_target:addModel(CrashProp, {
        options = {
            {
                icon = "fa-solid fa-arrow-trend-up",
                label = "Open casino",
                event = "razed-casino:client:chooseGame",
                item = Config.AccessItem
            },
        },
        distance = 1.5,
    })
    end
  end
end)
