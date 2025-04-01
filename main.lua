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
        print((huClassColor and string.format("|cFF%02X%02X%02X%s|r",
         huClassColor.r * 255, huClassColor.g * 255, huClassColor.b * 255, huClass))
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
        if IsInGroup() then
            manaAnnounce()
        end
    end
end)

    










