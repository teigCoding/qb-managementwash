local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("brp-vasking:client:showDisplay", function(result,timeDiff)

    Citizen.CreateThread(function ()
        local theMenu = {}
        theMenu[#theMenu+1] =
            {
                header = Lang:t("label.header"),
                isMenuHeader = true
            }
            for i=1,#result do
                local timeDiff = timeDiff
                local howLong = result[i].howlong
                local total_seconds = howLong - timeDiff
                local hours = math.floor(total_seconds / 3600)
                local minutes = math.floor((total_seconds % 3600) / 60)
                local seconds = total_seconds % 60
                local output = ""
                if hours >= 0 and minutes >= 0 and seconds >= 0 then
                    if hours ~= 0 then
                    output = hours .. Lang:t("label.hours")
                    end
                    if minutes ~= 0 then
                    output = output .. minutes .. Lang:t("label.minutes")
                    end
                    if seconds ~= 0 then
                    output = output .. seconds .. Lang:t("label.seconds")
                    end
                else
                    output = Lang:t("label.ready")
                end
                theMenu[#theMenu+1] =                
                {
                    header = "$"..result[i].amount,
                    txt = output,
                    params = {
                        isServer = false,
                        event = "brp-vasking:client:fullforVask",
                        args = {
                            number = i,
                            result = result,
                        }
                    }}
            end
            theMenu[#theMenu+1] = 
                {
                    header = Lang:t("label.quit"),
                    params = {
                        isServer = false,
                        event = "",

                    }}

                
                exports['qb-menu']:openMenu(theMenu) 
        end)

end)

RegisterNetEvent("brp-vasking:client:fullforVask",function(args)
    TriggerServerEvent("brp-vasking:server:fullforVask",args)
end)

RegisterNetEvent("brp-vasking:client:startVask",function()
    
    local dialog = exports['qb-input']:ShowInput({
        header = Lang:t("label.header"),
        submitText = Lang:t("label.send"),
        inputs = {
            {
                text = Lang:t("label.method"), -- text you want to be displayed as a input header
                name = "vaskemetode", -- name of the input should be unique otherwise it might override
                type = "radio", -- type of the input - Radio is useful for "or" options e.g; billtype = Cash OR Bill OR bank
                options = { -- The options (in this case for a radio) you want displayed, more than 6 is not recommended
                    { value = Config.Options[1], text = Lang:t("label.option1"),checked = true}, -- Options MUST include a value and a text option
                    { value = Config.Options[2], text = Lang:t("label.option2") }, -- Options MUST include a value and a text option
                    { value = Config.Options[3], text = Lang:t("label.option3") }  -- Options MUST include a value and a text option
                },
                -- default = "cash", -- Default radio option, must match a value from above, this is optional
            },
        }
    })

    if tonumber(dialog['vaskemetode']) then
        TriggerServerEvent('brp-vasking:server:startVask',tonumber(dialog['vaskemetode']))
    else
        QBCore.Functions.Notify(Lang:t("error.not_value"), "error")
    end
   

end)

RegisterNetEvent("brp-vasking:client:hentPenger",function()
    TriggerServerEvent('brp-vasking:server:hentPenger')
end)