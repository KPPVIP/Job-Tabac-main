Config = {}

Config.Pos = { 
    RecolteBL = {
        vector3(2852.7727050781, 4586.6733398438, 47.285327911377-0.9) -- Récolte de Tabac Blond
    },
    RecolteBR = {
        vector3(2830.6247558594, 4590.3022460938, 46.679141998291-0.9) -- Récolte de Tabac Brun
    },
    TraitementBL = {
        vector3(2924.2451171875, 4478.2895507813, 48.168712615967-0.9) -- Traitement de Tabac Blond
    },
    TraitementBR = {
        vector3(2912.4008789063, 4475.560546875, 48.168724060059-0.9) -- Traitement de Tabac Brun
    },
    Creation = {
        vector3(2886.0219726563, 4498.9223632813, 48.152736663818-0.9) -- Création de cigarettes
    },
    Vente = {
        vector3(374.71472167969, 334.26089477539, 103.56639099121-0.9) -- Vente
    },   
    GarageVoiture = {
        vector3(2886.4343261719, 4394.6865234375, 50.748149871826-0.9) -- Pos Garage Voiture
    },
    Patron = {
        vector3(2901.2668457031, 4411.341796875, 50.28560256958-0.9) -- Pos Patron et blips 
    }
}

Config.Spawn = {
	spawnvoiture = {position = {x = 2882.9553222656, y = 4392.4106445313, z = 50.748191833496, h = 205.5614013671875}} -- Position point de spawn voiture
}

Config.Garage = {
    redwood = { -- Les véhicules dispo, possible de crée plusieurs ligne                                                     
        vehicules = {                                                           
            {category = "↓ ~b~Véhicules ~s~↓"},                           
			{model = "burrito3", label = "Van"},
            {category = "↓ ~b~Rangement ~s~↓"}
        },
    }
}

Config.Marker = { -- https://docs.fivem.net/docs/game-references/markers/
    Type = 6, -- Type de marker 
    Rotation = 360.0, -- Metter sur 0.0 pour remettre le marker droit
    ColorR = 149, -- Couleur du marker (R)
    ColorG = 40, -- Couleur du marker (G)
    ColorB = 14, -- Couleur du marker (B)
    Opacite = 280, -- Opacité du Marker 
    Saute = false, -- si le marker doit sauter mettre sur true
    Tourne = false, -- si le marker doit tourner mettre sur true
}

Config.Time = { -- Cette partit est très sensible
    Load = 0.0, -- Surtout pas toucher à cette partie 
    RecolteLoad = 0.0035, -- Temps de récolte
    TraitementLoad = 0.0035,
}

Config.Vente = {
    SocieteM = 125, -- Prix de vente de 1 marlboro côté société 
    SocieteG = 95 -- Prix de vente de 1 gitane côté société 
}