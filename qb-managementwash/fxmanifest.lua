fx_version 'bodacious'
author 'teig'
description 'qb-managementwash (Made by teig)'
games { 'gta5' }

client_script {'client/client.lua'
}
server_script {'server/server.lua',    '@oxmysql/lib/MySQL.lua',}


escrow_ignore {
    "config.lua",
    'locales/en.lua',
    'locales/no.lua',
    'client/client.lua',
    'server/server.lua',
    'wash_database.sql'
}
shared_script { 	'@qb-core/shared/locale.lua',
'config.lua',
'locales/en.lua',
}


lua54 'yes'
