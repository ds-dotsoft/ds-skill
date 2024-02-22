--
-- ds-skills
-- fxmanifest.lua
-- by Jvson03
-- 

fx_version "cerulean"
game "gta5"

lua54 "yes"

name "Dotsoft Skills"
author "DotSoft"
version "1.0.0"

shared_scripts {
	"@ox_lib/init.lua",
	"config.lua",
	"shared/utils.lua",
}

client_scripts {
	"client/main.lua",
	"client/menu/*.lua"
}

server_scripts {
	"@oxmysql/lib/MySQL.lua",
	"server/main.lua",
	"server/config/*.lua",
	"server/events/*.lua"
}

escrow_ignore {
	"config.lua",
	"server/config/*.lua"
}

exports {
	'UpdateSkill',
	'GetCurrentSkill'
}

dependencies {
	"oxmysql",
	"ox_lib",
	"qb-core"
}