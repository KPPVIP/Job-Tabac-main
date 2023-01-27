ESX = nil
local yes = true

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local redwoodboss = nil

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
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

-- Blips Redwood
Citizen.CreateThread(function()
        for _, blip in pairs(Config.Pos.Patron) do
            local blip = AddBlipForCoord(blip)
            SetBlipSprite(blip, 515)
            SetBlipScale(blip, 0.9)
            SetBlipColour(blip, 1)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Redwood")
            EndTextCommandSetBlipName(blip)
    end
end)

function TabacBoss()
    local boss_menu = RageUI.CreateMenu("Redwood", "Action Patron")
      RageUI.Visible(boss_menu, not RageUI.Visible(boss_menu))
  
              while boss_menu do
                  Citizen.Wait(0)
                      RageUI.IsVisible(boss_menu, yes, yes, yes, function()
  
                        RageUI.ButtonWithStyle("~g~→~s~ Voir l'argent de l'entreprise", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                            if (Selected) then
                                TriggerServerEvent("gtabac:setmoney_society")
                            end
                        end)

            RageUI.Line()

            RageUI.ButtonWithStyle("→ Retirer argent de société",nil, {RightLabel = ""}, yes, function(Hovered, Active, Selected)
                if Selected then
                    ExecuteCommand'e type'
                    local amount = KeyboardInput("Montant", "", 10) 
                    amount = tonumber(amount)
                    if amount == nil then
                        RageUI.Popup({message = "Montant ~r~invalide~s~"})
                    else
                        TriggerServerEvent('esx_society:withdrawMoney', 'redwood', amount)
                        ClearPedTasksImmediately(GetPlayerPed(-1))
                    end
                end
            end)

            RageUI.ButtonWithStyle("→ Déposer argent de société",nil, {RightLabel = ""}, yes, function(Hovered, Active, Selected)
                if Selected then
                    ExecuteCommand'e type'
                    local amount = KeyboardInput("Montant", "", 10)
                    amount = tonumber(amount)
                    if amount == nil then
                        RageUI.Popup({message = "Montant invalide"})
                    else
                        TriggerServerEvent('esx_society:depositMoney', 'redwood', amount)
                        ClearPedTasksImmediately(GetPlayerPed(-1))
                    end
                end
            end) 

            RageUI.ButtonWithStyle("→ Fermer votre ~r~panel",nil, {RightLabel = ""}, yes, function(Hovered, Active, Selected)
                if Selected then
                FreezeEntityPosition(PlayerPedId(), false)
                ClearPedTasksImmediately(GetPlayerPed(-1))
                RageUI.CloseAll()
                end
            end)


        end, function()
        end)
        if not RageUI.Visible(boss_menu) then
            ClearPedTasksImmediately(GetPlayerPed(-1))
            FreezeEntityPosition(PlayerPedId(), false)
            boss_menu = RMenu:DeleteType("boss_menu", yes)
    end
end
end

Citizen.CreateThread(function()
    while true do
        local interval = 1000
        local position = Config.Pos.Patron
        for _, v in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'redwood' and ESX.PlayerData.job.grade_name == 'boss' then
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 10.0 then
                    interval = 0
                    DrawMarker(Config.Marker.Type, v.x, v.y, v.z, 0.0, 0.0, 360.0, 0.0, 0.0, 0.0, 1.0, 0.5, 1.0, Config.Marker.ColorR, Config.Marker.ColorG, Config.Marker.ColorB, Config.Marker.Opacite, Config.Marker.Saute, Config.Marker.Tourne, 2, false, false, false, false)
                    if distance <= 1.5 then
                        RageUI.Text({message = "Appuyez sur ~b~[E]~s~ pour ouvrir le panel administratif", time_display = 1})
                        if IsControlJustPressed(0, 51) then
                    FreezeEntityPosition(PlayerPedId(), yes)
                    ExecuteCommand'e type'          
                    TabacBoss()
            end
        end
    end
    end
    Citizen.Wait(5)
    end
end
end)

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end 
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end