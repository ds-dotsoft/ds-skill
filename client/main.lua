--
-- ds-skills
-- client/main.lua
-- by Jvson03
-- 

-- Globals

QBCore = exports["qb-core"]:GetCoreObject()

-- Functions

local function decodeJSON(jsonString)
    local decoded, pos, msg = json.decode(jsonString)
    if not decoded then
        print("JSON decode error at position "..tostring(pos)..": "..tostring(msg))
        return nil
    end
    return decoded
end

local function FetchSkills()
    lib.callback("ds-skills:server:getSkills", false, function(skills)
        if skills then
            local _skills = decodeJSON(skills)
            if not _skills then
                lib.notify({title = "Error", description = "Failed to decode skills data!", type = "error", duration = 5000})
                return
            end
            -- Do smth with the skills we fetched
            _d(function() Citizen.Trace(tostring(_skills)) end)
        else
            lib.notify({title = "Error", description = "Failed to fetch skills!", type = "error", duration = 5000})
        end
    end)
end

function UpdateSkill(skill, progress)
    lib.callback("ds-skills:server:updateSkill", false, function(skills)
        if skills then
            local _skills = decodeJSON(skills)
            if not _skills then
                lib.notify({title = "Error", description = "Failed to decode updated skills data!", type = "error", duration = 5000})
                return
            end
            lib.notify({
                title = "Skill Progress",
                description = "You have earned " .. progress .. " XP in " .. toUppercaseFirst(skill) .. "!",
                type = "success",
                duration = 5500
            })            
            _d(function() Citizen.Trace(tostring(_skills)) end)
        else
            lib.notify({title = "Error", description = "Failed to update skill!", type = "error", duration = 5000})
        end
    end, skill, progress)
end

exports("UpdateSkill", UpdateSkill)

function GetCurrentSkill(skillToCheck)
    local data = lib.callback.await("ds-skills:server:checkSkill", false, skillToCheck)

    if data then
        return json.decode(data)
    end
end

exports("GetCurrentSkill", GetCurrentSkill)

-- Handlers

RegisterNetEvent("QBCore:Client:OnPlayerUnload", function()
    TriggerServerEvent("ds-skills:server:unloadData")
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    FetchSkills()
end)

AddEventHandler("onResourceStart", function(resource)
    if resource == GetCurrentResourceName() then
        Wait(100)
        FetchSkills()
    end
end)

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        TriggerServerEvent("ds-skills:server:unloadData")
    end
end)

-- Debugging Commands

_d(function() RegisterCommand("givestaminaxp", function()
    local randomXP = math.random(1, 10)
    -- exports["ds_skills"]:UpdateSkill("stamina", randomXP)
    UpdateSkill("stamina", randomXP)
end, false) end)