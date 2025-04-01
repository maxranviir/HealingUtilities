print("Healer Utilities version-1.0.0 Loaded.")
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
        .. "|cffffff00 does not use mana. Healer Utilities|r |cffff0000Disabled.|r")
    end)
    return
end

local initFrame = CreateFrame("Frame")
initFrame:RegisterEvent("PLAYER_ROLES_ASSIGNED")
if event == "PLAYER_ROLES_ASSIGNED" then
    local role = UnitGroupRolesAssigned("player")
    if role == "HEALER" then
        print((huClassColor and string.format("|cFF%02X%02X%02X%s|r",
                huClassColor.r * 255, huClassColor.g * 255, huClassColor.b * 255, huClass)) 
        .. "|cffffff00 and Healer assignment detected. Healer Utilities|r |cff00ff00Active!|r")
elseif drinkBtn then
    drinkBtn:Hide()
end
end

drinkBtn = nil
bestWater = nil
manaPercent = 100
lastManaPercent = 100

function GetManaPercent()
    manaPercent = (UnitPower("player", 0) / UnitPowerMax("player", 0)) * 100
end