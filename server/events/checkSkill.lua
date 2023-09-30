--
-- ds-skills
-- server/events/checkSkills.lua
-- by Jvson03
-- 

-- Event handler to load player skills when they spawn
lib.callback.register("ds-skills:server:checkSkill", function(source, skill)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then return false end

    if not skill then
        _d(function() Citizen.Trace("No Skill\n") end)
        return false
    end

    local citizenid = Player.PlayerData.citizenid

    local playerSkills = json.decode(SkillData[citizenid])

    for i = 1, #playerSkills do
        if playerSkills[i].name == skill then
            return json.encode(playerSkills[i])
        end
    end

    return false
end)