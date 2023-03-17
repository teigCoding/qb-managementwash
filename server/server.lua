local QBCore = exports['qb-core']:GetCoreObject()


RegisterNetEvent('brp-vasking:server:startVask', function(percent)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid
    local currentTime = os.time()
    local howlong
    local worth = 0
    local amount = 0

    if not Player.PlayerData.job.isboss then
        return
    end

    for slot, data in pairs(Player.PlayerData.items) do
        if data ~= nil then
            if data.name == 'markedbills' then
                worth = worth + (data.info.worth * data.amount)
                amount = amount + data.amount
                Player.Functions.RemoveItem('markedbills', data.amount)
            end
        end
    end

    if worth > 0 and amount > 0 then
        worth = worth * (1-percent)
        TriggerClientEvent('QBCore:Notify', src, Lang:t("success.started_wash")..worth..Lang:t("success.wash_start"), "success")

        if percent == Config.Options[1] then
            howlong = Config.TimeWait[1]
        elseif percent == Config.Options[2] then
            howlong = Config.TimeWait[2]
        elseif percent == Config.Options[3] then
            howlong = Config.TimeWait[3]
        end

        MySQL.Async.insert('INSERT INTO wash_database (citizenid, amount, time, howlong) VALUES (?, ?, ?, ?)', {
            citizenid,
            worth,
            currentTime,
            howlong,
        })
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.not_enough"), "error")
    end

end)

RegisterNetEvent("brp-vasking:server:hentPenger", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid
    local currentTime = os.time()
    MySQL.query('SELECT * FROM wash_database WHERE citizenid = ?', {citizenid}, function(result)
        if result ~= nil and result[1] ~= nil then
            local timeDiff = currentTime - result[1].time
            local howLong = result[1].howlong

            TriggerClientEvent("brp-vasking:client:showDisplay",src,result,timeDiff)
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t("error.not_started"), "error")
        end
    end)

end)

RegisterNetEvent("brp-vasking:server:fullforVask",function(args)
    local src = source
    local result = args.result
    local number = args.number
    local Player = QBCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid
    local currentTime = os.time()
    local timeDiff = currentTime - result[number].time
    local howLong = result[number].howlong

    if not Player.PlayerData.job.isboss then
        return
    end

    if timeDiff >= howLong then
        TriggerClientEvent('QBCore:Notify', src, Lang:t("success.wash") ..result[number].amount.. "!", "success")
        MySQL.query('SELECT * FROM wash_database WHERE citizenid = ?', {citizenid}, function(result)
            if result ~= nil and result[1] ~= nil then
                local idToDelete = result[number].ID
                MySQL.Async.execute("DELETE FROM wash_database WHERE id = @id", { ['@id'] = idToDelete }, function()
                    Player.Functions.AddMoney("cash", result[number].amount, "Washed cash")

                end)
            end
        end)

        -- MySQL.Async.execute("DELETE FROM wash_database WHERE citizenid = @citizenid", { ['@citizenid'] = citizenid }, function()
        --     Player.Functions.AddMoney("cash", result[number].amount, "Vasket penger")
        -- end)
    else
        local total_seconds = howLong - timeDiff
        local hours = math.floor(total_seconds / 3600)
        local minutes = math.floor((total_seconds % 3600) / 60)
        local seconds = total_seconds % 60
        local output = ""
        if hours ~= 0 then
          output = hours .. Lang:t("label.hours")
        end
        if minutes ~= 0 then
          output = output .. minutes ..Lang:t("label.minutes")
        end
        if seconds ~= 0 then
          output = output .. seconds .. Lang:t("label.seconds")
        end                
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.cannot_collect")..result[number].amount.."!".. Lang:t("error.have_to_wait") .. output, "error")
    end
end)