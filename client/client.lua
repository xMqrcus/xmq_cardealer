local active = false
local currName = ""
local currModel = ""
local currPrice = ""
local currType = ""

local currSellName = ""
local currSellModel = ""
local currSellPrice = ""
local currSellType = ""

askPlayer = false
askPlayerSell = false
local menuOpened = false


HT = nil
CreateThread(function()
    while HT == nil do
        TriggerEvent('HT_base:getBaseObjects', function(obj) HT = obj end)
        Wait(1000)
    end
    HT.UI.Menu.Close('default', GetCurrentResourceName(), "specificCategory")
    HT.UI.Menu.Close('default', GetCurrentResourceName(), "allCategories")
    HT.UI.Menu.Close('default', GetCurrentResourceName(), "sellMenu")
    while active do
        Wait(1)
		StartAudioScene('DLC_MPHEIST_TRANSITION_TO_APT_FADE_IN_RADIO_SCENE')
	end
end)

-------------------------- => KODE <= ----------------------------------

CreateThread(function()
    local ped = PlayerPedId()
    while true do
        Wait(1000)
        local distance = distance(config.location[1],config.location[2],config.location[3])
        if distance < 20 then
            if not active then
                active = true
                thread()
                thread2()
                Wait(500)
            end
        else
            if active then
                active = false
                Wait(500)
            end
        end
    end
end)
            

CreateThread(function()
    local categories = {
        compact, coupe, sedan, sports, sportsclassics, supers, muscle, offroad, suv, varevogne,exclusive, mc -- DETTE SKAL IKKE VÆRE STRINGS, MEN KATEGORIERNE SELV.
    }
    local randomCategory = categories[math.random(1, #categories)]
    local randomCar = randomCategory[math.random(1, #randomCategory)]
    local hashkey = GetHashKey(randomCar.model)
    local hashType = randomCar.type
	RequestModel(hashkey)
	while not HasModelLoaded(hashkey) do
		Wait(100)
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




function thread()
    CreateThread(function()
        while active do
            Wait(1)
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            SetVehicleDoorsLocked(veh, 2)
            SetEntityInvincible(veh, true)
            local getDist = distance(config.location[1],config.location[2],config.location[3])
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
            elseif distance(config.location[1],config.location[2],config.location[3]) > 20 and not IsPedInVehicle(ped,GetVehiclePedIsIn(ped,false)) and distance(-30.045528411865,-1105.1534423828,26.422359466553) > 3 then
                Wait(100)
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

            if distance(config.selllocation[1],config.selllocation[2],config.selllocation[3]) < 5 then
                DrawMarker(27, config.selllocation[1],config.selllocation[2],config.selllocation[3]-0.95,0,0,0,0,0,0,1.3,1.3,0.5,255,255,255,255,false, false, false, true, false, false, false)
            end
            if distance(config.selllocation[1],config.selllocation[2],config.selllocation[3]) < 1 and not IsPedInVehicle(ped,GetVehiclePedIsIn(ped,false)) and not askPlayerSell and not askPlayer then
                DisplayHelpText("~r~[G]~w~ Sælg køretøj")
                if IsControlJustPressed(0,47) then
                    TriggerServerEvent("xmq:checkSellVeh")
                end
            else
                HT.UI.Menu.Close('default', GetCurrentResourceName(), "sellMenu")
            end
        end
    end)
end

function thread2()
    CreateThread(function()
        while active do
            Wait(1)
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            dist = distance(-44.025882720947,-1098.4986572266,26.422328948975)
            if dist < 5 and not menuOpened then
                while IsControlPressed(0,174) and dist < 5 do
                    config.heading = config.heading+1
                    SetEntityHeading(veh,config.heading)
                    Wait(5)
                end
                while IsControlPressed(0,175) and dist < 5 do
                    config.heading = config.heading-1
                    SetEntityHeading(veh,config.heading)
                    Wait(5)
                end
            else
                Wait(150)
            end
        end
    end)
end

RegisterNetEvent("xmq:openSellMenu")
AddEventHandler("xmq:openSellMenu", function(sellTable)
    sellMenuTable = {}
    for _, t in ipairs{compact, coupe, sedan,sports,sportsclassics,supers,muscle,offroad,suv,varevogne,exclusive,mc} do
        for k,v in pairs(sellTable) do
            for i=1, #t, 1 do
                if v.vehicle == t[i].model then
                    table.insert(sellMenuTable,{label = firstToUpper(v.vehicle).." | "..formatarNumero(math.floor(t[i].costs * 0.5)).."DKK", costs = math.floor(t[i].costs / 2), model = t[i].model, display = t[i].name,type = t[i].type})
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