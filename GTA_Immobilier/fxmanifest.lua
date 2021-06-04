--- GTA_Immobilier 1.0 from RPF Studio by CedricAlPatch

fx_version 'cerulean'
game 'gta5'

name 'RageUI';
description 'RageUI, and a project specially created to replace the NativeUILua-Reloaded library. This library allows to create menus similar to the one of Grand Theft Auto online.'

client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",

    'config/config.lua',
    'client/client_main.lua',
    'client/client_menu.lua',
    'client/client_menu_storage.lua'
}

server_script '@mysql-async/lib/MySQL.lua'
server_script 'server/server.lua'