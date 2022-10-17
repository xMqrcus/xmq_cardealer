
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP", "xmq_vabenskab")
vRPclient = Tunnel.getInterface("vRP", "xmq_vabenskab")

HT = nil


TriggerEvent('HT_base:getBaseObjects', function(obj) HT = obj end)
--- ### FUNCTIONS
function Notify(id,msg,type,timeout)
     --TriggerClientEvent('mythic_notify:client:SendAlert', id, { type = type, text = msg, length = timeout})
     TriggerClientEvent("cardealer:sendnotify", id, msg)
end
function firstToUpper(str)
	return (str:gsub("^%l", string.upper))
end
function formatarNumero(valor)
     local formatado = valor
     while true do  
                                             -- O "." entre "%1" e "%2" é o separador
       formatado, n = string.gsub(formatado, "^(-?%d+)(%d%d%d)", '%1.%2') 
       if ( n ==0 ) then
         break
       end
     end
     return formatado
 end
--- ###KODE

RegisterServerEvent("xmq:checkForBuyVehicle")
AddEventHandler("xmq:checkForBuyVehicle", function(name,price,model)
     continue = true
     local _source = source
     local user_id = vRP.getUserId({_source})
     local vehicles = MySQL.Sync.fetchAll('SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id', {user_id = user_id})
     for k,v in pairs(vehicles) do 
          if v.vehicle == model then
               Notify(_source,"Du har allerede en "..firstToUpper(name), "error",tonumber(5000))
               continue = false
          end
     end
     local money = vRP.getBankMoney({user_id})
     if money == nil or money == 0 then
          Notify(_source,"FEJL: Kontakt en udvikler [FEJLKODE 3]", "error",tonumber(5000))
     end
     if money < price then
          Notify(_source,"Du har ikke råd til en "..firstToUpper(name).." ("..formatarNumero(price).."DKK)", "error",tonumber(5000))
          continue = false
     end
     if continue == true then
          TriggerClientEvent("askPlayer", _source, name,price,model)
     end
end)

RegisterServerEvent("xmq:acceptDeal")
AddEventHandler("xmq:acceptDeal", function(name,price,model,type)
     if type == "compact" or type == "coupe" or type == "sedan" or type =="sports" or type =="sportsclassics" or type =="supers" or type =="muscle" or type =="offroad" or type =="suv" or type =="varevogne" or type =="exclusive" then
          veh_type = "car"
     elseif type == "mc" then
          veh_type = "bike"
     end
     local _source = source
     local user_id = vRP.getUserId({_source})
     if user_id ~= nil then
          if vRP.tryBankPayment({user_id,price}) then
               local identity = MySQL.Sync.fetchAll("SELECT * FROM vrp_user_identities WHERE user_id = @user_id", {user_id = user_id})
               if identity then
                    MySQL.Sync.execute('INSERT IGNORE INTO vrp_user_vehicles(user_id,name,vehicle,vehicle_plate,veh_type,hp,fuel) VALUES(@user_id,@name,@vehicle,@vehicle_plate,@veh_type,@hp,@fuel)', {user_id = user_id,name = name, vehicle = model, vehicle_plate = "P "..identity[1].registration, veh_type = veh_type, hp = 1000.0,fuel = 100.0})
                    Notify(_source,"Du købte en "..firstToUpper(name).." for "..formatarNumero(price).."DKK", "success",tonumber(5000))
                    TriggerClientEvent("resetPlayer", user_id)
               else
                    Notify(_source,"FEJL: Kontakt en udvikler [FEJLKODE 2]", "error",tonumber(5000))
               end
          else
               Notify(_source,"Du har ikke råd til køretøjet", "error",tonumber(5000))
          end
     else
          Notify(_source,"FEJL: Kontakt en udvikler [FEJLKODE 1]", "error",tonumber(5000))
     end
end)

RegisterServerEvent("xmq:checkSellVeh")
AddEventHandler("xmq:checkSellVeh", function()
     local _source = source
     local user_id = vRP.getUserId({_source})
     local vehicles = MySQL.Sync.fetchAll('SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id', {user_id = user_id})
     if vehicles[1] ~= nil then
          TriggerClientEvent("xmq:openSellMenu", _source,vehicles)
     else
          Notify(_source,"Du har ikke noget at sælge", "error",tonumber(5000))
     end
end)

RegisterServerEvent("xmq:acceptSellDeal")
AddEventHandler("xmq:acceptSellDeal", function(name,price,model,type)
     local _source = source
     local user_id = vRP.getUserId({_source})
     if user_id ~= nil then
          MySQL.Sync.execute('DELETE FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle', {user_id = user_id, vehicle = model})
          Notify(_source,"Du solgte en "..firstToUpper(name).." for "..formatarNumero(price).."DKK", "success",tonumber(5000))
          vRP.giveBankMoney({user_id,price})
     else
          Notify(_source,"FEJL: Kontakt en udvikler [FEJLKODE 1]", "error",tonumber(5000))
     end
end)
