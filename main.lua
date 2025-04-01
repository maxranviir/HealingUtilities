local function huInit()
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
    if event == "PLAYER_ENTERING_WORLD" and huLoadConditions then
        huInit()
    elseif event == "UNIT_POWER_UPDATE" and unit == "player" and huLoadConditions then
        GetManaPercent()
        manaCheckBtnToggle()
        if IsInGroup() then
            manaAnnounce()
        end
    end
end)
    










