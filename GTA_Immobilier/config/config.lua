
--________________________________________________________________
--/////////////////// Config : Dont misc change all position for Los Santos!!!!!


Config = {
    Locations = {
        [1] = {
            ["sPed"] = {
                 ["x"] = -95.72, ["y"] = 1433.78, ["z"] = 13.70, ["h"] = 360.82 ---- buy housse
            },
            ["homeIn"] = {
                ["x"] = -82.832, ["y"] = 1436.98, ["z"] = 15.608, ["h"] =314.65 ---- Out marker
            },
            ["homeOut"] = {
                ["x"] = -83.12, ["y"] = 1437.17, ["z"] = 118.68, ["h"] = 137.0 ---- In Marker
            },
            ["storage"] = {
                ["x"] = -249.5049, ["y"] = 2034.0004, ["z"] = 15.0, ["h"] = 0.0 ---- Sell storage in housse position
            },
            ["key"] = {
               ["clef"] = "Clef_1" --- name of item for key of home, this can tobe name of housse
            },
            ["clefs"] = {
                itemNameStudio = {"Clef_1"},--- key of home
                itemNameAppart = {},
                itemNameMaison = {},
                prix = {100000},
                pos = {
                   Clef_1 = {["x"] = -82.832, ["y"] = 1436.98, ["z"] = 15.608}, ---- Destination blip when you buy. you need change x,y,z 
                   Clef_2 = {["x"] = 290.54, ["y"] = 248.38, ["z"] = 9.07}, ---- Destination blip when you buy. you need change x,y,z 
                   Clef_3 = {["x"] = -1069.8228, ["y"] = 2487.7964, ["z"] = 35.6648}, ---- Destination blip when you buy. you need change x,y,z 
                }
            },
        },
        [2] = {
            ["sPed"] = {
                 ["x"] = 291.9534, ["y"] = 236.7159, ["z"] =  8.0762, ["h"] = 273.1099 ---- buy housse
            },
            ["homeIn"] = {
                 ["x"] = 290.54, ["y"] = 248.38, ["z"] = 9.07, ["h"] = 360.82 ---- buy housse
            },
            ["homeOut"] = {
                ["x"] = 258.60, ["y"] = 214.28, ["z"] =  152.27, ["h"] = 137.0 ---- In Marker
            },
            ["storage"] = {
                ["x"] = 262.3597, ["y"] = 196.3016, ["z"] = 151.6733, ["h"] = 0.0 ---- Sell storage in housse position
            },
            ["key"] = {
               ["clef"] = "Clef_2" --- name of item for key of home, this can tobe name of housse
            },
            ["clefs"] = {
                itemNameStudio = {},--- key of home
                itemNameAppart = {"Clef_2"},
                itemNameMaison = {},
                prix = {1000000},
                pos = {
                    Clef_1 = {["x"] = -82.832, ["y"] = 1436.98, ["z"] = 15.608}, ---- Destination blip when you buy. you need change x,y,z 
                    Clef_2 = {["x"] = 290.54, ["y"] = 248.38, ["z"] = 9.07}, ---- Destination blip when you buy. you need change x,y,z 
                    Clef_3 = {["x"] = -1069.8228, ["y"] = 2487.7964, ["z"] = 35.6648}, ---- Destination blip when you buy. you need change x,y,z 
                }
            },
        },
        [3] = {
            ["sPed"] = {
                 ["x"] = -1073.2488, ["y"] = 2484.1514, ["z"] = 34.531, ["h"] =  182.4892 ---- buy housse
            },
            ["homeIn"] = {
                 ["x"] = -1069.8228, ["y"] = 2487.7964, ["z"] = 35.6648, ["h"] = 360.82 ---- buy housse
            },
            ["homeOut"] = {
                ["x"] = -1075.648, ["y"] = 2505.2869, ["z"] = 36.5739, ["h"] = 137.0 ---- In Marker
            },
            ["storage"] = {
                ["x"] = -249.5049, ["y"] = 2034.0004, ["z"] = 15.0, ["h"] = 0.0 ---- Sell storage in housse position
            },
            ["key"] = {
               ["clef"] = "Clef_3" --- name of item for key of home, this can tobe name of housse
            },
            ["clefs"] = {
                itemNameStudio = {},--- key of home
                itemNameAppart = {},
                itemNameMaison = {"Clef_3"},
                prix = {10000000},
                pos = {
                    Clef_1 = {["x"] = -82.832, ["y"] = 1436.98, ["z"] = 15.608}, ---- Destination blip when you buy. you need change x,y,z 
                    Clef_2 = {["x"] = 290.54, ["y"] = 248.38, ["z"] = 9.07}, ---- Destination blip when you buy. you need change x,y,z 
                    Clef_3 = {["x"] = -1069.8228, ["y"] = 2487.7964, ["z"] = 35.6648}, ---- Destination blip when you buy. you need change x,y,z 
                }
            },
        },

    },
}

Config.Stockage = {}