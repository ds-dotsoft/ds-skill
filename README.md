
# Dotsoft Skills

A simple skills resource for qbcore!


## Usage/Examples

```lua
-- Adding xp example

local randomXp - math.random(1, 10)
exports['ds-skills']:UpdateSkill('stamina', randomXp)

-- Fetching skill level example

function GetSkill(skill)
    return exports['ds-skills']:GetSkill(skill)
end

local stamina = GetSkill('stamina')
print(stamina)
```


## Installation

```bash
    * Add ds-skill to your resources folder
    * Make sure you do `ensure ds-skill` before any resources that require it
    * Import players.sql in your database

    Enjoy!
```
    
## Screenshots

![App Screenshot](https://via.placeholder.com/468x300?text=App+Screenshot+Here)

