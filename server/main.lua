--
-- ds-skills
-- server/main.lua
-- by Jvson03
-- 

-- Globals

QBCore = exports["qb-core"]:GetCoreObject()
SkillData = {}

-- Functions

function CheckConfigForUpdates(result, citizenid)
    local playerSkills = json.decode(result[1].skills)

    for i = 1, #Config.Skills do
        local skill = Config.Skills[i]
        local found = false

        for j = 1, #playerSkills do
            if playerSkills[j].name == skill then
                found = true
            end
        end

        if not found then
            table.insert(playerSkills, {
                name = skill,
                level = 0,
                progress = 0
            })
        end
    end

    MySQL.update.await("UPDATE players SET skills = ? WHERE citizenid = ?", { json.encode(playerSkills), citizenid })

    return json.encode(playerSkills)
end

function SaveSkills(citizenid)
    local playerSkills = json.decode(SkillData[citizenid])

    MySQL.update.await("UPDATE players SET skills = ? WHERE citizenid = ?", { json.encode(playerSkills), citizenid })
end

-- Handlers

AddEventHandler("playerDropped", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then return end
    local citizenid = Player.PlayerData.citizenid

    if not SkillData[citizenid] then return end

    SaveSkills(citizenid)
    SkillData[citizenid] = nil

    _d(function() Citizen.Trace(string.format("saved skills for " .. citizenid .. "\n")) end)
end)