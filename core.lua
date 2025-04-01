loadCheck = function()
    local powerType = UnitPowerType("player")
    return powerType == 0
end

huClass = select(2, UnitClass("player"))
huClassColor = RAID_CLASS_COLORS[huClass]

if not loadCheck() then
    C_Timer.After(3, function()
        print((huClassColor and string.format("|cFF%02X%02X%02X%s|r",
         huClassColor.r * 255, huClassColor.g * 255, huClassColor.b * 255, huClass))
        .. " does not use mana. Healer Utilities Disabled.")
    end)
    return
end

drinkBtn = nil
bestWater = nil
manaPercent = 100
lastManaPercent = 100

function GetManaPercent()
    manaPercent = (UnitPower("player", 0) / UnitPowerMax("player", 0)) * 100
end