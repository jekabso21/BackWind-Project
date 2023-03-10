local pedstable = {}
local CMenu = {}
local target = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        local player = PlayerPedId()
        local playerCoords = GetEntityCoords(player)
        for k,v in pairs(Config.models.Peds) do
            local distance = #(playerCoords - v.coords)
            if distance <= 25 then
                local found = false
                for _, c in pairs(pedstable) do
                    if c.name == v.name then
                        found = true
                        break
                    end
                end
                if not found then
                    if not DoesEntityExist(v.ped) then
                        RequestModel(v.model)
                        while not HasModelLoaded(v.model) do
                            Citizen.Wait(0)
                        end
                        Ped = CreatePed(v.model, v.coords, v.heading, false, false)
                        print(Ped)
                        Citizen.InvokeNative(0x283978A15512B2FE, Ped, true)
                        SetEntityHeading(Ped, v.heading)
                        SetEntityAsMissionEntity(Ped, true, true)
                        --set animation from config
                        if v.anim ~= nil then
                            if v.anim_dict ~= nil then
                                RequestAnimDict(v.anim_dict)
                                while not HasAnimDictLoaded(v.anim_dict) do
                                    Citizen.Wait(0)
                                end
                                print(v.anim_dict, v.anim)
                                TaskPlayAnim(Ped, v.anim_dict, v.anim, 8.0, -8.0, -1, 31, 0, true, 0, false, 0, false)
                            else
                                TaskStartScenarioInPlace(Ped, v.anim, 0, true)
                            end
                        end
                        table.insert(pedstable, {name = v.name, ped = Ped})
                        print(dump(pedstable))
                    end
                end
            elseif distance >= 25 then
                for i, ped in pairs(pedstable) do
                    if ped.name == v.name then
                        if DoesEntityExist(ped.ped) then
                            DeleteEntity(ped.ped)
                            table.remove(pedstable, i)
                        end
                    end
                end
            end
        end
    end
end)

local CMenu = {}

TriggerEvent('CMenu:Get', function (_menu)
    CMenu = _menu
end)

AddEventHandler('mouse-selection:CanInteract', function(entity, callback)
    local _model = GetEntityModel(entity)
    for _, ped in pairs(Config.models.Peds) do
        for i, v in pairs(pedstable) do
            if ped.name == v.name then
                target = entity
                if v.ped == entity then
                    callback(true)
                    return
                end
            end
        end
    end
end)

AddEventHandler("mouse-selection:ClickEntity", function(_entityHover)
    for _, ped in pairs(Config.models.Peds) do
        for i, v in pairs(pedstable) do
            if v.ped == target then
                if ped.name == v.name then
                    for _, target in ipairs(ped.targets) do
                        print(target.label, target.event)
                        CMenu.AddItem({
                            title= target.label,
                            id=ped.name,
                            callback=target.event
                        })
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('bw-peds:client:target')
AddEventHandler('bw-peds:client:target', function()
    TriggerEvent('bw-peds:client:targetreset')
    print("Hello from target")
end)

RegisterNetEvent('bw-peds:client:targetreset')
AddEventHandler('bw-peds:client:targetreset', function()
    target = 0
    print("Hello from targetreset")
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for _, ped in pairs(pedstable) do
            if DoesEntityExist(ped.ped) then
                DeleteEntity(ped.ped)
            end
        end
    end
end)

function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
            if type(k) ~= 'number' then k = '"'..k..'"' end
            s = s .. '['..k..'] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end
