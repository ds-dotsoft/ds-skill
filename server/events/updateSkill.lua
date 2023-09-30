--
-- ds-skills
-- server/events/updateSkills.lua
-- by Jvson03
-- 

-- Event handler to load player skills when they spawn
lib.callback.register("ds-skills:server:updateSkill", function(source, skill, progress)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then return false end

    if not skill or not progress then return false end

    local citizenid = Player.PlayerData.citizenid

    local playerSkills = json.decode(SkillData[citizenid])

    for i = 1, #playerSkills do
        if playerSkills[i].name == skill then
            playerSkills[i].progress = playerSkills[i].progress + progress

            if playerSkills[i].progress >= 100 then
                playerSkills[i].level = playerSkills[i].level + 1
                playerSkills[i].progress = 0
            end
        end
    end

    SkillData[citizenid] = json.encode(playerSkills)

    return SkillData[citizenid]
end)