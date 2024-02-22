-- server/events/getSkills.lua

lib.callback.register("ds-skills:server:getSkills", function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then
        print("Error: Player not found for source", src)
        return false
    end

    local citizenid = Player.PlayerData.citizenid

    if SkillData[citizenid] then
        return SkillData[citizenid]
    end

    local result, err = MySQL.query.await("SELECT skills FROM players WHERE citizenid = ?", { citizenid })
    if err then
        print("Database Error: ", err)
        return false
    end

    if result and result[1] and result[1].skills ~= "[]" then
        SkillData[citizenid] = CheckConfigForUpdates(result, citizenid)
        return SkillData[citizenid]
    else
        InitializeSkillsForPlayer(citizenid)
        return SkillData[citizenid]
    end
end)

-- Additional function for initializing skills
function InitializeSkillsForPlayer(citizenid)
    local tempTable = {}
    for i, skill in ipairs(Config.Skills) do
        tempTable[i] = {name = skill, level = 0, progress = 0}
    end

    local skillsJSON = json.encode(tempTable)
    local updateResult, updateErr = MySQL.update.await("UPDATE players SET skills = ? WHERE citizenid = ?", { skillsJSON, citizenid })
    if updateErr then
        print("Database Update Error: ", updateErr)
        return
    end

    SkillData[citizenid] = skillsJSON
end
