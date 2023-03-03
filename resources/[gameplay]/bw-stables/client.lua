local zones = { [1654810713] = "AguasdulcesFarm", [201158410] = "AguasdulcesRuins", [-1207133769]= "AguasdulcesVilla", [7359335]= "Annesburg", [-744494798]= "Armadillo", [-1708386982]= "BeechersHope", [1053078005]= "Blackwater", [1778899666]= "Braithwaite", [-1947415645]= "Butcher", [1862420670]= "Caliga", [-1851305682]= "cornwall", [-473051294
]= "Emerald", [406627834]= "lagras", [1299204683]= "Manicato", [1463094051]= "Manzanita", [2046780049]= "Rhodes", [2147354003]= "Siska", [-765540529
]= "StDenis", [427683330]= "Strawberry", [-1524959147]= "Tumbleweed", [459833523]= "Valentine", [2126321341]= "VANHORN", [-872622034
]= "Wallace", [1663398575] = "wapiti"  }

RegisterNetEvent('bw-stables:buyHorse')
AddEventHandler('bw-stables:buyHorse', function()
    local playerPed = PlayerPedId()


end)


RegisterNetEvent('bw-stables:OpenMenu')
AddEventHandler('bw-stables:OpenMenu', function()
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
              title = 'Get a hourse',
              description = 'Get your horse from the stable',
              icon = 'warehouse',
              event = 'bw-stables:getHorse',
              arrow = true,
              args = {
                location = loc
              }
          },
      }
    })
    lib.showContext('Stable')
end)