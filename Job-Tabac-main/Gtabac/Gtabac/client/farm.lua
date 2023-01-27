----- Definition ESX -----
ESX = nil
local PlayerData = {}
local yes = true
local no = false

Citizen.CreateThread(function()
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

	while ESX == nil do Citizen.Wait(100) end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	ESX.PlayerData.job = job  
end)

------------------------------------------------------
-- Début code -- 

-- Marker Récolte -- 
Citizen.CreateThread(function()
    while true do
        local interval = 1000
        local position = Config.Pos.RecolteBL
        for _, v in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'redwood' then
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 10.0 then
                    interval = 0
                    DrawMarker(Config.Marker.Type, v.x, v.y, v.z, 0.0, 0.0, Config.Marker.Rotation, 0.0, 0.0, 0.0, 1.0, 0.5, 1.0, Config.Marker.ColorR, Config.Marker.ColorG, Config.Marker.ColorB, Config.Marker.Opacite, Config.Marker.Saute, Config.Marker.Tourne, 2, no, no, no, no)
                    if distance <= 1.5 then
                        RageUI.Text({message = "Appuyez sur ~b~[E]~s~ pour récolter du ~y~tabac Blond séché", time_display = 1})
                        if IsControlJustPressed(0, 51) then
                            OpenTabacBlond()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

-- Fonction de récolte -- 
function OpenTabacBlond()
    local recolte = RageUI.CreateMenu("Récolte", "Récolte de tabac blond séché...") 

    RageUI.Visible(recolte, not RageUI.Visible(recolte))
        while recolte do
            FreezeEntityPosition(PlayerPedId(), yes)
        Wait(0)
        RageUI.IsVisible(recolte, yes, yes, yes, function()

            RageUI.PercentagePanel(Config.Time.Load, "Récolte de tabac blond séché (~y~" .. math.floor(Config.Time.Load * 100) .. "%~s~)", "", "", function(_, a_, percent)
                if Config.Time.Load < 1.0 then
                    Config.Time.Load = Config.Time.Load + Config.Time.RecolteLoad
                else
                    Config.Time.Load = 0
                    TriggerServerEvent('gtabac:rtbcblond')
                end
            end)
            
        end, function()  
        end)
        if not RageUI.Visible(recolte) then
            recolte = RMenu:DeleteType("recolte", yes)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            FreezeEntityPosition(PlayerPedId(), no)
        end
    end
end

-- Marker Récolte Tabac Brun -- 
Citizen.CreateThread(function()
    while true do
        local interval = 1000
        local position = Config.Pos.RecolteBR
        for _, v in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'redwood' then
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 10.0 then
                    interval = 0
                    DrawMarker(Config.Marker.Type, v.x, v.y, v.z, 0.0, 0.0, Config.Marker.Rotation, 0.0, 0.0, 0.0, 1.0, 0.5, 1.0, Config.Marker.ColorR, Config.Marker.ColorG, Config.Marker.ColorB, Config.Marker.Opacite, Config.Marker.Saute, Config.Marker.Tourne, 2, no, no, no, no)
                    if distance <= 1.5 then
                        RageUI.Text({message = "Appuyez sur ~b~[E]~s~ pour récolter du ~o~tabac Brun séché", time_display = 1})
                        if IsControlJustPressed(0, 51) then
                            OpenTabacBrun()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

-- Fonction de récolte -- 
function OpenTabacBrun()
    local recolte = RageUI.CreateMenu("Récolte", "Récolte de tabac brun séché...") 

    RageUI.Visible(recolte, not RageUI.Visible(recolte))
        while recolte do
            FreezeEntityPosition(PlayerPedId(), yes)
        Wait(0)
        RageUI.IsVisible(recolte, yes, yes, yes, function()

            RageUI.PercentagePanel(Config.Time.Load, "Récolte de tabac brun séché (~o~" .. math.floor(Config.Time.Load * 100) .. "%~s~)", "", "", function(_, a_, percent)
                if Config.Time.Load < 1.0 then
                    Config.Time.Load = Config.Time.Load + Config.Time.RecolteLoad
                else
                    Config.Time.Load = 0
                    TriggerServerEvent('gtabac:rtbcbrun')
                end
            end)
            
        end, function()  
        end)
        if not RageUI.Visible(recolte) then
            recolte = RMenu:DeleteType("recolte", yes)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            FreezeEntityPosition(PlayerPedId(), no)
        end
    end
end

-- Marker Traitement Tabac Blond -- 
Citizen.CreateThread(function()
    while true do
        local interval = 1000
        local position = Config.Pos.TraitementBL
        for _, v in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'redwood' then
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 10.0 then
                    interval = 0
                    DrawMarker(Config.Marker.Type, v.x, v.y, v.z, 0.0, 0.0, Config.Marker.Rotation, 0.0, 0.0, 0.0, 1.0, 0.5, 1.0, Config.Marker.ColorR, Config.Marker.ColorG, Config.Marker.ColorB, Config.Marker.Opacite, Config.Marker.Saute, Config.Marker.Tourne, 2, no, no, no, no)
                    if distance <= 1.5 then
                        RageUI.Text({message = "Appuyez sur ~b~[E]~s~ pour traiter du ~y~tabac Blond séché", time_display = 1})
                        if IsControlJustPressed(0, 51) then
                            OpenTraitBlond()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

-- Fonction de traitement -- 
function OpenTraitBlond()
    local traitement = RageUI.CreateMenu("Traitement", "Traitement de tabac blond séché...") 

    RageUI.Visible(traitement, not RageUI.Visible(traitement))
        while traitement do
            FreezeEntityPosition(PlayerPedId(), yes)
        Wait(0)
        RageUI.IsVisible(traitement, yes, yes, yes, function()

            RageUI.PercentagePanel(Config.Time.Load, "Traitement de tabac blond séché (~y~" .. math.floor(Config.Time.Load * 100) .. "%~s~)", "", "", function(_, a_, percent)
                if Config.Time.Load < 1.0 then
                    Config.Time.Load = Config.Time.Load + Config.Time.TraitementLoad
                else
                    Config.Time.Load = 0
                    TriggerServerEvent('gtabac:traitblond')
                end
            end)
            
        end, function()  
        end)
        if not RageUI.Visible(traitement) then
            traitement = RMenu:DeleteType("traitement", yes)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            FreezeEntityPosition(PlayerPedId(), no)
        end
    end
end

-- Marker Traitement Tabac Brun -- 
Citizen.CreateThread(function()
    while true do
        local interval = 1000
        local position = Config.Pos.TraitementBR
        for _, v in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'redwood' then
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 10.0 then
                    interval = 0
                    DrawMarker(Config.Marker.Type, v.x, v.y, v.z, 0.0, 0.0, Config.Marker.Rotation, 0.0, 0.0, 0.0, 1.0, 0.5, 1.0, Config.Marker.ColorR, Config.Marker.ColorG, Config.Marker.ColorB, Config.Marker.Opacite, Config.Marker.Saute, Config.Marker.Tourne, 2, no, no, no, no)
                    if distance <= 1.5 then
                        RageUI.Text({message = "Appuyez sur ~b~[E]~s~ pour traiter du ~o~tabac Brun séché", time_display = 1})
                        if IsControlJustPressed(0, 51) then
                            OpenTraitBrun()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

-- Fonction de traitement -- 
function OpenTraitBrun()
    local traitement = RageUI.CreateMenu("Traitement", "Traitement de tabac brun séché...") 

    RageUI.Visible(traitement, not RageUI.Visible(traitement))
        while traitement do
            FreezeEntityPosition(PlayerPedId(), yes)
        Wait(0)
        RageUI.IsVisible(traitement, yes, yes, yes, function()

            RageUI.PercentagePanel(Config.Time.Load, "Traitement de tabac brun séché (~o~" .. math.floor(Config.Time.Load * 100) .. "%~s~)", "", "", function(_, a_, percent)
                if Config.Time.Load < 1.0 then
                    Config.Time.Load = Config.Time.Load + Config.Time.TraitementLoad
                else
                    Config.Time.Load = 0
                    TriggerServerEvent('gtabac:traitbrun')
                end
            end)
            
        end, function()  
        end)
        if not RageUI.Visible(traitement) then
            traitement = RMenu:DeleteType("traitement", yes)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            FreezeEntityPosition(PlayerPedId(), no)
        end
    end
end

-- Marker Création Cigarette -- 
Citizen.CreateThread(function()
    while true do
        local interval = 1000
        local position = Config.Pos.Creation
        for _, v in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'redwood' then
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 10.0 then
                    interval = 0
                    DrawMarker(Config.Marker.Type, v.x, v.y, v.z, 0.0, 0.0, Config.Marker.Rotation, 0.0, 0.0, 0.0, 1.0, 0.5, 1.0, Config.Marker.ColorR, Config.Marker.ColorG, Config.Marker.ColorB, Config.Marker.Opacite, Config.Marker.Saute, Config.Marker.Tourne, 2, no, no, no, no)
                    if distance <= 1.5 then
                        RageUI.Text({message = "Appuyez sur ~b~[E]~s~ pour fabriquer des ~r~cigarettes", time_display = 1})
                        if IsControlJustPressed(0, 51) then
                            OpenCig()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

-- Fonction de création de cigarette -- 
function OpenCig()
    local cig = RageUI.CreateMenu("Traitement", "Traitement de tabac brun...") 

    RageUI.Visible(cig, not RageUI.Visible(cig))
        while cig do
            FreezeEntityPosition(PlayerPedId(), yes)
        Wait(0)
        RageUI.IsVisible(cig, yes, yes, yes, function()

            RageUI.ButtonWithStyle("Fabriquer une cigarette blonde", nil, {RightLabel = "~y~→"}, yes, function(Hovered, Active, Selected)
				if (Selected) then  
				TriggerServerEvent("gtabac:malboro")
				end
			end)

            RageUI.ButtonWithStyle("Fabriquer une cigarette brune", nil, {RightLabel = "~o~→"}, yes, function(Hovered, Active, Selected)
				if (Selected) then  
				TriggerServerEvent("gtabac:gitanes")
				end
			end)
            
        end, function()  
        end)
        if not RageUI.Visible(cig) then
            cig = RMenu:DeleteType("cig", yes)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            FreezeEntityPosition(PlayerPedId(), no)
        end
    end
end

-- Marker Vente de Cigarette -- 
Citizen.CreateThread(function()
    while true do
        local interval = 1000
        local position = Config.Pos.Vente
        for _, v in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'redwood' then
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v)
                if distance <= 10.0 then
                    interval = 0
                    DrawMarker(Config.Marker.Type, v.x, v.y, v.z, 0.0, 0.0, Config.Marker.Rotation, 0.0, 0.0, 0.0, 1.0, 0.5, 1.0, Config.Marker.ColorR, Config.Marker.ColorG, Config.Marker.ColorB, Config.Marker.Opacite, Config.Marker.Saute, Config.Marker.Tourne, 2, no, no, no, no)
                    if distance <= 1.5 then
                        RageUI.Text({message = "Appuyez sur ~b~[E]~s~ pour ~g~vendre~s~ des cigarette", time_display = 1})
                        if IsControlJustPressed(0, 51) then
                            OpenVente()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

-- Fonction de vente -- 
function OpenVente()
    local vente = RageUI.CreateMenu("Vente", "Vente de cigarette(s)...")
    local marlboro = RageUI.CreateSubMenu(vente, "Vente Marlboro", nil)
    local gitane = RageUI.CreateSubMenu(vente, "Vente Gitane", nil)
    local sell = "~r~0"
    --local sellyes = false

    RageUI.Visible(vente, not RageUI.Visible(vente))
        while vente do
            FreezeEntityPosition(PlayerPedId(), yes)
        Wait(0)
        RageUI.IsVisible(vente, yes, yes, yes, function()

            RageUI.ButtonWithStyle("Cigarette Blonde", nil, {RightLabel = "~y~→"}, yes, function(Hovered, Active, Selected)
                if (Selected) then
                end
            end, marlboro)

            RageUI.ButtonWithStyle("Cigarette Brune", nil, {RightLabel = "~o~→"}, yes, function(Hovered, Active, Selected)
                if (Selected) then
                end
            end, gitane)

        end, function()  
        end)

        RageUI.IsVisible(marlboro, yes, yes, yes, function()

            RageUI.ButtonWithStyle("Vendre des Marlboro", nil, {RightLabel = "~g~$"}, yes, function(Hovered, Active, Selected)
            if (Selected) then
                number = FarmImput("Combien de Marlboro souhaitez vous vendre ?", "", 2, false)
                if number ~= nil and number ~= "" then
                    sell = "~g~" ..number
                else
                    RageUI.Popup({message = "~r~Quantité invalide !"})
                end
            end
            end)

            RageUI.Line()
            
            RageUI.ButtonWithStyle("Valider la vente", nil, {RightLabel = ""..sell}, yes, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent("gtabac:ventem", tonumber(number))
                end
            end)
            
        end, function()  
        end)

        RageUI.IsVisible(gitane, yes, yes, yes, function()

            RageUI.ButtonWithStyle("Vendre des Gitane", nil, {RightLabel = "~g~$"}, yes, function(Hovered, Active, Selected)
            if (Selected) then
                number = FarmImput("Combien de Gitane souhaitez vous vendre ?", "", 2, false)
                if number ~= nil and number ~= "" then
                    sell = "~g~" ..number
                else
                    RageUI.Popup({message = "~r~Quantité invalide !"})
                end
            end
            end)

            RageUI.Line()
            
            RageUI.ButtonWithStyle("Valider la vente", nil, {RightLabel = ""..sell}, yes, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent("gtabac:venteg", tonumber(number))
                end
            end)
            
        end, function()  
        end)

        if not RageUI.Visible(vente) and not RageUI.Visible(marlboro) and not RageUI.Visible(gitane) then
            vente = RMenu:DeleteType("vente", yes)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            FreezeEntityPosition(PlayerPedId(), no)
        end
    end
end

-- Fonction Imput -- 
function FarmImput(TextEntry, ExampleText, MaxStringLenght, isValueInt)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        if isValueInt then
            local isNumber = tonumber(result)
            if isNumber then
                return result
            else
                return nil
            end
        end

        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end