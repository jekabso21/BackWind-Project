RedEM = exports["redem_roleplay"]:RedEM()
local ResetStress = false
RegisterCommand('cash', function(source, args)
    local src = source
    local Player = RedEM.GetPlayer(src)
    cashAmount = Player.money['cash']
    TriggerClientEvent('hud:client:ShowAccounts', source, 'cash', cashamount)
end)

RegisterCommand('bank', function(source, args)
    local src = source
    local Player = RedEM.GetPlayer(src)
    bankAmount = Player.money['bank']
    TriggerClientEvent('hud:client:ShowAccounts', source, 'bank', bankAmount)
end)

RegisterCommand("dev", function(source, args)
    local src = source
    local Player = RedEM.GetPlayer(src)
    if Player.group == "dev" or "superadmin" then
        print("User: " .. source .. " Toggled Devmode!")

        setadmin(source, true)
    end
end)

RegisterNetEvent('hud:server:GainStress', function(amount)
    local _source = source
    local Player = RedEM.GetPlayer(_source)
    local newStress
    --if not Player or (Config.DisablePoliceStress and Player.PlayerData.job.name == 'police') then return end
    if not ResetStress then
        local stress = Player.GetMetaData().stress
        print("Stress: " .. stress .. " Amount: " .. amount)
        newStress = stress + amount
        if newStress <= 0 then newStress = 0 end
    else
        newStress = 0
    end
    if newStress > 100 then
        newStress = 100
    end
    print("New Stress: " .. newStress)
    Player.SetMetaData("stress", newStress)
    print("WTF?")
    TriggerClientEvent('hud:client:UpdateStress', _source, newStress)
    print("User: " .. _source .. " Feeling More Stressed!")
end)

RegisterNetEvent('hud:server:RelieveStress', function(amount)
    local _source = source
    local Player = RedEM.GetPlayer(_source)
    local newStress
    if not Player then return end
    if not ResetStress then
        --if not Player.PlayerData.metadata['stress'] then
        --    Player.PlayerData.metadata['stress'] = 0
        --end
        local stress = Player.GetMetaData().stress
        newStress = stress + amount
        if newStress <= 0 then newStress = 0 end
    else
        newStress = 0
    end
    if newStress > 100 then
        newStress = 100
    end
    Player.SetMetaData("stress", newStress)
    TriggerClientEvent('hud:client:UpdateStress', src, newStress)
    print("User: " .. source .. " Feeling More Relaxed!")
end)

RegisterNetEvent('hud:server:saveUIData', function(data)
    local src = source
	-- Check Permissions
    local Player = RedEM.GetPlayer(src)
    if not Player.group == "dev" or "superadmin" then
		return
	end

    -- Ensure a player is invoking this net event
    local Player = RedEM.GetPlayer(src)
	if not Player then return end

    local uiConfigData = {}
    uiConfigData.icons = {}

    local path = GetResourcePath(GetCurrentResourceName())
    path = path:gsub('//', '/')..'/uiconfig.lua'
    local file = io.open(path, 'w+')

    local heading = "UIConfig = {}\n"
    file:write(heading)

    -- write out icons
    file:write("\nUIConfig.icons = {}\n")
    
    -- Sort the icons so its easier to find in the config file
    local iconKeys = {}
    for k, _ in pairs(data.icons) do
        table.insert(iconKeys, k)
    end
    table.sort(iconKeys)

    for _, iconName in ipairs(iconKeys) do
        uiConfigData.icons[iconName] = {}

        local iconLabel = "\nUIConfig.icons['"..iconName.."'] = {"
        file:write(iconLabel)

        -- sort the values as well inside icons
        local iconValues = {}
        for k, _ in pairs(data.icons[iconName]) do
            table.insert(iconValues, k)
        end
        table.sort(iconValues)

        for _, iconValueName in ipairs(iconValues) do
            local str
            local v = data.icons[iconName][iconValueName]
            uiConfigData.icons[iconName][iconValueName] = v
            if type(v) == "string" then
                str = ("\n    %s = '%s',"):format(iconValueName, v)
            else
                str = ("\n    %s = %s,"):format(iconValueName, v)
            end
            file:write(str)
        end
        file:write("\n}\n")
    end


    --local layoutLabel = "\nUIConfig.layout = '"..data.layout.."'\n"
    local layoutLabel = "\nUIConfig.layout = {"
    file:write(layoutLabel)
    for layoutName, layoutVal in pairs(data.layout) do
        local str
        if type(layoutVal) == "string" then
            str = ("\n    %s = '%s',"):format(layoutName, layoutVal)
        else
            str = ("\n    %s = %s,"):format(layoutName, layoutVal)
        end
        file:write(str)
    end
    file:write("\n}\n")
    uiConfigData.layout = data.layout


    -- write out color icons info
    file:write("\nUIConfig.colors = {}\n")
    uiConfigData.colors = {}

    -- Sort the color keys
    local colorKeys = {}
    for k, _ in pairs(data.colors) do
        table.insert(colorKeys, k)
    end
    table.sort(colorKeys)

    for _, colorName in ipairs(colorKeys) do
        uiConfigData.colors[colorName] = {}
        uiConfigData.colors[colorName].colorEffects = {}

        local colorLabel = "\nUIConfig.colors['"..colorName.."'] = {"
        file:write(colorLabel)

        local colorEffectsLabel = "\n    colorEffects = {"
        file:write(colorEffectsLabel)

        for k, v in ipairs(data.colors[colorName].colorEffects) do
            local colorEffectIndexLabel = "\n        ["..k.."] = {"
            file:write(colorEffectIndexLabel)

            -- sort the values as well inside color effects
            local colorEffect = data.colors[colorName].colorEffects[k]
            local colorEffectkeys = {}
            for scekey, _ in pairs(colorEffect) do
                table.insert(colorEffectkeys, scekey)
            end
            table.sort(colorEffectkeys)

            table.insert(uiConfigData.colors[colorName].colorEffects, colorEffect)

            for _, CEKey in ipairs(colorEffectkeys) do
                local str
                if type(colorEffect[CEKey]) == "string" then
                    str = ("\n            %s = '%s',"):format(CEKey, colorEffect[CEKey])
                else
                    str = ("\n            %s = %s,"):format(CEKey, colorEffect[CEKey])
                end
                file:write(str)
            end
            file:write("\n        },")
        end
        file:write("\n    },")
        file:write("\n}\n")
    end

    file:close()

    UIConfig = uiConfigData

    -- -1 to send to all players
    TriggerClientEvent('hud:client:UpdateUISettings', -1, uiConfigData)
end)

lib.callback.register('hud:server:getMenu', function(source)
    return Config.Menu
end)


lib.callback.register('hud:server:isadmin', function(source)
    local src = source
    local Player = RedEM.GetPlayer(src)
    if Player.group == "dev" or "superadmin" then
        return true
    else
        return false
    end
end)

function setadmin(source)
    local src = source
    local Player = RedEM.GetPlayer(src)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000)
            if Player.group == "dev" or "superadmin" then
                Player.SetMetaData("stress", 0)
                Player.SetMetaData("hunger", 100)
                Player.SetMetaData("thirst", 100)
            end
            print("User: " .. source .. " Feeling More Relaxed!")
        end
    end)
end

RegisterServerEvent('hud:server:updatestats')
AddEventHandler('hud:server:updatestats', function(source)
    print(source)
    local Player = RedEM.GetPlayer(source)
    TriggerClientEvent('hud:client:UpdateNeeds', source,  Player.metadata.hunger, Player.metadata.thirst)
end)

lib.callback.register('hud:server:getstats', function(source)
    local src = source
    local Player = RedEM.GetPlayer(src)
    return Player.GetMetaData("stress"), Player.metadata.thirst, Player.metadata.hunger
end)
