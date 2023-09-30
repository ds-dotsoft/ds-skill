--
-- ds-skills
-- client/main.lua
-- by Jvson03
-- 

-- Globals

QBCore = exports["qb-core"]:GetCoreObject()

-- Functions

local function FetchSkills()
    lib.callback('ds-skills:server:getSkills', false, function(skills)
        if skills then
            local _skills = json.decode(skills)
            -- Do smth with the skills we fetched
            _d(function() Citizen.Trace(tostring(skills)) end)
        end
    end)
end

function UpdateSkill(skill, progress)
    lib.callback('ds-skills:server:updateSkill', false, function(skills)
        if skills then
            QBCore.Functions.Notify('You have earned ' .. progress .. ' XP in ' .. toUppercaseFirst(skill) .. '!', "primary", 5500)
            local skills = json.decode(skills)
            _d(function() Citizen.Trace(tostring(skills)) end)
        end
    end, skill, progress)
end

exports('UpdateSkill', UpdateSkill)

function GetSkill(skill)
    local data = lib.callback.await('ds-skills:server:checkSkill', false, skill)

    if data then
        return json.decode(data)
    end
end

exports('GetSkill', GetSkill)

-- Handlers

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    TriggerServerEvent('ds-skills:server:unloadData')
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    FetchSkills()
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        Wait(100)
        FetchSkills()
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        TriggerServerEvent('ds-skills:server:unloadData')
    end
end)

-- Debugging Commands

_d(function() RegisterCommand('givestaminaxp', function()
    local randomXP = math.random(1, 10)
    UpdateSkill('stamina', randomXP)
end, false) end)