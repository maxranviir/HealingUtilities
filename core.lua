print("[Healer Utilities]: version-1.0.0 |cff00ff00Loaded.|r")

huLoadConditions = nil
local huClass = select(2, UnitClass("player"))
local huClassColor = RAID_CLASS_COLORS[huClass]

loadCheck = function()
    local powerType = UnitPowerType("player")
    if powerType == 0 then
        huLoadConditions = true
        return true
    else
        return false
    end
end

if not loadCheck() then
    if huClass ~= "DRUID" then
    C_Timer.After(3, function()
        print("[Healer Utilities]: " .. 
            (huClassColor and string.format("|cFF%02X%02X%02X%s|r", 
                huClassColor.r * 255, huClassColor.g * 255, huClassColor.b * 255, huClass))
        .. "|cffffff00 does not use mana. Healer Utilities|r |cffff0000Disabled.|r")
    end)
    return
end
end

local druidProblemFrame = CreateFrame("Frame")
druidProblemFrame:RegisterEvent("UNIT_DISPLAYPOWER")
druidProblemFrame:SetScript("OnEvent", function(self, event, unit)
    if unit == "player" and powerType == 0 then
        loadCheck()
    end
end)

local initActive = false
local lastRole = nil

local initFrame = CreateFrame("Frame")
initFrame:RegisterEvent("PLAYER_ROLES_ASSIGNED")
initFrame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_ROLES_ASSIGNED" then
    local role = UnitGroupRolesAssigned("player")
    if role == "HEALER" and lastRole ~= "HEALER" then
        C_Timer.After(0.5, function()
        print("[Healer Utilities]: " .. 
            (huClassColor and string.format("|cFF%02X%02X%02X%s|r",
                huClassColor.r * 255, huClassColor.g * 255, huClassColor.b * 255, huClass)) 
        .. "|cffffff00 Healer detected. Healer Utilities|r |cff00ff00Active!|r")
    end)
    elseif role ~= "HEALER" and lastRole == "HEALER" then
        if drinkBtn then
            drinkBtn:Hide()
        end
    end
    lastRole = role
    end
end)

drinkBtn = nil
bestWater = nil
manaPercent = 100
lastManaPercent = 100

function GetManaPercent()
    manaPercent = (UnitPower("player", 0) / UnitPowerMax("player", 0)) * 100
end