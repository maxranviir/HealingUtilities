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
        print("[Healer Utilities] |cffffff00You now have a Soulstone|r |TInterface\\Icons\\Spell_Shadow_SoulGem:12:12|t |cff00ff00Active!|r")
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

function createOptionsPanel()
    if optionsPanel then
        return
    end

optionsPanel = CreateFrame("Frame", "OptionsPanelFrame", UIParent, "BackdropTemplate")
optionsPanel:SetSize(384, 512)
optionsPanel:SetPoint("CENTER")
optionsPanel:SetBackdrop({ 
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
optionsPanel:SetBackdropColor(0, 0, 0)
optionsPanel:SetMovable(true)
optionsPanel:EnableMouse(true)
optionsPanel:RegisterForDrag("LeftButton")
optionsPanel:SetScript("OnDragStart", optionsPanel.StartMoving)
optionsPanel:SetScript("OnDragStop", optionsPanel.StopMovingOrSizing)

local tFrame = optionsPanel:CreateTexture(nil, "ARTWORK")
tFrame:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
tFrame:SetSize(245, 64)
tFrame:SetPoint("TOP", 0, 12)

local tFrameText = optionsPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
tFrameText:SetPoint("TOP", tFrame, "TOP", 0, -14)
tFrameText:SetText("Healer Utilities")

local exitButton = CreateFrame("Button", nil, optionsPanel, "UIPanelButtonTemplate")
exitButton:SetSize(120, 22)
exitButton:SetPoint("BOTTOM", 0, 10)
exitButton:SetText("Close")
exitButton:SetScript("OnClick", function(self)
        optionsPanel:Hide()
    end)

local maCheckbox = CreateFrame("CheckButton", "huMaCheckbox", optionsPanel, "ChatConfigCheckButtonTemplate")
maCheckbox:SetPoint("TOPLEFT", 20, -50)
maCheckbox.Text:SetText("Enable Mana Announcement")
maCheckbox:SetChecked(HealerUtilsDB.loadAnnounce)
maCheckbox:SetScript("OnClick", function(self)
    HealerUtilsDB.loadAnnounce = self:GetChecked()
end)
optionsPanel:Hide()
end