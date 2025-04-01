if not huLoadCoonditions then
    return
end

local function initHealingAddon()
    if not HealerUtilsDB then HealerUtilsDB = {} end
    if not HealerUtilsDB.position then HealerUtilsDB.position = { x = 0, y = 0} end
    createDrinkBtn()
    drinkBtn:ClearAllPoints()
    drinkBtn:SetPoint("CENTER", UIParent, "CENTER", HealerUtilsDB.position.x, HealerUtilsDB.position.y)
end

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

    










