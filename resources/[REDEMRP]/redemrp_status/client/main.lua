----- Triggering RedM API to et all the exports ----
RedEM = exports["redem_roleplay"]:RedEM()

----- Variables -----
local usrthirst = 0
local usrhunger = 0
local usrstress = 0
local Winter = false
local inInterior = false
local drunklvl = 0
--Getting user metadata -----
MenuData = {}
TriggerEvent("redemrp_menu_base:getData",function(call)
    MenuData = call
end)

------ for hud command ------
local isHidden = false
Citizen.CreateThread(function()
    Wait(3000)
    SendNUIMessage({
        showhud = true
    })
end)

Citizen.CreateThread(function()
    while true do
        local isRadarHidden = IsRadarHidden()

        if isRadarHidden and not isHidden then
            SendNUIMessage({showhud = false})
            isHidden = true
        elseif not isRadarHidden and isHidden then
            SendNUIMessage({showhud = true})
            isHidden = false
        end
        Citizen.Wait(100)
    end
end)



--------- Main status update function ------
RegisterNetEvent('bw_status:UpdateStatus', function(thrist, hunger, stress)
    usrthirst = thrist
    usrhunger = hunger
    usrstress = stress
    local health = GetEntityHealth(PlayerPedId())
    if thrist <= 10 then
        TriggerEvent('bw-notify:sendnotify', 'Body', 'You need water!', 5000)
    elseif thrist <= 2 then
        health = health - 2
        TriggerEvent('bw-notify:sendnotify', 'Body', 'You need water!', 5000)
    end
    if hunger <= 10 then
        TriggerEvent('bw-notify:sendnotify', 'Body', 'You need some food!', 5000)
    elseif hunger <= 2 then
        health = health - 2
        TriggerEvent('bw-notify:sendnotify', 'Body', 'You need some food!', 5000)
    end
    SendNUIMessage({
        thrist = thrist,
        hunger = hunger,
        stress = stress,
        temp = GetCurrentTemperature()
    })
end)
---- For Stress ----
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        shake = usrstress * 0.004
        if usrstress >= 60 then
            ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", shake)
        end
        Citizen.Wait(2000)
    end
end)

function GetCurrentTemperature()
    local player = PlayerPedId()
    local coords = GetEntityCoords(player)
    ShouldUseMetricTemperature()
    temp = round(GetTemperatureAtCoords(coords.x, coords.y, coords.z), 1) * 1.9
    if not Winter or inInterior then return temp end
    if Winter then
        if temp > 1 then
            if GetClockHours() > 15 then
                temp = -2
            elseif GetClockHours() > 16 then
                temp = -4
            elseif GetClockHours() > 18 then
                temp = -5
            elseif GetClockHours() > 19 then
                temp = -7
            elseif GetClockHours() < 15 then
                temp = -1
            elseif GetClockHours() < 14 then
                temp = 0
            elseif GetClockHours() < 13 then
                temp = 1
            end
        end
        return temp
    end
end


--still working on it--

--function getdrunk()
--    Citizen.Wait(1000)
--    if drunklvl == 1 then
--        IsDrunk = true
--    elseif drunklvl == 2 then
--        DrunkEffects = true
--        IsDrunk = true
--    elseif drunklvl == 0 then
--        IsDrunk = false
--        DrunkEffects = false
--    end
--    if IsDrunk and not DrunkEffects then
--        DoScreenFadeOut(500)
--        Citizen.Wait(500)
--        local walkingStyle = { "default", "very_drunk" }
--        Citizen.InvokeNative(0x923583741DC87BCE, PlayerPedId(), walkingStyle[1])
--        Citizen.InvokeNative(0x89F5E7ADECCCB49C, PlayerPedId(), walkingStyle[2])
--        AnimpostfxPlay("PlayerDrunk01")
--        --Citizen.InvokeNative(0xCAB4DD2D5B2B7246, 0.5) -- AnimPostfxSetStrength
--        DrunkEffects = true
--        Citizen.Wait(100)
--        DoScreenFadeIn(500)
--    end
--    if IsDrunk and DrunkEffects then
--
--            DoScreenFadeOut(500)
--            Citizen.Wait(500)
--            local walkingStyle = { "default", "normal" }
--            Citizen.InvokeNative(0x923583741DC87BCE, PlayerPedId(), walkingStyle[1])
--            Citizen.InvokeNative(0x89F5E7ADECCCB49C, PlayerPedId(), walkingStyle[2])
--            AnimpostfxStop("PlayerDrunk01")
--            IsDrunk = false
--            DrunkEffects = false
--            Citizen.Wait(100)
--            DoScreenFadeIn(500)
--    end
--end

function round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

exports('SetInInterior', function(isInInterior)
    inInterior = isInInterior
end)

RegisterCommand('drunk', function(source, args, raw)
    drunklvl = args[1]
    getdrunk()
end)



