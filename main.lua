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

local function initHealingAddon()
    if not HealerUtilsDB then HealerUtilsDB = {} end
    if not HealerUtilsDB.position then HealerUtilsDB.position = { x = 0, y = 0} end
    createDrinkBtn()
    drinkBtn:ClearAllPoints()
    drinkBtn:SetPoint("CENTER", UIParent, "CENTER", HealerUtilsDB.position.x, HealerUtilsDB.position.y)
end

local initFrame = CreateFrame("Frame")
initFrame:RegisterEvent("PLAYER_LOGIN")
initFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
initFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
local hasPrintedInit = false
initFrame:SetScript("OnEvent", function(self, event, ...)
    local role = UnitGroupRolesAssigned("player")
        if role == "HEALER" then
            initHealingAddon()
            if event == "PLAYER_LOGIN" and not hasPrintedInit then
                hasPrintedInit = true
            C_Timer.After(3, function()
        print((color and string.format("|cFF%02X%02X%02X%s|r",
         color.r * 255, color.g * 255, color.b * 255, class))
    .. " detected.")
    print("Healer Utilities v1.0 Loaded.")
    print("You are currently assigned as a " .. "|TInterface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES:16:16:0:0:128:128:64:128:0:64|t" .. " HEALER. Healer Utilities active!")
end)
        elseif drinkBtn then
            drinkBtn:Hide()
        end
    end
end)

local manaCheckFrame = CreateFrame("Frame")
manaCheckFrame:RegisterEvent("UNIT_POWER_UPDATE")
manaCheckFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
manaCheckFrame:SetScript("OnEvent", function(self, event, unit)
    if event == "UNIT_POWER_UPDATE" and unit == "player" then
        GetManaPercent()
        manaCheckBtnToggle()
        manaAnnounce()
    end
end)

    










