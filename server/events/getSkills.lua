--
-- ds-skills
-- server/events/getSkills.lua
-- by Jvson03
-- 

-- Event handler to load player skills when they spawn
lib.callback.register("ds-skills:server:getSkills", function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then return false end
    local citizenid = Player.PlayerData.citizenid

    if SkillData[citizenid] then
        return SkillData[citizenid]
    end

    local result = MySQL.query.await('SELECT skills FROM players WHERE citizenid = ?', { citizenid })

    if result and result[1].skills ~= '[]' then
        SkillData[citizenid] = CheckConfigForUpdates(result, citizenid)
        return SkillData[citizenid]
    end

    local tempTable = {}

    for i = 1, #Config.Skills do
        local skill = Config.Skills[i]
        tempTable[i] = {
            name = skill,
            level = 0,
            progress = 0
        }
    end

    MySQL.update.await('UPDATE players SET skills = ? WHERE citizenid = ?', { json.encode(tempTable), citizenid })

    SkillData[citizenid] = json.encode(tempTable)

    return SkillData[citizenid]
end)