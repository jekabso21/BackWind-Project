

RegisterNetEvent('bw-stables:buyHorse')
AddEventHandler('bw-stables:buyHorse', function()
    local playerPed = PlayerPedId()


end)


RegisterNetEvent('bw-stables:OpenMenu')
AddEventHandler('bw-stables:OpenMenu', function()
    local zone = GetMapZoneAtCoords(GetEntityCoords(PlayerPedId()), TOWN)
    lib.registerContext({
      id = 'Stable',
      title = 'Welcome to ' ..  zone .. ' stables',
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
              icon = 'garage',
              event = 'bw-stables:getHorse',
              arrow = true,
              args = {
                location = zone
              }
          },
      }
    })
end)