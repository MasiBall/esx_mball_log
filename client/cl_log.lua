ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(60000)
	end
end)

local firstSpawn = true
local joinedPlayer = PlayerId()
AddEventHandler("playerSpawned", function()
if firstSpawn then
    SetPlayerControl(joinedPlayer, false, 0)
    firstSpawn = false
    Wait(8500)
    TriggerServerEvent('mball_log:esxjoin')
    SetPlayerControl(joinedPlayer, true, 0)
    firstSpawn = false
    end
end)

local playtime = 0

Citizen.CreateThread(function()
    while true do
        playtime = playtime + 1
        TriggerServerEvent('mball_log:server:playtime', playtime)
        Citizen.Wait(60000)
    end
end)