RegisterNetEvent("cardealer:sendnotify", function(msg)
   HT.ShowNotification(msg)
end)

function DrawText3Ds(x,y,z, text)
   local onScreen,_x,_y=World3dToScreen2d(x,y,z)
   local px,py,pz=table.unpack(GetGameplayCamCoords())
   SetTextScale(0.35, 0.35)
   SetTextFont(6)
   SetTextProportional(1)
   SetTextColour(255, 255, 255, 215)
   SetTextOutline()
   SetTextEntry("STRING")
   SetTextCentre(1)
   AddTextComponentString(text)
   DrawText(_x,_y)
end

function drawTxt(text, font, centre, x, y, scale, r, g, b, a)
   SetTextFont(font)
   SetTextProportional(0)
   SetTextScale(scale, scale)
   SetTextColour(r, g, b, a)
   SetTextDropShadow(0, 0, 0, 0, 255)
   SetTextEdge(1, 0, 0, 0, 255)
   SetTextDropShadow()
   SetTextOutline()
   SetTextCentre(centre)
   SetTextEntry("STRING")
   AddTextComponentString(text)
   DrawText(x, y+0.1)
end

function round(num, dec)
  local mult = 10^(dec or 0)
  return math.floor(num * mult + 0.5) / mult
end
function firstToUpper(str)
  return (str:gsub("^%l", string.upper))
end
function DisplayHelpText(str)
  BeginTextCommandDisplayHelp("STRING")
  AddTextComponentSubstringPlayerName(str)
  EndTextCommandDisplayHelp(0, 0, 1, -1)
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
function spawnCurrentVehicle(hashk,type)
   RequestModel(hashk)
  while not HasModelLoaded(hashk) do
     Wait(50)
  end
   if veh == nil then
       veh = CreateVehicle(hashk,config.location[1],config.location[2],config.location[3],config.heading,false,false)
   else
       DeleteEntity(veh)
       Wait(20)
       veh = CreateVehicle(hashk,config.location[1],config.location[2],config.location[3],config.heading,false,false)
       checkSpeed(false,hashk,false,type)
   end
end
vehspeed = 0
function checkSpeed(bool, hash, bool2, type)
   if bool == true and hash == nil and bool2 == nil and type == nil then
       return vehspeed
   end
   if bool == false and hash ~= nil and bool2 == false and type ~= nil then
       if type == "sports" or type == "sportsclassics" or type == "supers" or type == "muscle" then
           vehspeed = round(GetVehicleModelEstimatedMaxSpeed(hash) * 3.6,1)
       else
           vehspeed = round(GetVehicleModelEstimatedMaxSpeed(hash) * 3.85,1)
       end
   end
   if bool == false and hash == false and bool2 == true then
       return currModel
   end
end

RegisterNetEvent("askPlayer")
AddEventHandler("askPlayer", function(name,price,model)
  askPlayer = true

  buyName = name
  buyPrice = price
  buyModel = model
end)

function distance(x,y,z)
   local dist = #(GetEntityCoords(PlayerPedId()) - vector3(x,y,z))
   return dist
end