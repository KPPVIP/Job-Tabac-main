ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
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


function GarageRed()
    local ggarage = RageUI.CreateMenu("Garage", "Liste des véhicules")
    RageUI.Visible(ggarage, not RageUI.Visible(ggarage))
    while ggarage do
        Citizen.Wait(0)
            RageUI.IsVisible(ggarage, true, true, true, function()
				FreezeEntityPosition(PlayerPedId(), true)

			local pCo = GetEntityCoords(PlayerPedId())
	
			for k,v in pairs(Config.Garage.redwood.vehicules) do
				if v.category ~= nil then 
					RageUI.Separator(v.category)
				else 
					RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "→"}, true, function(_,_,s)
						if s then
							Citizen.CreateThread(function()
								local model = GetHashKey(v.model)
								RequestModel(model)
								while not HasModelLoaded(model) do Citizen.Wait(1) end
								local vehicle = CreateVehicle(model, Config.Spawn.spawnvoiture.position.x, Config.Spawn.spawnvoiture.position.y, Config.Spawn.spawnvoiture.position.z, Config.Spawn.spawnvoiture.position.h, true, false)
								SetModelAsNoLongerNeeded(model)
								SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
								TriggerServerEvent('esx_vehiclelock:givekey', 'yes', GetVehicleNumberPlateText(vehicle))
								SetVehicleNumberPlateText(vehicle, "VDA") 
								RageUI.CloseAll()
								FreezeEntityPosition(PlayerPedId(), false)
							end)
						end
					end)
				end
			end

			RageUI.ButtonWithStyle("Ranger le véhicule", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
				if (Selected) then
					local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)  

						if dist4 < 5 then
						DeleteEntity(veh)
						TriggerServerEvent('esx_vehiclelock:deletekeyjobs', 'yes')
						RageUI.CloseAll()
						end

					end
				end) 

				end, function()    
				end)

		if not RageUI.Visible(ggarage) then
			FreezeEntityPosition(PlayerPedId(), false)
			ggarage = RMenu:DeleteType("ggarage", true)
		end
	end
end

Citizen.CreateThread(function()
    while true do
        local interval = 1000
        local position = Config.Pos.GarageVoiture
        for _, v in pairs(position) do
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 10.0 then
                    interval = 0
                    if ESX.PlayerData.job and ESX.PlayerData.job.name == "redwood" then
                    DrawMarker(Config.Marker.Type, v.x, v.y, v.z, 0.0, 0.0, Config.Marker.Rotation, 0.0, 0.0, 0.0, 1.0, 0.5, 1.0, Config.Marker.ColorR, Config.Marker.ColorG, Config.Marker.ColorB, Config.Marker.Opacite, Config.Marker.Saute, Config.Marker.Tourne, p19, false, false, false, false)
                    if distance <= 1.5 then
                        RageUI.Text({message = "Appuyez sur ~b~[E]~s~ pour ouvrir le garage", time_display = 1})
                        if IsControlJustPressed(0, 51) then
                            GarageRed()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)