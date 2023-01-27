-- Menu F6
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}

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


function RedwoodF6()
    local redwoodF6 = RageUI.CreateMenu("Redwood", "Action Redwood")
    RageUI.Visible(redwoodF6, not RageUI.Visible(redwoodF6))
    while redwoodF6 do
        Citizen.Wait(0)
            RageUI.IsVisible(redwoodF6, true, true, true, function()
                RageUI.Checkbox("→ Prendre son service",nil, service,{},function(Hovered,Ative,Selected,Checked)
                    if Selected then
    
                        service = Checked
    
    
                        if Checked then
                            onservice = true
                            RageUI.Popup({
                                message = "Vous avez pris votre ~g~service !"})
    
                            
                        else
                            onservice = false
                            RageUI.Popup({
                                message = "Vous n\'etes plus en ~r~service !"})
    
                        end
                    end
                end)

                RageUI.Line()
    
                if onservice then
    
                    RageUI.ButtonWithStyle("→ Faire une facture",nil, {RightLabel = ""}, true, function(_,_,s)
                        local player, distance = ESX.Game.GetClosestPlayer()
                        local playerPed        = GetPlayerPed(-1)
                        if s then
                            local raison = ""
                            local montant = 0
                            AddTextEntry("FMMC_MPM_NA", "Objet de la facture")
                            DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez le motif de la facture :", "", "", "", "", 30)
                            while (UpdateOnscreenKeyboard() == 0) do
                                DisableAllControlActions(0)
                                Wait(0)
                            end
                            if (GetOnscreenKeyboardResult()) then
                                local result = GetOnscreenKeyboardResult()
                                if result then
                                    raison = result
                                    result = nil
                                    AddTextEntry("FMMC_MPM_NA", "Montant de la facture")
                                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Indiquez le montant de la facture :", "", "", "", "", 30)
                                    while (UpdateOnscreenKeyboard() == 0) do
                                        DisableAllControlActions(0)
                                        Wait(0)
                                    end
                                    if (GetOnscreenKeyboardResult()) then
                                        result = GetOnscreenKeyboardResult()
                                        if result then
                                            montant = result
                                            result = nil
                                            if player ~= -1 and distance <= 3.0 then
                                                TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
                                                Citizen.Wait(5000)
                                                TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_orpa', ('orpa'), montant)
                                                ClearPedTasksImmediately(GetPlayerPed(-1))
                                                TriggerEvent('esx:showAdvancedNotification', 'Fl~g~ee~s~ca ~g~Bank', 'Facture envoyée : ', 'Vous avez envoyé une facture d\'un montant de : ~g~'..montant.. '$ ~s~pour cette raison : ~b~' ..raison.. '', 'CHAR_BANK_FLEECA', 9)
                                            else
                                                ESX.ShowNotification("~r~Probleme~s~: Aucuns joueurs proche")
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end)

                    if IsPedInAnyVehicle(PlayerPedId(), true) then
                        RageUI.Line()
                        RageUI.Separator("↓ ~o~     Lieux de travails    ~s~↓")
                        RageUI.ButtonWithStyle("Placer GPS sur récolte de tabac blond séché",nil, {RightLabel = ""}, true, function(h, a, s)

                            if s then       
                                SetNewWaypoint(2852.7727050781, 4586.6733398438)
                            end
                        end)
    
                        RageUI.ButtonWithStyle("Placer GPS sur récolte de tabac brun séché",nil, {RightLabel = ""}, true, function(h, a, s)

                            if s then       
                                SetNewWaypoint(2830.6247558594, 4590.3022460938)
                            end
                        end)
                        
                            RageUI.ButtonWithStyle("Placer GPS sur traitement de tabac blond",nil, {RightLabel = ""}, true, function(h, a, s)
                            if s then      
                                SetNewWaypoint(2924.2451171875, 4478.2895507813)
                            end
                        end)

                        RageUI.ButtonWithStyle("Placer GPS sur traitement de tabac brun",nil, {RightLabel = ""}, true, function(h, a, s)
                        if s then      
                            SetNewWaypoint(2912.4008789063, 4475.560546875)
                        end
                    end)

                    RageUI.ButtonWithStyle("Placer GPS sur la création de cigarettes",nil, {RightLabel = ""}, true, function(h, a, s)
                        if s then      
                            SetNewWaypoint(2886.0219726563, 4498.9223632813)
                        end
                    end)

                    RageUI.ButtonWithStyle("Placer GPS sur la vente de cigarettes",nil, {RightLabel = ""}, true, function(h, a, s)
                        if s then      
                            SetNewWaypoint(374.71472167969, 334.26089477539)
                        end
                    end)
                end
                
                    RageUI.Line()

                    RageUI.Checkbox("→ Activer les annonces",nil, annonce,{},function(Hovered,Ative,Selected,Checked)
                        if Selected then
        
                            annonce = Checked
        
        
                            if Checked then
                                ONannonce = true
        
                                
                            else
                                ONannonce = false
        
                            end
                        end
                    end)
        
                    RageUI.Line()

                    if ONannonce then
                        RageUI.Separator("↓ ~b~     Listes des annonces    ~s~↓")

                RageUI.ButtonWithStyle("Annonces Ouvertures",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        TriggerServerEvent('OuvertRed')
                    end
                end)
        
                RageUI.ButtonWithStyle("Annonces Fermetures",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('FermerRed')
                    end
                end)

                RageUI.ButtonWithStyle("Annonces Recrutements",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('RecruRed')
                    end
                end)

            end
            end
            
                end, function() 
                end)

                if not RageUI.Visible(redwoodF6) then
                    redwoodF6 = RMenu:DeleteType("redwoodF6", true)
        end
    end
end


Keys.Register('F6', 'Redwood', 'Ouvrir le Menu Redwood', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'redwood' then
    	RedwoodF6()
	end
end)