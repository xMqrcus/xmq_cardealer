fx_version 'cerulean'
game 'gta5'

dependency "vrp"

client_scripts {
	"lib/Proxy.lua",
    "lib/Tunnel.lua",
    'client/client.lua',
    'client/functions.lua',
    "config.lua"
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'lib/Proxy.lua',
    "@vrp/lib/utils.lua",
    'server.lua',
    "config.lua"
}

