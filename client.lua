ESX = nil
  
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	local PlayerData = {}
	local ped = PlayerPedId()

Citizen.CreateThread(function()
    if ESX.IsPlayerLoaded() then
		ESX.PlayerData = ESX.GetPlayerData()
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

local veh = 'd12'

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local playercoord = GetEntityCoords(GetPlayerPed(-1))
        local closeveh = GetClosestVehicle(playercoord.x,playercoord.y,playercoord.z,10.0,GetHashKey(veh),70)
        if DoesEntityExist(closeveh) then
            local detect = 4.0
            local d12coord = GetOffsetFromEntityInWorldCoords(closeveh, 0.0, -detect, 0.0) 
            if Vdist(GetEntityCoords(GetPlayerPed(-1)), d12coord.x , d12coord.y, d12coord.z) <= 1.5 then
                local echelle = GetConvertibleRoofState(closeveh)
                if echelle == 0 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour sortir les échelles", false, false, 1)
                    if IsControlJustPressed(0,51) then
                        LowerConvertibleRoof(closeveh,false)
                    end
                elseif echelle == 2 then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ranger les échelles", false, true, 1)
                    if IsControlJustPressed(0,51)then 
                        RaiseConvertibleRoof(closeveh,false)
                    end
                end                 
            end
        end
    end
end)
