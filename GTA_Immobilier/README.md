# GTA_Immobilier
Simple Agence immobilier avec npc pour recevoir vos clefs du logement avec l'envois de la position du logement 
WIP...

## Screen :
![Superette](https://media.discordapp.net/attachments/700050943995281452/833825046560636938/218_20210419194940_1.png?width=948&height=519)


### Requirements
* Ninja Source
  * [nCoreGTA](https://github.com/NinjaSourceV2/nCoreGTA)
* ajoutez les lignes suivente dans le Config
    ["Clef_1"] = {label = "Studio", weight = 1, type = "medical", prop = "prop_syringe_01"},
    ["Clef_2"] = {label = "Appart", weight = 1, type = "medical", prop = "prop_syringe_01"},
    ["Clef_3"] = {label = "Maison", weight = 1, type = "medical", prop = "prop_syringe_01"},


## Installation
- Ajouté le dossier GTA_Immobilier dans vos resource, puis ajouté le a la liste de votre server.cfg.
- Ajouté le Fichier SQL a votre base de donnée et profité.

## Features
- RageUIV2
- Immobilier configurable items ( clefs ), prix, pos, ped.


## Tuto
- Tout se trouve dans le fichier config.lua vous pourrez modifier les items, prix, position des agences

```
    ensure GTA_Immobilier
```

## License :
@cedricalpatch