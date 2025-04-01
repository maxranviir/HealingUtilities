drinkBtn = nil
bestWater = nil
manaPercent = 100
lastManaPercent = 100

loadCheck = function()
    local powerType = UnitPowerType("player")
    return powerType == 0
end

local _, class = UnitClass("player")
local color = RAID_CLASS_COLORS[class]

if not loadCheck() then
    C_Timer.After(3, function()
        print((color and string.format("|cFF%02X%02X%02X%s|r",
         color.r * 255, color.g * 255, color.b * 255, class))
        .. " does not use mana. Healer Utilities Disabled.")
    end)
    return
end

function GetManaPercent()
    manaPercent = (UnitPower("player", 0) / UnitPowerMax("player", 0)) * 100
end