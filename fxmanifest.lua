fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'The-Last-Knight @ Ks-Productions' 'https://discord.gg/7M7tZcKCrM'
description 'QBCore Modern HUD'
version '1.0.0'

shared_script 'config.lua'

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/styles.css',
    'html/script.js'
}
