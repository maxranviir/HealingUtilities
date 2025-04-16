local loadFrame = CreateFrame("Frame")
loadFrame:RegisterEvent("ADDON_LOADED")
loadFrame:SetScript("OnEvent", function(self, event, addOnName)
    if addOnName == "HealerUtilities" then
        if not HealerUtilsDB then HealerUtilsDB = {} end
        HealerUtilsDB.inDev = HealerUtilsDB.inDev or false
        HealerUtilsDB.debug = HealerUtilsDB.debug or false
        HealerUtilsDB.oButtonPosition = HealerUtilsDB.oButtonPosition or { x = 0, y = 0 }
        HealerUtilsDB.oButtonPosition.x = HealerUtilsDB.oButtonPosition.x or 0
        HealerUtilsDB.oButtonPosition.y = HealerUtilsDB.oButtonPosition.y or 0
        HealerUtilsDB.dButtonPosition = HealerUtilsDB.dButtonPosition or { x = 0, y = 0 }
        HealerUtilsDB.dButtonPosition.x = HealerUtilsDB.dButtonPosition.x or 0
        HealerUtilsDB.dButtonPosition.y = HealerUtilsDB.dButtonPosition.y or 0
        HealerUtilsDB.loadAnnounce = HealerUtilsDB.loadAnnounce or true

        function huDebugState()
            if HealerUtilsDB.debug then
                print("[Healer Utilities] |cffe08612Debug|r |cffffff00is now|r |cff00ff00Enabled|r")
            else
                print("[Healer Utilities] |cffe08612Debug|r |cffffff00is now|r |cffff0000Disabled|r")
            end
        end

        function huIndevState()
            if HealerUtilsDB.inDev then
                print(
                    "[Healer Utilities] |cff00eeffinDev|r |cffffff00is now|r |cffffff00Experimental features are now loaded. You may experience bugs or script errors.")
            else
                print("[Healer Utilities] |cff00eeffinDev|r |cffffff00is now|r |cffff0000Disabled|r")
            end
        end

        local optionsPanel = CreateFrame("Frame", "OptionsPanelFrame", UIParent, "BackdropTemplate")
        optionsPanel:SetSize(384, 512)
        optionsPanel:SetPoint("CENTER")
        optionsPanel:SetBackdrop({
            bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
            edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
            tile = true,
            tileSize = 16,
            edgeSize = 16,
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

        local logoFrame = optionsPanel:CreateTexture(nil, "ARTWORK")
        logoFrame:SetTexture("Interface\\AddOns\\HealerUtilities\\logo.tga")
        logoFrame:SetSize(250, 134)
        logoFrame:SetPoint("TOP", 0, -30)

        local logoFrameText = optionsPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        logoFrameText:SetPoint("TOP", logoFrame, "TOP", 0, -130)
        logoFrameText:SetText("|cffffffffv.1.0.0 by Maxranviir|r")

        local exitButton = CreateFrame("Button", nil, optionsPanel, "UIPanelButtonTemplate")
        exitButton:SetSize(120, 22)
        exitButton:SetPoint("BOTTOM", 0, 10)
        exitButton:SetText("Close")
        exitButton:SetScript("OnClick", function(self)
            optionsPanel:Hide()
        end)

        local maCheckbox = CreateFrame("CheckButton", "huMaCheckbox", optionsPanel, "ChatConfigCheckButtonTemplate")
        maCheckbox:SetPoint("TOPLEFT", 20, -190)
        maCheckbox.Text:SetText("Enable Mana Announcement")
        maCheckbox:SetChecked(HealerUtilsDB.loadAnnounce)
        maCheckbox:SetScript("OnClick", function(self)
            HealerUtilsDB.loadAnnounce = self:GetChecked()
        end)

        local indevCheckbox = CreateFrame("CheckButton", "huIndevCheckbox", optionsPanel, "ChatConfigCheckButtonTemplate")
        indevCheckbox:SetPoint("TOPLEFT", 20, -220)
        indevCheckbox.Text:SetText("Enable In-Development Functionality")
        indevCheckbox:SetChecked(HealerUtilsDB.inDev)
        indevCheckbox:SetScript("OnClick", function(self)
            HealerUtilsDB.inDev = self:GetChecked()
            huIndevState()
        end)

        local debugCheckbox = CreateFrame("CheckButton", "huDebugCheckbox", optionsPanel, "ChatConfigCheckButtonTemplate")
        debugCheckbox:SetPoint("TOPLEFT", 20, -250)
        debugCheckbox.Text:SetText("Enable Debug Messages")
        debugCheckbox:SetChecked(HealerUtilsDB.debug)
        debugCheckbox:SetScript("OnClick", function(self)
            HealerUtilsDB.debug = self:GetChecked()
            huDebugState()
        end)
        optionsPanel:Hide()

        local iconFrame = CreateFrame("Button", "OptionsButton", UIParent, "SecureActionButtonTemplate")
        iconFrame:SetSize(20, 20)
        iconFrame:SetPoint("CENTER")
        iconFrame:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
        iconFrame:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress")
        iconFrame:RegisterForClicks("AnyUp")
        iconFrame:SetMovable(true)
        iconFrame:EnableMouse(true)
        iconFrame:RegisterForDrag("LeftButton")

        iconFrame.tex = iconFrame:CreateTexture()
        iconFrame.tex:SetTexture("Interface\\AddOns\\HealerUtilities\\icon.tga")
        iconFrame.tex:SetAllPoints(iconFrame)

        iconFrame:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText("Healer Utilities")
            GameTooltip:Show()
        end)
        iconFrame:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
        end)

        iconFrame:SetScript("OnDragStart", function(self)
            self:StartMoving()
        end)
        iconFrame:SetScript("OnDragStop", function(self)
            self:StopMovingOrSizing()
            local point, _, _, x, y = self:GetPoint()
            HealerUtilsDB.oButtonPosition.x = x
            HealerUtilsDB.oButtonPosition.y = y
        end)

        iconFrame:SetScript("PostClick", function(self)
            if not optionsPanel:IsShown() then
                optionsPanel:Show()
            else
                optionsPanel:Hide()
            end
        end)

        iconFrame:ClearAllPoints()
        iconFrame:SetPoint("CENTER", UIParent, "CENTER", HealerUtilsDB.oButtonPosition.x,
            HealerUtilsDB.oButtonPosition.y)

        SLASH_HEALUTILS1 = "/hutil"
        SlashCmdList["HEALUTILS"] = function(msg)
            if msg == "debug" then
                HealerUtilsDB.debug = not HealerUtilsDB.debug
                huDebugState()
                return
            end
            if msg == "toggleindev" then
                HealerUtilsDB.inDev = not HealerUtilsDB.inDev
                huIndevState()
                return
            end

            if msg == "options" then
                if optionsPanel:IsShown() then
                    optionsPanel:Hide()
                else
                    optionsPanel:Show()
                end
            end
        end
    end
end)
