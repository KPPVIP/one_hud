local changed

print("Script:         one_hud\r\nGescripted von: ONEIMAGE\r\nStatus:         gestarted")

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	TriggerEvent('es:setMoneyDisplay', 0.0)
	ESX.UI.HUD.SetDisplay(0.0)
	TriggerEvent('es:setbankmoneyDisplay', 0.0)
	ESX.UI.HUD.SetDisplay(0.0)
	
	NetworkSetTalkerProximity(10.0)
end)

Citizen.CreateThread(function()
	while true do
		if true then
			if IsControlPressed(0, 47) then
				openHudsettings(true)
				StartScreenEffect('MenuMGIn', 1, true)
			end
		end
		Citizen.Wait(1)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer) 
	local data = xPlayer
	local accounts = data.accounts
		for k,v in pairs(accounts) do
			local account = v
			if true then
				SendNUIMessage({action = "setValue", key = "bankmoney", value = account.money.." $"})
			end
		end
		
		local job = data.job
		SendNUIMessage({action = "setValue", key = "job", value = job.label.." - "..job.grade_label, icon = job.name})
		SendNUIMessage({action = "setValue", key = "bank", value = data.money.." $"})
		SendNUIMessage({action = "setValue", key = "money", value = data.money.." $"})
		SendNUIMessage({action = "setValue", key = "playerid", value = "ID "..GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1)))   })
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	if account.name == "bank" then
		SendNUIMessage({action = "setValue", key = "bankmoney", value = account.money.." $"})
	elseif account.name == "money" then
		SendNUIMessage({action = "setValue", key = "money", value = account.money.." $"})
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  SendNUIMessage({action = "setValue", key = "job", value = job.label.." - "..job.grade_label, icon = job.name})
end)

RegisterNetEvent('es:activateMoney')
AddEventHandler('es:activateMoney', function(e)
	SendNUIMessage({action = "setValue", key = "money", value = e.." $"})
end)
RegisterNetEvent('es:activatebank')
AddEventHandler('es:activatebank', function(e)
	SendNUIMessage({action = "setValue", key = "bankmoney", value = e.." $"})
end)

function openHudsettings(state)
    SendNUIMessage({
        action="hudsettings",
        status=state
    })
    SetNuiFocus(state, state)
end

RegisterNUICallback("hudsettings-close", function()
    openHudsettings(false)
	StopScreenEffect('MenuMGIn')
end)