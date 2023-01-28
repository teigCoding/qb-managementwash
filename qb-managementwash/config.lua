local QBCore = exports['qb-core']:GetCoreObject()

Config = {}


--How much should the user lose in fees
Config.Options = {
    0.25, --option1
    0.1, --option2
    0, --option3
}

--in seconds
Config.TimeWait = {
    0,--option1
    86400,--option2
    172800,--option3
}