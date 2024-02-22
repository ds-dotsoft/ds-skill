--
-- ds-skills
-- server/events/unloadData.lua
-- by Jvson03
-- 

RegisterNetEvent("ds-skills:server:unloadData", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then return end
    local citizenid = Player.PlayerData.citizenid

    if not SkillData[citizenid] then return end

    SaveSkills(citizenid)
    SkillData[citizenid] = nil
end)