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

RegisterNetEvent("cardealer:sendnotify", function(msg)
    HT.ShowNotification(msg)
end)

HT = nil

Citizen.CreateThread(function()
    while HT == nil do
        TriggerEvent('HT_base:getBaseObjects', function(obj) HT = obj end)
        Citizen.Wait(0)
    end
    HT.UI.Menu.Close('default', GetCurrentResourceName(), "specificCategory")
    HT.UI.Menu.Close('default', GetCurrentResourceName(), "allCategories")
    HT.UI.Menu.Close('default', GetCurrentResourceName(), "sellMenu")
    while true do
		StartAudioScene('DLC_MPHEIST_TRANSITION_TO_APT_FADE_IN_RADIO_SCENE') 
		Citizen.Wait(0)
        SetAudioFlag("DisableFlightMusic", true)
	end
end)

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
-------------------------- => KODE <= ----------------------------------
currName = ""
currModel = ""
currPrice = ""
currType = ""

currSellName = ""
currSellModel = ""
currSellPrice = ""
currSellType = ""

askPlayer = false
askPlayerSell = false
menuOpened = false
Citizen.CreateThread(function()
    local categories = {
        compact, coupe, sedan, sports, sportsclassics, supers, muscle, offroad, suv, varevogne,exclusive, mc -- DETTE SKAL IKKE VÆRE STRINGS, MEN KATEGORIERNE SELV.
    }
    local randomCategory = categories[math.random(1, #categories)]
    local randomCar = randomCategory[math.random(1, #randomCategory)]
    local hashkey = GetHashKey(randomCar.model)
    local hashType = randomCar.type
	RequestModel(hashkey)
	while not HasModelLoaded(hashkey) do
		Citizen.Wait(100)
	end
	spawnCurrentVehicle(hashkey,hashType)
    checkSpeed(false,hashkey,false,hashType)
    for _, t in ipairs{compact, coupe, sedan,sports,sportsclassics,supers,muscle,offroad,suv,varevogne,exclusive,mc} do
        for i=1, #t, 1 do
            if t[i].model == randomCar.model then
                currName = t[i].name
                currPrice = t[i].costs
                currType = t[i].type
                currModel = t[i].model
            end
        end
    end
end)

function spawnCurrentVehicle(hashk,type)
    RequestModel(hashk)
	while not HasModelLoaded(hashk) do
		Citizen.Wait(50)
	end
    if veh == nil then
        veh = CreateVehicle(hashk,config.location[1],config.location[2],config.location[3],config.heading,false,false)
    else
        DeleteEntity(veh)
        Citizen.Wait(20)
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

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        SetVehicleDoorsLocked(veh, 2)
        SetEntityInvincible(veh, true)
        getDist = GetDistanceBetweenCoords(coords,config.location[1],config.location[2],config.location[3])
        if getDist < 20 then
            DrawMarker(1, config.location[1],config.location[2],config.location[3]-0.95,0,0,0,0,0,0,9.2,9.2,0.5,255,255,255,255,false, false, false, true, false, false, false)
        end
        if getDist < 5 and not IsPedInVehicle(ped,GetVehiclePedIsIn(ped,false)) then
            DrawText3Ds(config.location[1],config.location[2],config.location[3]+0.85,"Model: "..currName)
            DrawText3Ds(config.location[1],config.location[2],config.location[3]+0.95,"Pris: "..formatarNumero(currPrice).."DKK")
            DrawText3Ds(config.location[1],config.location[2],config.location[3]+1.05,"Estimeret topfart: "..checkSpeed(true).." KMT")
            if menuOpened == false and askPlayer == false then
                DisplayHelpText([[~r~[E]~w~ Åbn kataloget
~r~[G]~w~ Køb køretøj
~r~[←- -→]~w~ Roter køretøj]])
                SetPlayerMayNotEnterAnyVehicle(PlayerPedId())
            end
            if menuOpened == true and askPlayer == false then
                DisplayHelpText("~r~[G]~w~ Køb køretøj")
                DisableControlAction(0, 140, true)
            end
            if IsControlJustReleased(0,38) and askPlayer == false then
                openCategoryMenu()
                menuOpened = true
            end
            if IsControlJustPressed(0,177) or IsControlJustPressed(0,1) then
                HT.UI.Menu.Close('default', GetCurrentResourceName(), "specificCategory")
                HT.UI.Menu.Close('default', GetCurrentResourceName(), "allCategories")
                menuOpened = false
            end
            if IsControlJustPressed(0,47) then
                HT.UI.Menu.Close('default', GetCurrentResourceName(), "specificCategory")
                HT.UI.Menu.Close('default', GetCurrentResourceName(), "allCategories")
                TriggerServerEvent("xmq:checkForBuyVehicle", currName , currPrice , currModel,currType)
            end
        elseif GetDistanceBetweenCoords(coords,config.location[1],config.location[2],config.location[3]) > 20 and not IsPedInVehicle(ped,GetVehiclePedIsIn(ped,false)) and GetDistanceBetweenCoords(coords,-30.045528411865,-1105.1534423828,26.422359466553) > 3 then
            Citizen.Wait(100)
            HT.UI.Menu.Close('default', GetCurrentResourceName(), "specificCategory")
            HT.UI.Menu.Close('default', GetCurrentResourceName(), "allCategories")
            menuOpened = false
            askPlayer = false
        end
        if askPlayer == true then
            DisplayHelpText([[~r~[ENTER]~w~ Accepter handel
~r~[BACKSPACE]~w~ Afbryd handlen]])
            if IsControlJustPressed(0,191) and not menuOpened then
                TriggerServerEvent("xmq:acceptDeal", currName, currPrice, currModel, currType)
                HT.UI.Menu.Close('default', GetCurrentResourceName(), "specificCategory")
                HT.UI.Menu.Close('default', GetCurrentResourceName(), "allCategories")
                askPlayer = false
            end
            if IsControlJustPressed(0,194) then
                HT.UI.Menu.Close('default', GetCurrentResourceName(), "specificCategory")
                HT.UI.Menu.Close('default', GetCurrentResourceName(), "allCategories")
                askPlayer = false
            end
        end

        if askPlayerSell == true then
            DisplayHelpText([[~r~[ENTER]~w~ Accepter handel
~r~[BACKSPACE]~w~ Afbryd handlen]])
            if IsControlJustPressed(0,191) and not menuOpened then
                TriggerServerEvent("xmq:acceptSellDeal", currSellName, currSellPrice, currSellModel, currSellType)
                HT.UI.Menu.Close('default', GetCurrentResourceName(), "specificCategory")
                HT.UI.Menu.Close('default', GetCurrentResourceName(), "allCategories")
                HT.UI.Menu.Close('default', GetCurrentResourceName(), "sellMenu")
                askPlayerSell = false
            end
            if IsControlJustPressed(0,194) and not menuOpened then
                HT.UI.Menu.Close('default', GetCurrentResourceName(), "specificCategory")
                HT.UI.Menu.Close('default', GetCurrentResourceName(), "allCategories")
                HT.UI.Menu.Close('default', GetCurrentResourceName(), "sellMenu")
                askPlayerSell = false
            end
        end

        if GetDistanceBetweenCoords(coords,-30.045528411865,-1105.1534423828,26.422359466553) < 5 then
            DrawMarker(27, -30.045528411865,-1105.1534423828,26.422359466553-0.95,0,0,0,0,0,0,1.3,1.3,0.5,255,255,255,255,false, false, false, true, false, false, false)
        end
        if GetDistanceBetweenCoords(coords,-30.045528411865,-1105.1534423828,26.422359466553) < 1 and not IsPedInVehicle(ped,GetVehiclePedIsIn(ped,false)) and not askPlayerSell then
            DisplayHelpText("~r~[G]~w~ Sælg køretøj")
            if IsControlJustPressed(0,47) then
                TriggerServerEvent("xmq:checkSellVeh")
            end
        else
            HT.UI.Menu.Close('default', GetCurrentResourceName(), "sellMenu")
        end
    end
end)


buyName = ""
buyPrice = 0
buyModel = ""
RegisterNetEvent("askPlayer")
AddEventHandler("askPlayer", function(name,price,model,currType)
    askPlayer = true

    buyName = name
    buyPrice = price
    buyModel = model
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        if GetDistanceBetweenCoords(coords,-44.025882720947,-1098.4986572266,26.422328948975) < 5 and not menuOpened then
            while IsControlPressed(0,174) and getDist < 5 do
                config.heading = config.heading+0.5
                SetEntityHeading(veh,config.heading)
                Citizen.Wait(5)
            end
            while IsControlPressed(0,175) and getDist < 5 do
                config.heading = config.heading-0.5
                SetEntityHeading(veh,config.heading)
                Citizen.Wait(5)
            end
        else
            Citizen.Wait(150)
        end
    end
end)

RegisterNetEvent("xmq:openSellMenu")
AddEventHandler("xmq:openSellMenu", function(sellTable)
    sellMenuTable = {}
    for _, t in ipairs{compact, coupe, sedan,sports,sportsclassics,supers,muscle,offroad,suv,varevogne,exclusive,mc} do
        for k,v in pairs(sellTable) do
            for i=1, #t, 1 do
                if v.vehicle == t[i].model then
                    table.insert(sellMenuTable,{label = firstToUpper(v.vehicle).." | "..formatarNumero(math.floor(t[i].costs / 2)).."DKK", costs = math.floor(t[i].costs / 2), model = t[i].model, display = t[i].name,type = t[i].type})
                end
            end
        end
    end
    HT.UI.Menu.Open('default', GetCurrentResourceName(), "sellMenu",
        {
            title    = "Sælg køretøj",
            align    = "right",
            elements = sellMenuTable
        },
    function(data, menu)
        menu = menu
        currSellModel = data.current.model
        currSellName = data.current.display
        currSellPrice = data.current.costs
        currSellType = data.current.type
        askPlayerSell = true
        HT.UI.Menu.Close('default', GetCurrentResourceName(), "specificCategory")
        HT.UI.Menu.Close('default', GetCurrentResourceName(), "allCategories")
        HT.UI.Menu.Close('default', GetCurrentResourceName(), "sellMenu")
        menu.close()
    end, function(data, menu)
        menu.close()
    end)
end)

function openCategoryMenu()
    local elements = {
        {label = "Kompakte", tab = "compact"},
        {label = "Coupéer", tab = "coupe"},
        {label = "Sedan", tab = "sedan"},
        {label = "Sportsbiler", tab = "sports"},
        {label = "Sportsklassikere", tab = "sportsclassics"},
        {label = "Superbiler", tab = "supers"},
        {label = "Muskelbiler", tab = "muscle"},
        {label = "Offroad", tab = "offroad"},
        {label = "SUV", tab = "suv"},
        {label = "Varevogne", tab = "varevogne"},
        {label = "Eksklusive", tab = "exclusive"},
        {label = "Motorcykler", tab = "mc"},
    }
    -- tables --
    HT.UI.Menu.Open('default', GetCurrentResourceName(), "allCategories",
        {
            title    = "Bilforhandler",
            align    = "right",
            elements = elements
        },
    function(data, menu)
        menu = menu
        local menutype = data.current.tab

        local tab = {}
        for _, t in ipairs{compact, coupe, sedan,sports,sportsclassics,supers,muscle,offroad,suv,varevogne,exclusive,mc} do
            for i=1, #t, 1 do
                if t[i].type == menutype then
                    table.insert(tab, {label = t[i].name.." | " .. formatarNumero(t[i].costs).."DKK | #"..i, model = t[i].model, costs = t[i].costs, display = t[i].name,type = t[i].type})
                end
            end
        end

        specificCategoryMenu(tab)
        menu.close()
    end, function(data, menu)
        menu.close()
    end)
end

function specificCategoryMenu(tabol)
    local elements = tabol
    HT.UI.Menu.Open('default', GetCurrentResourceName(), "specificCategory",
        {
            title    = "Bilforhandler",
            align    = "right",
            elements = elements
        },
    function(data, menu)
        menu = menu
    end, function(data, menu)
      menu.close()
      HT.UI.Menu.Close('default', GetCurrentResourceName(), "specificCategory")
      HT.UI.Menu.Close('default', GetCurrentResourceName(), "allCategories")
      HT.UI.Menu.Close('default', GetCurrentResourceName(), "sellMenu")
    end, function(data, menu)
        local currentCar = data.current.model
        local hashCar = GetHashKey(currentCar)
        spawnCurrentVehicle(hashCar,data.current.type)
        currModel = currentCar
        currPrice = data.current.costs
        currName = data.current.display
        currType = data.current.type
    end)
end

RegisterCommand("carstats", function(source, args)
    if args[1] ~= nil then
        for _, t in ipairs{compact, coupe, sedan,sports,sportsclassics,supers,muscle,offroad,suv,varevogne,exclusive,mc} do
            for i=1, #t, 1 do
                if string.lower(args[1]) == string.lower(t[i].name) then
                    carStatsMenu(t[i].name,t[i].costs,t[i].model)
                end
            end
        end
    else
        local car = GetHashKey(GetVehiclePedIsIn(PlayerPedId(),false))
        local inCarName = GetDisplayNameFromVehicleModel(car)
        for _, t in ipairs{compact, coupe, sedan,sports,sportsclassics,supers,muscle,offroad,suv,varevogne,exclusive,mc} do
            for i=1, #t, 1 do
                if string.lower(inCarName) == string.lower(t[i].model) then
                    carStatsMenu(t[i].name,t[i].costs,t[i].model)
                end
            end
        end
    end
end)

RegisterNetEvent("resetPlayer")
AddEventHandler("resetPlayer", function()
    askPlayer = false
    askPlayerSell = false
    menuOpened = false
end)

function carStatsMenu(name,price,model)
    local elements = {
        {label = "Model: "..name},
        {label = "Nypris: "..formatarNumero(price).."DKK"},
        {label = "Topfart: "..round(GetVehicleModelEstimatedMaxSpeed(model) * 3.6,1).." KMT"},
    }

    HT.UI.Menu.Open('default', GetCurrentResourceName(), "carstats",
        {
            title    = "Bil Information",
            align    = "left",
            elements = elements
        },
    function(data, menu)
        menu = menu

    end, function(data, menu)
      menu.close()
    end)
end

RegisterCommand("car", function(source, args)
    local pc = GetEntityCoords(PlayerPedId())
    ph = GetEntityHeading(PlayerPedId())
    px = pc[1]
    py = pc[2]
    pz = pc[3]
    HT.TriggerServerCallback("hasGroup", function(cb)
        if cb then
            if args then
                if not args[2] then
                    local car = GetHashKey(args[1])
                    RequestModel(car)
                    while not HasModelLoaded(car) do
                        Citizen.Wait(50)
                    end
                    local ypc = CreateVehicle(car,px,py,pz,ph,true,false)
                    TaskWarpPedIntoVehicle(PlayerPedId(),ypc,-1)
                end
                if args[2] then
                    print("hej")
                    for i = 1, args[2], 1 do
                        local car = GetHashKey(args[1])
                        RequestModel(car)
                        while not HasModelLoaded(car) do
                            Citizen.Wait(50)
                        end
                        local yc = CreateVehicle(car,px,py+3,pz,ph,true,false)
                        local py = GetEntityCoords(yc)[1]
                        print("newpy = "..py)
                    end
                    print(px,py,pz,ph)
                end
            end
        end
    end, "Ejer")
end)