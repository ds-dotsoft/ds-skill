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
	-- "@qb-core/shared/locale.lua",
    -- "locales/en.lua",
    -- "locales/*.lua"
}

client_scripts {
    -- "@PolyZone/client.lua",
    -- "@PolyZone/CircleZone.lua",
	"client/main.lua",
	"client/menu/*.lua"
	-- "client/events/*.lua"
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
	-- "locales/en.lua"
}

exports {
	'UpdateSkill',
	'GetSkill'
}

dependencies {
	"oxmysql",
	"qb-core"
}