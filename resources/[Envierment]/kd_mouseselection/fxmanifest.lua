fx_version 'cerulean' --bodacious, adamant
games { 'rdr3', 'gta5' }

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

lua54 'yes'

escrow_ignore {
    'Lang.lua',
    'Config.lua',
    'client/seat_cl.lua',
    'client/sleep_cl.lua',
}

client_scripts {
    'Config.lua',
    'client/contextmenu-c.lua',
    'client/menu-c.lua',
    'client/beautiful_cl.lua',
    'client/seat_cl.lua',
    'Lang.lua'
}

ui_page('html/index.html')

files {
    'beautiful_cl.lua',
    'html/index.html',
    'html/index.js',
    'html/index.css',
    'html/reset.css',
    'html/imgs/*.webp',
    'html/fonts/*.ttf'
}
dependency '/assetpacks'