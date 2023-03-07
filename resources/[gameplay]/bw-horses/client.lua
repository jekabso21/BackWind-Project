RegisterCommand("sp_horse", function(source, args, raw)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local key = "a_c_horse_appaloosa_leopard"
    local model = GetHashKey(key)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    print(model, coords.x + 3, coords.y, coords.z)
    local horse = CreatePed(model, coords.x + 3, coords.y, coords.z, 0.0, true, false)
    Citizen.InvokeNative(0x283978A15512B2FE, horse, true)
    print(horse)
end)