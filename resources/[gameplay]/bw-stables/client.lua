local RedEM = exports["redem_roleplay"]:RedEM()
local zones = { [1654810713] = "AguasdulcesFarm", [201158410] = "AguasdulcesRuins", [-1207133769]= "AguasdulcesVilla", [7359335]= "Annesburg", [-744494798]= "Armadillo", [-1708386982]= "BeechersHope", [1053078005]= "Blackwater", [1778899666]= "Braithwaite", [-1947415645]= "Butcher", [1862420670]= "Caliga", [-1851305682]= "cornwall", [-473051294
]= "Emerald", [406627834]= "lagras", [1299204683]= "Manicato", [1463094051]= "Manzanita", [2046780049]= "Rhodes", [2147354003]= "Siska", [-765540529
]= "StDenis", [427683330]= "Strawberry", [-1524959147]= "Tumbleweed", [459833523]= "Valentine", [2126321341]= "VANHORN", [-872622034
]= "Wallace", [1663398575] = "wapiti"  }



RegisterNetEvent('bw-stables:OpenMenu')
AddEventHandler('bw-stables:OpenMenu', function()
    local ply = PlayerPedId()
    local coords = GetEntityCoords(PlayerPedId())
    local loc = zones[Citizen.InvokeNative(0x43AD8FC02B429D33, coords, 1)]
    lib.registerContext({
      id = 'Stable',
      title = 'Welcome to ' .. loc ..' stables',
      options = {
          {
              title = 'Buy a horse',
              description = 'Buy a new horse',
              icon = 'horse',
              event = 'bw-stables:buyHorse',
              arrow = true,
          },
          {
              title = 'Get a horse',
              description = 'Get your horse from the stable',
              icon = 'warehouse',
              event = 'bw-stables:OpenGarage',
              arrow = true,
              args = {
                location = loc
              }
          },
      }
    })
    lib.showContext('Stable')
end)

RegisterNetEvent('bw-stables:storeHorse')
AddEventHandler('bw-stables:storeHorse', function()
    local ply = PlayerPedId()
    local coords = GetEntityCoords(PlayerPedId())
    if IsPedOnMount(ply) then
        local model = GetEntityModel(GetMount(ply))
        local id = GetMount(ply)
        local loc = zones[Citizen.InvokeNative(0x43AD8FC02B429D33, coords, 1)]
        TriggerServerEvent("bw-stables:storeHorse", model, id, loc)
    else
        TriggerEvent("notifications:notify", "Rancher", "You have to be on the horse!", 3000)
    end
end)

RegisterNetEvent('bw-stables:OpenGarage')
AddEventHandler('bw-stables:OpenGarage', function()
    RedEM.TriggerCallback('bw-stables:gethorses', function(horses)
        --with lib.registerContext create a context menu with all the horses that you can select

        local options = {}
        for k,v in pairs(horses) do
            local option = {
                title = v.name,
                description = 'Get your horse',
                icon = 'horse',
                event = 'bw-stables:getHorse',
                arrow = true,
                args = {
                    horse = v
                }
            }
            table.insert(options, option)

            lib.registerContext({
                id = 'Horses',
                title = 'Get Your Horse',
                options = options
            })
            lib.showContext('Horses')
        end
    end)
end)

-- Client Callbacks --
lib.callback.register('bw-stables:createname', function()
    local input = lib.inputDialog('Name The Horse', {'Enter Horses Name'})

    if not input then return end
    return input
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