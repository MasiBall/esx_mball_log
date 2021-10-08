ESX = nil
TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

local firstSpawn = true
local joinedPlayer = PlayerId()
AddEventHandler("playerSpawned", function()
if firstSpawn then
    SetPlayerControl(joinedPlayer, false, 0)
    firstSpawn = false
    Wait(8500)
    TriggerServerEvent('esx_mball_log:esxjoin')
    SetPlayerControl(joinedPlayer, true, 0)
    firstSpawn = false
    end
end)

local playtime = 0

Citizen.CreateThread(function()
    while true do
        playtime = playtime + 1
        TriggerServerEvent('esx_mball_log:server:playtime', playtime)
        Citizen.Wait(60000)
    end
end)
