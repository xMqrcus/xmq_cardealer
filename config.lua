config = {
    location = {-44.025882720947,-1098.4986572266,26.422328948975}, -- Hvor bilen du skal købe er
    heading = 70.0, -- Hvilken vej køretøjet vender når det spawner. Default: 70.0 

    selllocation = {-30.045528411865,-1105.1534423828,26.422359466553}, -- Hvor man skal kunne sælge sit køretøj
    sellprice = 0.75, -- Dette er hvor mange penge du får, hvis du sælger et køretøj tilbage til forhandleren, i forhold til nypris. 0.75 betyder 75% af nypris, altså halv pris
}



compact = {
    {name = "Blista", costs = 50000, type = "compact", model = "blista"},
    {name = "Blista Compact", costs = 40000, type = "compact", model = "blista2"},
    {name = "Brioso R/A", costs = 75000, type = "compact", model = "brioso"},
    {name = "Dilettante", costs = 50000, type = "compact", model = "Dilettante"},
    {name = "Issi", costs = 60000, type = "compact", model = "issi2"},
    {name = "Issi Classic", costs = 40000, type = "compact", model = "issi3"},
    {name = "Panto", costs = 60000, type = "compact", model = "panto"},
    {name = "Prairie", costs = 75000, type = "compact", model = "prairie"},
    {name = "Rhapsody", costs = 50000, type = "compact", model = "rhapsody"},
}

coupe = {
    {name = "Cognoscenti Cabrio", costs = 230000, type = "coupe", model = "cogcabrio"},
    {name = "F620", costs = 230000, type = "coupe", model = "f620"},
    {name = "Felon GT", costs = 190000, type = "coupe", model = "felon2"},
    {name = "Jackal", costs = 160000, type = "coupe", model = "jackal"},
    {name = "Oracle", costs = 360000, type = "coupe", model = "oracle"},
    {name = "Oracle XS", costs = 370000, type = "coupe", model = "oracle2"},
    {name = "Sentinel", costs = 130000, type = "coupe", model = "sentinel"},
    {name = "Sentinel XS", costs = 1500000, type = "coupe", model = "sentinel2"},
    {name = "Windsor", costs = 160000, type = "coupe", model = "windsor"},
    {name = "Windsor Drop", costs = 220000, type = "coupe", model = "windsor2"},
    {name = "Zion", costs = 110000, type = "coupe", model = "zion"},
    {name = "Zion Cabrio", costs = 130000, type = "coupe", model = "zion2"},
}

sedan = {
    {name = "Raiden", costs = 110000, type = "sedan", model = "raiden"},
    {name = "Asea", costs = 135000, type = "sedan", model = "asea"},
    {name = "Cognoscenti", costs = 220000, type = "sedan", model = "cognoscenti"},
    {name = "Cognoscenti 55", costs = 200000, type = "sedan", model = "cog55"},
    {name = "Glendale", costs = 180000, type = "sedan", model = "glendale"},
    {name = "Ingot", costs = 85000, type = "sedan", model = "ingot"},
    {name = "Intruder", costs = 120000, type = "sedan", model = "intruder"},
    {name = "Premier", costs = 150000, type = "sedan", model = "premier"},
    {name = "Primo", costs = 100000, type = "sedan", model = "primo"},
    {name = "Primo Custom", costs = 200000, type = "sedan", model = "primo2"},
    {name = "Regina", costs = 100000, type = "sedan", model = "regina"},
    {name = "Stanier", costs = 100000, type = "sedan", model = "stanier"},
    {name = "Stratum", costs = 100000, type = "sedan", model = "stratum"},
    {name = "Super Diamond", costs = 125000, type = "sedan", model = "superd"},
    {name = "Surge", costs = 240000, type = "sedan", model = "surge"},
    {name = "Tailgater", costs = 500000, type = "sedan", model = "tailgate"},
    {name = "Warrener", costs = 320000, type = "sedan", model = "warrener"},
    {name = "Washington", costs = 150000, type = "sedan", model = "washingt"},
}

sports = {
    {name = "Neon", costs = 850000, type = "sports", model = "neon"},
    {name = "Comet SR", costs = 650000, type = "sports", model = "comet5"},
    {name = "Comet", costs = 550000, type = "sports", model = "comet3"},
    {name = "Pariah", costs = 440000, type = "sports", model = "pariah"},
    {name = "Banshee", costs = 105000, type = "sports", model = "banshee"},
    {name = "Bestia GTS", costs = 610000, type = "sports", model = "bestiagts"},
    {name = "Buffalo", costs = 250000, type = "sports", model = "buffalo"},
    {name = "Buffalo S", costs = 32000, type = "sports", model = "buffalo2"},
    {name = "Carbonizzare", costs = 195000, type = "sports", model = "carbonizzare"},
    {name = "Coquette", costs = 638000, type = "sports", model = "coquette"},
    {name = "Elegy", costs = 850000, type = "sports", model = "elegy"},
    {name = "Sultan RS", costs = 720000, type = "sports", model = "sultanrs"},
    {name = "Drift Tampa", costs = 290000, type = "sports", model = "tampa2"},
    {name = "Feltzer", costs = 145000, type = "sports", model = "feltzer2"},
    {name = "Furore GT", costs = 448000, type = "sports", model = "furoregt"},
    {name = "Fusilade", costs = 150000, type = "sports", model = "fusilade"},
    {name = "Jester", costs = 240000, type = "sports", model = "jester"},
    {name = "Jester(Racerbil)", costs = 350000, type = "sports", model = "jester2"},
    {name = "Kuruma", costs = 820000, type = "sports", model = "kuruma"},
    {name = "Specter", costs = 120000, type = "coupe", model = "specter"},
    {name = "Specter CTM", costs = 130000, type = "coupe", model = "specter2"},
    {name = "Lynx", costs = 370000, type = "sports", model = "lynx"},
    {name = "Massacro", costs = 375000, type = "sports", model = "massacro"},
    {name = "Massacro(Racecar)", costs = 485000, type = "sports", model = "massacro2"},
    {name = "Omnis", costs = 701000, type = "sports", model = "omnis"},
    {name = "Penumbra", costs = 600000, type = "sports", model = "penumbra"},
    {name = "Rapid GT", costs = 132000, type = "sports", model = "rapidgt"},
    {name = "Rapid GT Convertible", costs = 140000, type = "sports", model = "rapidgt2"},
    {name = "Schafter V12", costs = 300000, type = "sports", model = "schafter3"},
    {name = "Surano", costs = 100000, type = "sports", model = "surano"},
    {name = "Tropos", costs = 800000, type = "sports", model = "tropos"},
    {name = "Verkierer", costs = 700000, type = "sports", model = "verlierer2"},
    {name = "Schlagen GT", costs = 730000, type = "sports", model = "Schlagen"},
    {name = "Khamelion", costs = 100000, type = "sports", model = "khamelion"},
    {name = "Raptor", costs = 648000, type = "sports", model = "raptor"},
    {name = "Ruston", costs = 430000, type = "sports", model = "ruston"},
    {name = "Dominator GTX", costs = 725000, type = "sports", model = "dominator3"},
}

sportsclassics = {
    {name = "Rapid GT", costs = 885000, type = "sportsclassics", model = "rapidgt3"},
    {name = "Retinue", costs = 615000, type = "sportsclassics", model = "retinue"},
    {name = "Torero", costs = 998000, type = "sportsclassics", model = "torero"},
    {name = "Cheetah Classic", costs = 865000, type = "sportsclassics", model = "cheetah2"},
    {name = "GT500", costs = 785000, type = "sportsclassics", model = "gt500"},
    {name = "Hermes", costs = 535000, type = "sportsclassics", model = "hermes"},
    {name = "Casco", costs = 904000, type = "sportsclassics", model = "casco"},
    {name = "Coquette Classic", costs = 665000, type = "sportsclassics", model = "coquette2"},
    {name = "Pigalle", costs = 400000, type = "sportsclassics", model = "pigalle"},
    {name = "Stinger", costs = 850000, type = "sportsclassics", model = "stinger"},
    {name = "Stinger GT", costs = 875000, type = "sportsclassics", model = "stingergt"},
    {name = "Stirling GT", costs = 975000, type = "sportsclassics", model = "feltzer3"},
    {name = "Z-Type", costs = 950000, type = "sportsclassics", model = "ztype"},
}

supers = {
    {name = "Adder", costs = 4100000, type = "supers", model = "adder"},
    {name = "Nero", costs = 3200000, type = "supers", model = "nero"},
    {name = "Nero X", costs = 2900000, type = "supers", model = "nero2"},
    {name = "Entity XF", costs = 3200000, type = "supers", model = "entityxf"},
    {name = "Entity XXR", costs = 4400000, type = "supers", model = "entity2"},
    {name = "Pfister 811", costs = 3100000, type = "supers", model = "pfister811"},
    {name = "Cyclone", costs = 2900000, type = "supers", model = "cyclone"},
    {name = "Reaper", costs = 3600000, type = "supers", model = "reaper"},
    {name = "Tyrant", costs = 5600000, type = "supers", model = "tyrant"},
}

muscle = {
    {name = "Blade", costs = 160000, type = "muscle", model = "blade"},
    {name = "Buccaneer", costs = 190000, type = "muscle", model = "buccaneer"},
    {name = "Chino", costs = 225000, type = "muscle", model = "chino"},
    {name = "Coquette BlackFin", costs = 695000, type = "muscle", model = "coquette3"},
    {name = "Dominator", costs = 350000, type = "muscle", model = "dominator"},
    {name = "Dukes", costs = 162000, type = "muscle", model = "dukes"},
    {name = "Hotknife", costs = 190000, type = "muscle", model = "hotknife"},
    {name = "Faction", costs = 136000, type = "muscle", model = "faction"},
    {name = "Nightshade", costs = 585000, type = "muscle", model = "nightshade"},
    {name = "Picador", costs = 100000, type = "muscle", model = "picador"},
    {name = "Sabre Turbo", costs = 500000, type = "muscle", model = "sabregt"},
    {name = "Tampa", costs = 375000, type = "muscle", model = "tampa"},
    {name = "Virgo", costs = 195000, type = "muscle", model = "virgo"},
}

offroad = {
    {name = "Kamacho", costs = 315000, type = "offroad", model = "kamacho"},
    {name = "Riata", costs = 325000, type = "offroad", model = "riata"},
    {name = "Streiter", costs = 235000, type = "offroad", model = "streiter"},
    {name = "Bifta", costs = 75000, type = "offroad", model = "bifta"},
    {name = "Blazer", costs = 10000, type = "offroad", model = "blazer"},
    {name = "Brawler", costs = 715000, type = "offroad", model = "brawler"},
    {name = "Bubsta 6x6", costs = 375000, type = "offroad", model = "dubsta3"},
    {name = "Dune Buggy", costs = 200000, type = "offroad", model = "dune"},
    {name = "Rebel", costs = 220000, type = "offroad", model = "rebel2"},
    {name = "Nagasaki Street Blazer", costs = 35000, type = "offroad", model = "blazer4"},
}

suv = {
    {name = "Baller", costs = 60000, type = "suv", model = "baller"},
    {name = "Baller 2", costs = 90000, type = "suv", model = "baller2"},
    {name = "Baller LE", costs = 200000, type = "suv", model = "baller3"},
    {name = "Baller LE LWD", costs = 200000, type = "suv", model = "baller4"},
    {name = "Dubsta", costs = 1245000, type = "suv", model = "dubsta"},
    {name = "Dubsta 2", costs = 249000, type = "suv", model = "dubsta2"},
    {name = "Toros", costs = 498000, type = "suv", model = "toros"},
    {name = "Contender", costs = 250000, type = "suv", model = "contender"},
    {name = "XLS", costs = 253000, type = "suv", model = "xls"},
    {name = "Rocoto", costs = 85000, type = "suv", model = "rocoto"},
}

varevogne = {
    {name = "Moonbeam", costs = 450000, type = "varevogne", model = "moonbeam2"},
    {name = "Yosemite", costs = 285000, type = "varevogne", model = "yosemite"},
    {name = "Bison", costs = 130000, type = "varevogne", model = "bison"},
    {name = "Bobcat XL", costs = 123000, type = "varevogne", model = "bobcatxl"},
    {name = "Gang Burrito", costs = 245000, type = "varevogne", model = "gburrito"},
    {name = "Journey", costs = 150000, type = "varevogne", model = "journey"},
    {name = "Minivan", costs = 300000, type = "varevogne", model = "minivan"},
    {name = "Paradise", costs = 250000, type = "varevogne", model = "paradise"},
    {name = "Rumpo", costs = 130000, type = "varevogne", model = "rumpo"},
    {name = "Surfer", costs = 110000, type = "varevogne", model = "surfer"},
    {name = "Youga", costs = 160000, type = "varevogne", model = "youga"},
    {name = "Granger", costs = 315000, type = "varevogne", model = "granger"},
}

mc = {
    {name = "Akuma", costs = 90000, type = "mc", model = "AKUMA"},
    {name = "Bagger", costs = 50000, type = "mc", model = "bagger"},
    {name = "Bati 801", costs = 150000, type = "mc", model = "bati"},
    {name = "Bati 801RR", costs = 150000, type = "mc", model = "bati2"},
    {name = "BF400", costs = 195000, type = "mc", model = "bf400"},
    {name = "Carbon RS", costs = 180000, type = "mc", model = "carbonrs"},
    {name = "Cliffhanger", costs = 325000, type = "mc", model = "cliffhanger"},
    {name = "Double T", costs = 112000, type = "mc", model = "double"},
    {name = "Faggio", costs = 14000, type = "mc", model = "faggio2"},
    {name = "Knallert", costs = 18000, type = "mc", model = "faggio"},
    {name = "Gargoyle", costs = 220000, type = "mc", model = "gargoyle"},
    --{name = "Daemon", costs = 100000, type = "compact", model = "daemon"},
    {name = "Innovation", costs = 190000, type = "mc", model = "innovation"},
    {name = "PCJ-600", costs = 90000, type = "mc", model = "pcj"},
    {name = "Zombie Chobber", costs = 385000, type = "mc", model = "zombieb"},
    {name = "Vindicator", costs = 600000, type = "mc", model = "vindicator"},
    {name = "Sanchez", costs = 100000, type = "mc", model = "sanchez"},
    {name = "Nightblade", costs = 400000, type = "mc", model = "nightblade"},
}

exclusive = {
    {name = "Annis ZR-350", costs = 1200000, type = "exclusive", model = "zr350"},
    {name = "Annis Remus", costs = 320000, type = "exclusive", model = "remus"},
    {name = "Annis Euros", costs = 700000, type = "exclusive", model = "euros"},
    {name = "Karin Calico", costs = 900000, type = "exclusive", model = "calico"},
    {name = "Jester RR", costs = 650000, type = "exclusive", model = "jester4"},
    {name = "Dinka 3000", costs = 530000, type = "exclusive", model = "rt3000"},
    {name = "Comet S2 Cabrio", costs = 900000, type = "exclusive", model = "comet5"},
    {name = "Growler", costs = 720000, type = "exclusive", model = "growler"},
    {name = "Dominator ASP", costs = 610000, type = "exclusive", model = "dominator7"},
    {name = "Sultan RS Classic", costs = 520000, type = "exclusive", model = "sultan3"},
}