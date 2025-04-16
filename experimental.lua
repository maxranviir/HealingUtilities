local wasSoulstone = false

local soulstoneCheckFrame = CreateFrame("Frame")
soulstoneCheckFrame:RegisterEvent("UNIT_AURA")
soulstoneCheckFrame:SetScript("OnEvent", function(self, event, unit)
    if unit ~= "player" or not inDev then
        return
    end
    local activeSoulstone = false
    AuraUtil.ForEachAura("player", "HELPFUL", nil, function(name)
        if name == "Soulstone Resurrection" then
            activeSoulstone = true
            return false
        end
        return true
    end)

    if activeSoulstone and not wasSoulstone then
        print(
            "[Healer Utilities] |cffffff00You now have a Soulstone|r |TInterface\\Icons\\Spell_Shadow_SoulGem:12:12|t |cff00ff00Active!|r")
        if IsInGroup() then
            SendChatMessage("[I am now Soulstoned] {diamond}", "PARTY")
        end
        wasSoulstone = true
    end

    if not activeSoulstone and wasSoulstone then
        print("[Healer Utilities] Soulstone|r |TInterface\\Icons\\Spell_Shadow_SoulGem:12:12|t |cff00ff00Removed!|r")
        wasSoulstone = false
    end
end)
