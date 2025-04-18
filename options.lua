local loadFrame = CreateFrame("Frame")
loadFrame:RegisterEvent("ADDON_LOADED")
loadFrame:SetScript("OnEvent", function(self, event, addOnName)
    if addOnName == "HealerUtilities" then
        if not HealerUtilsDB then HealerUtilsDB = {} end
        HealerUtilsDB.inDev = HealerUtilsDB.inDev or false
        HealerUtilsDB.debug = HealerUtilsDB.debug or false
        HealerUtilsDB.mBtnPos = HealerUtilsDB.mBtnPos or {}
        HealerUtilsDB.dBtnPos = HealerUtilsDB.dBtnPos or { x = 0, y = 0 }
        HealerUtilsDB.dBtnPos.x = HealerUtilsDB.dBtnPos.x or 0
        HealerUtilsDB.dBtnPos.y = HealerUtilsDB.dBtnPos.y or 0
        HealerUtilsDB.dButton = HealerUtilsDB.dButton or true
        HealerUtilsDB.loadAnnounce = HealerUtilsDB.loadAnnounce or true

        optionsPanel = CreateFrame("Frame", "huOptionsPanelFrame", UIParent, "ButtonFrameTemplate")
        table.insert(UISpecialFrames, "huOptionsPanelFrame")
        optionsPanel.TitleText:SetText("Healer Utilities")
        optionsPanel.portrait:SetTexture("Interface\\AddOns\\HealerUtilities\\portrait.tga")
        optionsPanel.portrait:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMask")
        optionsPanel:SetSize(900, 550)
        optionsPanel:SetPoint("CENTER")
        optionsPanel:SetFrameStrata("FULLSCREEN_DIALOG")
        optionsPanel:SetMovable(true)
        optionsPanel:EnableMouse(true)
        optionsPanel:RegisterForDrag("LeftButton")
        optionsPanel:SetScript("OnDragStart", optionsPanel.StartMoving)
        optionsPanel:SetScript("OnDragStop", optionsPanel.StopMovingOrSizing)
    end

    function createOptionsMenu()
        if huLoadConditions == nil then
            return
        end

        local function huDebugState()
            if HealerUtilsDB.debug then
                print("[Healer Utilities] |cffe08612Debug|r |cffffff00is now|r |cff00ff00Enabled|r")
            else
                print("[Healer Utilities] |cffe08612Debug|r |cffffff00is now|r |cffff0000Disabled|r")
            end
        end

        local function huIndevState()
            if HealerUtilsDB.inDev then
                print(
                    "[Healer Utilities] |cff00eeffinDev|r |cffffff00is now|r |cffffff00Experimental features are now loaded. You may experience bugs or script errors.")
            else
                print("[Healer Utilities] |cff00eeffinDev|r |cffffff00is now|r |cffff0000Disabled|r")
            end
        end

        local function hlcHandler(tab, doShow, doEnable)
            if doShow == false then
                tab:Hide()
                return
            end

            tab:Show()

            if doEnable then
                tab:Enable()
                tab:SetAlpha(1)
            else
                tab:Disable()
                tab:SetAlpha(0.4)
            end
            tab:SetScript("OnClick", doEnable and function()
                selectTab(tab:GetID())
            end or nil)
        end

        local tab1 = CreateFrame("Button", "$parentTab1", optionsPanel, "CharacterFrameTabButtonTemplate")
        tab1:SetID(1)
        tab1:SetText("About")
        tab1:SetPoint("BOTTOM", optionsPanel, "BOTTOM", -42, -30)
        PanelTemplates_TabResize(tab1, 0)

        local tab2 = CreateFrame("Button", "$parentTab2", optionsPanel, "CharacterFrameTabButtonTemplate")
        tab2:SetID(2)
        tab2:SetText("Mana Announce")
        tab2:SetPoint("LEFT", tab1, "RIGHT", -15, 0)
        PanelTemplates_TabResize(tab2, 0)
        tab2:HookScript("OnEnter", function(self)
            if not huLoadConditions then
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText("Only available to mana users.", 1, 0.8, 0.8, true)
                GameTooltip:Show()
            end
        end)
        tab2:HookScript("OnLeave", function()
            GameTooltip:Hide()
        end)


        local tab3 = CreateFrame("Button", "$parentTab3", optionsPanel, "CharacterFrameTabButtonTemplate")
        tab3:SetID(3)
        tab3:SetText("Drink Button")
        tab3:SetPoint("LEFT", tab2, "RIGHT", -15, 0)
        tab3:HookScript("OnEnter", function(self)
            if not huLoadConditions then
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText("Only available to mana users.", 1, 0.8, 0.8, true)
                GameTooltip:Show()
            end
        end)
        tab3:HookScript("OnLeave", function()
            GameTooltip:Hide()
        end)
        PanelTemplates_TabResize(tab3, 0)

        optionsPanel.Tab1 = tab1
        optionsPanel.Tab2 = tab2
        optionsPanel.Tab3 = tab3
        PanelTemplates_SetNumTabs(optionsPanel, 3)
        PanelTemplates_SetTab(optionsPanel, 1)

        function tabChecker(source)
            if source == "loadAnnounce" then
                local show = HealerUtilsDB.loadAnnounce
                local enabled = show and huLoadConditions
                hlcHandler(tab2, show, enabled)
            elseif source == "dButton" then
                local show = HealerUtilsDB.dButton
                if show and not drinkBtn and huLoadConditions then
                    createDrinkBtn()
                end
                local enabled = show and huLoadConditions
                hlcHandler(tab3, show, enabled)
            end
        end

        local aboutTab = CreateFrame("Frame", nil, optionsPanel)
        aboutTab:SetAllPoints(optionsPanel)

        local aTabDeco = CreateFrame("Frame", nil, aboutTab, "BackdropTemplate")
        aTabDeco:SetSize(700, 225)
        aTabDeco:SetPoint("CENTER", 0, -100)
        aTabDeco:SetBackdrop({
            bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = true,
            tileSize = 16,
            edgeSize = 16,
            insets = { left = 4, right = 4, top = 4, bottom = 4 },
        })
        aTabDeco:SetBackdropColor(0.25, 0.25, 0.25, 0.8)
        aTabDeco:SetFrameLevel(1)

        local logoFrame = aboutTab:CreateTexture(nil, "ARTWORK")
        logoFrame:SetTexture("Interface\\AddOns\\HealerUtilities\\logo.tga")
        logoFrame:SetSize(250, 134)
        logoFrame:SetPoint("CENTER", 0, 140)

        local logoFrameText = aboutTab:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        logoFrameText:SetPoint("BOTTOM", logoFrame, 0, -10)
        logoFrameText:SetText("|cffffffffv.1.0.0 by Maxranviir|r")

        local mmText = aboutTab:CreateFontString(nil, "OVERLAY", "DialogButtonHighlightText")
        mmText:SetPoint("CENTER", aboutTab, 0, 25)
        mmText:SetText("|cffffd200Main Menu|r")

        local maTitle = aboutTab:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        maTitle:SetPoint("CENTER", aboutTab, -200, -20)
        maTitle:SetText("|cffffd200Mana Announcement|r")

        local maCheckbox = CreateFrame("CheckButton", "huMaCheckbox", aboutTab, "ChatConfigCheckButtonTemplate")
        maCheckbox:SetPoint("CENTER", maTitle, -90, -25)
        maCheckbox.Text:SetText("Enable Mana Announcement")
        maCheckbox:SetChecked(HealerUtilsDB.loadAnnounce)
        maCheckbox:SetScript("OnClick", function(self)
            HealerUtilsDB.loadAnnounce = self:GetChecked()
            tabChecker("loadAnnounce")
        end)

        local dbTitle = aboutTab:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        dbTitle:SetPoint("CENTER", aboutTab, 0, -20)
        dbTitle:SetText("|cffffd200Drink Button|r")

        local dbCheckbox = CreateFrame("CheckButton", "huDbCheckbox", aboutTab, "ChatConfigCheckButtonTemplate")
        dbCheckbox:SetPoint("CENTER", dbTitle, -0, -25)
        dbCheckbox.Text:SetText("Enable Drink Button")
        dbCheckbox:SetChecked(HealerUtilsDB.dButton)
        dbCheckbox:SetScript("OnClick", function(self)
            HealerUtilsDB.dButton = self:GetChecked()
            tabChecker("dButton")
        end)


        local indevCheckbox = CreateFrame("CheckButton", "huIndevCheckbox", aboutTab, "ChatConfigCheckButtonTemplate")
        indevCheckbox:SetPoint("CENTER", aboutTab, -240, -195)
        indevCheckbox.Text:SetText("|cffffd200Enable|r |cff00eeffIn-Development|r |cffffd200Functionality|r")
        indevCheckbox:SetChecked(HealerUtilsDB.inDev)
        indevCheckbox:SetScript("OnClick", function(self)
            HealerUtilsDB.inDev = self:GetChecked()
            huIndevState()
        end)

        local debugCheckbox = CreateFrame("CheckButton", "huDebugCheckbox", aboutTab, "ChatConfigCheckButtonTemplate")
        debugCheckbox:SetPoint("CENTER", aboutTab, 50, -195)
        debugCheckbox.Text:SetText("|cffffd200Enable|r |cffe08612Debug|r |cffffd200Messages|r")
        debugCheckbox:SetChecked(HealerUtilsDB.debug)
        debugCheckbox:SetScript("OnClick", function(self)
            HealerUtilsDB.debug = self:GetChecked()
            huDebugState()
        end)

        local maTab = CreateFrame("Frame", nil, optionsPanel)
        maTab:SetAllPoints(optionsPanel)

        local dbTab = CreateFrame("Frame", nil, optionsPanel)
        dbTab:SetAllPoints(optionsPanel)

        local function selectTab(id)
            if (id == 2 and (not HealerUtilsDB.loadAnnounce or not huLoadConditions)) or
                (id == 3 and (not HealerUtilsDB.dButton or not huLoadConditions)) then
                return
            end
            PanelTemplates_SetTab(optionsPanel, id)
            aboutTab:SetShown(id == 1)
            maTab:SetShown(id == 2)
            dbTab:SetShown(id == 3)
        end

        optionsPanel.Tab1:SetScript("OnClick", function() selectTab(1) end)

        selectTab(1)
        tabChecker("loadAnnounce")
        tabChecker("dButton")
        optionsPanel:Hide()

        local LDB = LibStub("LibDataBroker-1.1", true)
        local LDBIcon = LibStub("LibDBIcon-1.0")
        local huLDB = LDB:NewDataObject("HealerUtilities", {
            type = "data source",
            text = "Healer Utilities",
            icon = "Interface\\AddOns\\HealerUtilities\\icon.tga",
            OnClick = function(self, button)
                if button == "LeftButton" then
                    if optionsPanel:IsShown() then
                        optionsPanel:Hide()
                    else
                        optionsPanel:Show()
                    end
                end
            end,
            OnTooltipShow = function(tooltip)
                tooltip:AddLine("Healer Utilities")
                tooltip:AddLine("Left-Click: Toggle Options", 1, 1, 1)
            end,
        })
        if not LDBIcon:IsRegistered("HealerUtilities") then
            LDBIcon:Register("HealerUtilities", huLDB, HealerUtilsDB.mBtnPos)
        end

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
