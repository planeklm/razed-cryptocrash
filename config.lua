Config = {}

Config.CrashProp = {
    `prop_arcade_01`
}

Config.CasinoName = 'Emerald Casino'
Config.CasinoColor = '#B993D6'

Config.Target = 'qb' -- 'qb' or 'ox' depending on the target you use

Config.MinimumWithdrawal = 1
Config.MinimumDeposit = 5

-- If one of these have been changed, you must change both to not confuse players.
Config.CryptoWithdrawalFeeShown = '10' -- This is a percentage shown the the ox_lib menu - e.g 10 = 10%
Config.CryptoWithdrawalFee = '0.90' -- This is a percentage of the fee when withdrawing the crypto - e.g 0.90 = 10%

Config.Crypto = 'qb' -- 'qb' or 'renewed-phone' depending on the crypto resource you use
Config.RenewedCryptoType = "gne" -- "gne" or "shung" or "xcoin" or "lme" - only change if using renewed phone