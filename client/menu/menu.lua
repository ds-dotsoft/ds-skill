--
-- ds-skills
-- client/menu.lua
-- by Jvson03
-- 

-- Locals

local menuOpen = false

-- Keybinds

RegisterCommand("+skillsmenu", function()
    if menuOpen then return end
    lib.callback("ds-skills:server:getSkills", false, function(skills)
        if skills then
            local _skills = json.decode(skills)

            local elements = {
                {
                    header = "Skills Menu",
                    isMenuHeader = true,
                },
            }
        
            -- Loop through the skills data and add elements to the menu
            for _, skill in pairs(_skills) do
                local skillName = skill.name
                local skillLevel = skill.level
                local skillProgress = skill.progress
        
                -- Create a menu element for each skill
                local skillElement = {
                    header = toUppercaseFirst(skillName),
                    txt = string.format("Level: %d | Progress: %d%%", skillLevel, skillProgress),
                    disabled = false -- This element is not selectable
                }
        
                table.insert(elements, skillElement) -- Add the skill element to the menu
            end
        
            -- Open the skills menu
            exports["qb-menu"]:showHeader(elements)
            menuOpen = true
        end
    end)
end, false)

RegisterCommand("-skillsmenu", function()
    if not menuOpen then return end
    exports["qb-menu"]:closeMenu()
    menuOpen = false
end, false)

RegisterKeyMapping("+skillsmenu", "Open Skills Menu", "keyboard", Config.MenuKey)