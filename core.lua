drinkBtn = nil
bestWater = nil
manaPercent = 100
lastManaPercent = 100

loadCheck = function()
    local powerType = UnitPowerType("player")
    return powerType == 0
end

function GetManaPercent()
    manaPercent = (UnitPower("player", 0) / UnitPowerMax("player", 0)) * 100
end