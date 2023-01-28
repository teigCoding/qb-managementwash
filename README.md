Video Preview: https://youtu.be/G00KYyNhuFQ

Discord Support: https://discord.gg/mAFcFpamZ9

# required scripts:
qb-management

# add this to (qb-management > client > cl_boss.lua)

                {
                    header = Lang:t("body.wash"),
                    icon = "fa-solid fa-money-bill-transfer",
                    txt = Lang:t("body.washed"),
                    params = {
                        event = "brp-vasking:client:startVask",
                        args = comma_value(cb)
                    }
                },
                {
                    header = "Collect money",
                    icon = "fa-solid fa-money-bill-transfer",
                    txt = "Collect money from wash",
                    params = {
                        event = "brp-vasking:client:hentPenger",
                        args = comma_value(cb)
                    }
                },
                
                
# It should be placed under this in qb-management (you can freely choose order):

RegisterNetEvent('qb-bossmenu:client:SocietyMenu', function()
    QBCore.Functions.TriggerCallback('qb-bossmenu:server:GetAccount', function(cb)
        local SocietyMenu = {
            {
                header = Lang:t("body.balance").. comma_value(cb) .. " - " .. string.upper(PlayerJob.label),
                isMenuHeader = true,
                icon = "fa-solid fa-circle-info",
            },


