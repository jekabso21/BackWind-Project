local pedstable = {}

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

RegisterNetEvent('bw-peds:client:target')
AddEventHandler('bw-peds:client:target', function()
    print("Hello from target")
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
