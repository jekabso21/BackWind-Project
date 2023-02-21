RegisterServerEvent('bw-coords:server:savePos')
AddEventHandler('bw-coords:server:savePos', function(coords, heading)
    io.open('coords.txt', 'a'):write('[' .. coords.x .. ', ' .. coords.y .. ', ' .. coords.z .. ', ' .. heading .. '],\n'):close()
end)