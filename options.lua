--///////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\---
----------------===SAVED VARIABLES===----------------
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
        HealerUtilsDB.dBtnLock = HealerUtilsDB.dBtnLock or false
        HealerUtilsDB.dBtnBG = HealerUtilsDB.dBtnBG or true
        HealerUtilsDB.dBtnCombatHide = HealerUtilsDB.dBtnCombatHide or true
        HealerUtilsDB.dbScaleValue = tonumber(HealerUtilsDB.dbScaleValue) or 1.0
        HealerUtilsDB.MAThreshVal1 = HealerUtilsDB.MAThreshVal1 or 75
        HealerUtilsDB.MAThreshVal2 = HealerUtilsDB.MAThreshVal2 or 50
        HealerUtilsDB.MAThreshVal3 = HealerUtilsDB.MAThreshVal3 or 25
        HealerUtilsDB.MAThreshVal4 = HealerUtilsDB.MAThreshVal4 or 10
        HealerUtilsDB.MAThreshVal5 = HealerUtilsDB.MAThreshVal5 or 5
        HealerUtilsDB.maRaid = HealerUtilsDB.maRaid or false
        HealerUtilsDB.maBG = HealerUtilsDB.maBG or false
        HealerUtilsDB.maCDValue = HealerUtilsDB.maCDValue or 10
        HealerUtilsDB.maChannel = HealerUtilsDB.maChannel or "PARTY"
        HealerUtilsDB.maRaidChannel = HealerUtilsDB.maRaidChannel or "RAID"

        --////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\--
        ----------------===OPTIONS PANEL===------------------
        optionsPanel = CreateFrame("Frame", "huOptionsPanelFrame", UIParent, "ButtonFrameTemplate")
        table.insert(UISpecialFrames, "huOptionsPanelFrame")
        optionsPanel.TitleText:SetText("Healer Utilities")
        optionsPanel.portrait:SetTexture("Interface\\AddOns\\HealerUtilities\\portrait.tga")
        optionsPanel.portrait:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMask")
        optionsPanel:SetSize(650, 550)
        optionsPanel:SetPoint("CENTER")
        optionsPanel:SetFrameStrata("FULLSCREEN_DIALOG")
        optionsPanel:SetMovable(true)
        optionsPanel:EnableMouse(true)
        optionsPanel:RegisterForDrag("LeftButton")
        optionsPanel:SetScript("OnDragStart", optionsPanel.StartMoving)
        optionsPanel:SetScript("OnDragStop", optionsPanel.StopMovingOrSizing)
        -------------------------------------------------------===TAB CREATION===-------------------------------------------------------
        local aboutTab = CreateFrame("Button", "$parentTab1", optionsPanel, "CharacterFrameTabButtonTemplate")
        aboutTab:SetID(1)
        aboutTab:SetText("About")
        aboutTab:SetPoint("BOTTOM", optionsPanel, "BOTTOM", -50, -30)
        PanelTemplates_TabResize(aboutTab, 0)
        local settingsTab = CreateFrame("Button", "$parentTab2", optionsPanel, "CharacterFrameTabButtonTemplate")
        settingsTab:SetID(2)
        settingsTab:SetText("Settings")
        settingsTab:SetPoint("LEFT", aboutTab, "RIGHT", -15, 0)
        PanelTemplates_TabResize(settingsTab, 0)
        --------------------------------------------------------------------------------------------------------------------------------
        ------------------------------------------------------===FRAME CREATION===------------------------------------------------------
        local aboutFrame = CreateFrame("Frame", nil, optionsPanel)
        aboutFrame:SetAllPoints(optionsPanel)

        local logo = aboutFrame:CreateTexture(nil, "ARTWORK")
        logo:SetTexture("Interface\\AddOns\\HealerUtilities\\logo.tga")
        logo:SetSize(250, 134)
        logo:SetPoint("CENTER", 0, 140)

        local logoText = aboutFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        logoText:SetPoint("BOTTOM", logo, 0, -10)
        logoText:SetText("|cffffffffv.1.0.0 by Maxranviir|r")

        local aFrameDeco = CreateFrame("Frame", nil, aboutFrame, "BackdropTemplate")
        aFrameDeco:SetSize(700, 225)
        aFrameDeco:SetPoint("CENTER", 0, -100)
        aFrameDeco:SetBackdrop({
            bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = true,
            tileSize = 16,
            edgeSize = 16,
            insets = { left = 4, right = 4, top = 4, bottom = 4 },
        })
        aFrameDeco:SetBackdropColor(0.25, 0.25, 0.25, 0.8)
        aFrameDeco:SetFrameLevel(1)

        local settingsFrame = CreateFrame("Frame", "huSettingsFrame", optionsPanel)
        settingsFrame:SetAllPoints(optionsPanel)
        settingsFrame:Hide()

        local settingsDeco1 = CreateFrame("Frame", nil, settingsFrame, "BackdropTemplate")
        settingsDeco1:SetSize(600, 400)
        settingsDeco1:SetPoint("CENTER", 0, -20)
        settingsDeco1:SetBackdrop({
            bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = true,
            tileSize = 16,
            edgeSize = 16,
            insets = { left = 4, right = 4, top = 4, bottom = 4 },
        })
        settingsDeco1:SetBackdropColor(0.2, 0.2, 0.2, 1)
        settingsDeco1:SetFrameLevel(1)
        -----SUBTABS-----
        local dbTab = CreateFrame("Button", "$parentTab1", settingsFrame, "OptionsFrameTabButtonTemplate")
        dbTab:SetID(1)
        dbTab:SetText("Drink Button")
        dbTab:SetPoint("RIGHT", settingsDeco1, "TOP", -200, 12)
        PanelTemplates_TabResize(dbTab, 0)

        local maTab = CreateFrame("Button", "$parentTab2", settingsFrame, "OptionsFrameTabButtonTemplate")
        maTab:SetID(2)
        maTab:SetText("Mana Announce")
        maTab:SetPoint("LEFT", dbTab, "RIGHT", -15, 0)
        PanelTemplates_TabResize(maTab, 0)

        local dbFrame = CreateFrame("Frame", "huDBtnOptionsFrame", settingsFrame)
        dbFrame:SetAllPoints(settingsFrame)
        dbFrame:Hide()

        local dbfDeco2 = CreateFrame("Frame", nil, dbFrame, "InsetFrameTemplate3")
        dbfDeco2:SetSize(576, 345)
        dbfDeco2:SetPoint("CENTER", 0, -35)
        local dbText1 = dbfDeco2:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        dbText1:SetPoint("TOP", 0, -10)
        dbText1:SetText("|cffffffffButton Properties|r")
        dbText1:SetScale(1.5)
        local dbDiv1 = dbfDeco2:CreateTexture(nil, "ARTWORK")
        dbDiv1:SetTexture("Interface\\Common\\UI-TooltipDivider")
        dbDiv1:SetSize(120, 16)
        dbDiv1:SetPoint("TOPLEFT", 80, -14)
        dbDiv1:SetVertexColor(1, 0.82, 0, 1)
        local dbDiv2 = dbfDeco2:CreateTexture(nil, "ARTWORK")
        dbDiv2:SetTexture("Interface\\Common\\UI-TooltipDivider")
        dbDiv2:SetSize(120, 16)
        dbDiv2:SetPoint("TOPRIGHT", -80, -14)
        dbDiv2:SetVertexColor(1, 0.82, 0, 1)
        local dbDiv3 = dbfDeco2:CreateTexture(il, "ARTWORK")
        dbDiv3:SetTexture("Interface\\Common\\UI-TooltipDivider")
        dbDiv3:SetSize(120, 16)
        dbDiv3:SetPoint("LEFT", 15, 0)
        dbDiv3:SetVertexColor(1, 0.82, 0, 1)
        local dbDiv4 = dbfDeco2:CreateTexture(il, "ARTWORK")
        dbDiv4:SetTexture("Interface\\Common\\UI-TooltipDivider")
        dbDiv4:SetSize(206, 16)
        dbDiv4:SetPoint("RIGHT", -10, 0)
        dbDiv4:SetVertexColor(1, 0.82, 0, 1)



        local dbCheckbox = CreateFrame("CheckButton", "huDbCheckbox", dbFrame, "ChatConfigCheckButtonTemplate")
        dbCheckbox:SetPoint("CENTER", -275, 155)
        dbCheckbox.Text:SetText("|cffffd200Enable Drink Button|r")
        dbCheckbox.Text:ClearAllPoints()
        dbCheckbox.Text:SetPoint("CENTER", dbCheckbox, "RIGHT", 60, 0)
        dbCheckbox:SetChecked(HealerUtilsDB.dButton)
        dbCheckbox:SetScript("OnClick", function(self)
            HealerUtilsDB.dButton = self:GetChecked()
        end)

        local dbLockCheckbox = CreateFrame("CheckButton", "huDbLockCheckbox", dbfDeco2, "ChatConfigCheckButtonTemplate")
        dbLockCheckbox:SetPoint("CENTER", -175, 105)
        dbLockCheckbox.Text:SetText("|cffffd200Lock Position|r")
        dbLockCheckbox.Text:ClearAllPoints()
        dbLockCheckbox.Text:SetPoint("CENTER", dbLockCheckbox, "RIGHT", 45, 0)
        dbLockCheckbox:SetChecked(HealerUtilsDB.dBtnLock)
        dbLockCheckbox:SetScript("OnClick", function(self)
            HealerUtilsDB.dBtnLock = self:GetChecked()
            buttonUpdater()
        end)

        local dbBGCheckbox = CreateFrame("CheckButton", "huDbBGCheckbox", dbfDeco2, "ChatConfigCheckButtonTemplate")
        dbBGCheckbox:SetPoint("CENTER", 50, 105)
        dbBGCheckbox.Text:SetText("|cffffd200Show in Battlegrounds|r")
        dbBGCheckbox.Text:ClearAllPoints()
        dbBGCheckbox.Text:SetPoint("CENTER", dbBGCheckbox, "RIGHT", 70, 0)
        dbBGCheckbox:SetChecked(HealerUtilsDB.dBtnBG)
        dbBGCheckbox:SetScript("OnClick", function(self)
            HealerUtilsDB.dBtnBG = self:GetChecked()
            buttonVisibilityCheck()
        end)

        local dbCombatCheckbox = CreateFrame("CheckButton", "huDBCombatCheckbox", dbfDeco2,
            "ChatConfigCheckButtonTemplate")
        dbCombatCheckbox:SetPoint("CENTER", 50, 40)
        dbCombatCheckbox.Text:SetText("|cffffd200Hide in Combat|r")
        dbCombatCheckbox.Text:ClearAllPoints()
        dbCombatCheckbox.Text:SetPoint("CENTER", dbCombatCheckbox, "RIGHT", 50, 0)
        dbCombatCheckbox:SetChecked(HealerUtilsDB.dBtnCombatHide)
        dbCombatCheckbox:SetScript("OnClick", function(self)
            HealerUtilsDB.dBtnCombatHide = self:GetChecked()
            buttonVisibilityCheck()
        end)

        local dbSlider = CreateFrame("Slider", "huDbScaleSlider", dbfDeco2, "OptionsSliderTemplate")
        dbSlider:SetWidth(200)
        dbSlider:SetHeight(16)
        dbSlider:SetPoint("CENTER", -130, 40)
        dbSlider:SetMinMaxValues(0.5, 2)
        dbSlider:SetValueStep(0.5)
        dbSlider:SetObeyStepOnDrag(true)
        dbSlider:SetValue(HealerUtilsDB.dbScaleValue or 1.0)
        _G[dbSlider:GetName() .. "Text"]:SetText("|cffffd200Scale")
        _G[dbSlider:GetName() .. "Low"]:SetText("0.5")
        _G[dbSlider:GetName() .. "High"]:SetText("2.0")
        dbSlider:SetScript("OnValueChanged", function(self, value)
            value = tonumber(string.format("%.1f", value))
            HealerUtilsDB.dbScaleValue = value
            if not InCombatLockdown() then
                buttonUpdater()
            else
                print("[Healer Utilities]: ", "|cffffd200Scale cannot be modified in combat.|r")
            end
        end)



        local maFrame = CreateFrame("Frame", "huMaOptionsFrame", settingsFrame)
        maFrame:SetAllPoints(settingsFrame)
        maFrame:Hide()

        local mafDeco1 = CreateFrame("Frame", nil, maFrame, "InsetFrameTemplate3")
        mafDeco1:SetSize(576, 345)
        mafDeco1:SetPoint("CENTER", 0, -35)
        local mafDeco2 = CreateFrame("Frame", nil, mafDeco1, "InsetFrameTemplate3")
        mafDeco2:SetSize(525, 110)
        mafDeco2:SetPoint("TOP", 0, -45)
        local maText1 = mafDeco1:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        maText1:SetPoint("TOP", 0, -10)
        maText1:SetText("|cffffffffAnnouncement Customization|r")
        maText1:SetScale(1.5)
        local maText2 = mafDeco1:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        maText2:SetPoint("CENTER", 0, 0)
        maText2:SetText("|cffffffffAdvanced|r")
        maText2:SetScale(1.5)
        local maDiv1 = mafDeco1:CreateTexture(nil, "ARTWORK")
        maDiv1:SetTexture("Interface\\Common\\UI-TooltipDivider")
        maDiv1:SetSize(65, 16)
        maDiv1:SetPoint("TOPLEFT", 80, -14)
        maDiv1:SetVertexColor(1, 0.82, 0, 1)
        local maDiv2 = mafDeco1:CreateTexture(nil, "ARTWORK")
        maDiv2:SetTexture("Interface\\Common\\UI-TooltipDivider")
        maDiv2:SetSize(65, 16)
        maDiv2:SetPoint("TOPRIGHT", -80, -14)
        maDiv2:SetVertexColor(1, 0.82, 0, 1)
        local maDiv3 = mafDeco1:CreateTexture(nil, "ARTWORK")
        maDiv3:SetTexture("Interface\\Common\\UI-TooltipDivider")
        maDiv3:SetSize(120, 16)
        maDiv3:SetPoint("LEFT", 15, 0)
        maDiv3:SetVertexColor(1, 0.82, 0, 1)
        local maDiv4 = mafDeco1:CreateTexture(nil, "ARTWORK")
        maDiv4:SetTexture("Interface\\Common\\UI-TooltipDivider")
        maDiv4:SetSize(206, 16)
        maDiv4:SetPoint("RIGHT", -10, 0)
        maDiv4:SetVertexColor(1, 0.82, 0, 1)
        local maDiv5 = mafDeco2:CreateTexture(nil, "ARTWORK")
        maDiv5:SetTexture("Interface\\Common\\UI-TooltipDivider")
        maDiv5:SetSize(100, 8)
        maDiv5:SetPoint("CENTER", -13, 13)
        local maDiv6 = mafDeco2:CreateTexture(nil, "ARTWORK")
        maDiv6:SetTexture("Interface\\Common\\UI-TooltipDivider")
        maDiv6:SetSize(100, 8.8)
        maDiv6:SetPoint("LEFT", 34, 0)
        maDiv6:SetVertexColor(1, 0.82, 0, 1)
        local maDiv7 = mafDeco2:CreateTexture(nil, "ARTWORK")
        maDiv7:SetTexture("Interface\\Common\\UI-TooltipDivider")
        maDiv7:SetSize(100, 8)
        maDiv7:SetPoint("RIGHT", -35, 13)
        local maDiv8 = mafDeco2:CreateTexture(nil, "ARTWORK")
        maDiv8:SetColorTexture(1, 0.82, 0, 0.2)
        maDiv8:SetSize(1, 75)
        maDiv8:SetPoint("LEFT", 165, 0)

        local maCheckbox = CreateFrame("CheckButton", "huMaCheckbox", maFrame, "ChatConfigCheckButtonTemplate")
        maCheckbox:SetPoint("CENTER", -275, 155)
        maCheckbox.Text:SetText("|cffffd200Enable Mana Announcement|r")
        maCheckbox.Text:ClearAllPoints()
        maCheckbox.Text:SetPoint("CENTER", maCheckbox, "RIGHT", 85, 0)
        maCheckbox:SetChecked(HealerUtilsDB.loadAnnounce)
        maCheckbox:SetScript("OnClick", function(self)
            HealerUtilsDB.loadAnnounce = self:GetChecked()
        end)

        local maChannelText1 = mafDeco2:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        maChannelText1:SetPoint("CENTER", mafDeco2, "LEFT", 77, 17)
        maChannelText1:SetWidth(200)
        maChannelText1:SetText("Announce\nChannel Output")
        maChannelText1:SetScale(1.075)

        local maChannels = {
            { text = "|cffffffffSay|r",   value = "SAY" },
            { text = "|cffff4040Yell|r",  value = "YELL" },
            { text = "|cffaaaaffParty|r", value = "PARTY" },
        }

        local maChannelDropdown = CreateFrame("Frame", "huMAChannelDropdown", mafDeco2, "UIDropDownMenuTemplate")
        maChannelDropdown:SetPoint("CENTER", mafDeco2, "LEFT", 83, -23)
        UIDropDownMenu_SetWidth(maChannelDropdown, 120)

        local function initChannelDropdown(self, level)
            for _, channel in ipairs(maChannels) do
                local info = UIDropDownMenu_CreateInfo()
                info.text = channel.text
                info.value = channel.value
                info.checked = (HealerUtilsDB.maChannel == channel.value)
                info.func = function(self)
                    HealerUtilsDB.maChannel = self.value
                    UIDropDownMenu_SetSelectedValue(maChannelDropdown, self.value)
                end
                UIDropDownMenu_AddButton(info, level)
            end
        end

        UIDropDownMenu_Initialize(maChannelDropdown, initChannelDropdown)
        UIDropDownMenu_SetSelectedValue(maChannelDropdown, HealerUtilsDB.maChannel or "PARTY")

        local maRaidCheckbox = CreateFrame("CheckButton", "huMARaidCheckbox", mafDeco2, "ChatConfigCheckButtonTemplate")
        maRaidCheckbox:SetPoint("CENTER", -63, 27)
        maRaidCheckbox.Text:SetText("|cffffd200Enable in Raid|r")
        maRaidCheckbox.Text:ClearAllPoints()
        maRaidCheckbox.Text:SetPoint("CENTER", maRaidCheckbox, "RIGHT", 45, 0)
        maRaidCheckbox:SetChecked(HealerUtilsDB.maRaid)

        local maRCText = mafDeco2:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        maRCText:SetPoint("CENTER", maRaidCheckbox, "RIGHT", 35, -27)
        maRCText:SetText("|cffffd200Output Channel|r")


        local maRaidChannels = {
            { text = "|cffffffffSay|r",   value = "SAY" },
            { text = "|cffff4040Yell|r",  value = "YELL" },
            { text = "|cffaaaaffParty|r", value = "PARTY" },
            { text = "|cffff7f00Raid|r",  value = "RAID" },
        }

        local maRaidDropdown = CreateFrame("Frame", "huMARaidDropdown", maRaidCheckbox, "UIDropDownMenuTemplate")
        maRaidDropdown:SetPoint("CENTER", maRaidCheckbox, "RIGHT", 35, -50)
        UIDropDownMenu_SetWidth(maRaidDropdown, 120)

        local function initRaidDropdown(self, level)
            for _, channel in ipairs(maRaidChannels) do
                local info = UIDropDownMenu_CreateInfo()
                info.text = channel.text
                info.value = channel.value
                info.checked = (HealerUtilsDB.maRaidChannel == channel.value)
                info.func = function(self)
                    HealerUtilsDB.maRaidChannel = self.value
                    UIDropDownMenu_SetSelectedValue(maRaidDropdown, self.value)
                end
                UIDropDownMenu_AddButton(info, level)
            end
        end

        UIDropDownMenu_Initialize(maRaidDropdown, initRaidDropdown)
        UIDropDownMenu_SetSelectedValue(maRaidDropdown, HealerUtilsDB.maRaidChannel or "RAID")

        local maRCover = CreateFrame("Frame", nil, maRaidDropdown, "BackdropTemplate")
        maRCover:SetPoint("CENTER", maRaidDropdown, "CENTER", 0, 2)
        maRCover:SetSize(135, 24)
        maRCover:EnableMouse(true)
        maRCover:SetBackdrop({ bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", })
        maRCover:SetBackdropColor(0.1, 0.1, 0.1, 0.9)
        maRCover:Hide()

        maRaidCheckbox:SetScript("OnClick", function(self)
            HealerUtilsDB.maRaid = self:GetChecked()
            if HealerUtilsDB.maRaid then
                UIDropDownMenu_EnableDropDown(maRaidDropdown)
                maRCText:SetText("|cffffd200Output Channel|r")
                maDiv5:SetVertexColor(1, 0.82, 0, 1)
                maRCover:Hide()
            else
                UIDropDownMenu_DisableDropDown(maRaidDropdown)
                maRCText:SetText("|cff323232Output Channel|r")
                maDiv5:SetVertexColor(0.5, 0.5, 0.5, 1)
                maRCover:Show()
            end
        end)

        if HealerUtilsDB.maRaid then
            UIDropDownMenu_EnableDropDown(maRaidDropdown)
            maRCText:SetText("|cffffd200Output Channel|r")
            maDiv5:SetVertexColor(1, 0.82, 0, 1)
            maRCover:Hide()
        else
            UIDropDownMenu_DisableDropDown(maRaidDropdown)
            maRCText:SetText("|cff323232Output Channel|r")
            maDiv5:SetVertexColor(0.5, 0.5, 0.5, 1)
            maRCover:Show()
        end


        local maBGCheckbox = CreateFrame("CheckButton", "huMABGCheckbox", mafDeco2, "ChatConfigCheckButtonTemplate")
        maBGCheckbox:SetPoint("RIGHT", -150, 27)
        maBGCheckbox.Text:SetText("|cffff2020Enable in Battlegrounds|r")
        maBGCheckbox.Text:ClearAllPoints()
        maBGCheckbox.Text:SetPoint("CENTER", maBGCheckbox, "RIGHT", 72, 0)
        maBGCheckbox:SetChecked(HealerUtilsDB.maBG)

        local maBGText = mafDeco2:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        maBGText:SetPoint("CENTER", maBGCheckbox, "RIGHT", 65, -27)
        maBGText:SetText("|cffffd200Output Channel|r")


        local maBGChannels = {
            { text = "|cffffffffSay|r |cff00ff00(Highly Recommended)|r ",           value = "SAY" },
            { text = "|cffff4040Yell|r",                                            value = "YELL" },
            { text = "|cffaaaaffParty|r",                                           value = "PARTY" },
            { text = "|cffff7f00Battleground|r |cffff0000(Highly Unrecommended)|r", value = "INSTANCE" },
        }

        local maBGDropdown = CreateFrame("Frame", "huMABGDropdown", maBGCheckbox, "UIDropDownMenuTemplate")
        maBGDropdown:SetPoint("CENTER", maBGCheckbox, "RIGHT", 65, -50)
        UIDropDownMenu_SetWidth(maBGDropdown, 120)

        local function initBGDropdown(self, level)
            for _, channel in ipairs(maBGChannels) do
                local info = UIDropDownMenu_CreateInfo()
                info.text = channel.text
                info.value = channel.value
                info.checked = (HealerUtilsDB.maBGChannel == channel.value)
                info.func = function(self)
                    HealerUtilsDB.maBGChannel = self.value
                    UIDropDownMenu_SetSelectedValue(maBGDropdown, self.value)
                end
                UIDropDownMenu_AddButton(info, level)
            end
        end

        UIDropDownMenu_Initialize(maBGDropdown, initBGDropdown)
        UIDropDownMenu_SetSelectedValue(maBGDropdown, HealerUtilsDB.maBGChannel or "INSTANCE")

        local maBGCover = CreateFrame("Frame", nil, maBGDropdown, "BackdropTemplate")
        maBGCover:SetPoint("CENTER", maBGDropdown, "CENTER", 0, 2)
        maBGCover:SetSize(135, 24)
        maBGCover:EnableMouse(true)
        maBGCover:SetBackdrop({ bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", })
        maBGCover:SetBackdropColor(0.1, 0.1, 0.1, 0.9)
        maBGCover:Hide()

        maBGCheckbox:SetScript("OnClick", function(self)
            HealerUtilsDB.maBG = self:GetChecked()
            if HealerUtilsDB.maBG then
                UIDropDownMenu_EnableDropDown(maBGDropdown)
                maBGCheckbox.Text:SetText("|cffff2020Enable in Battlegrounds|r")
                maBGText:SetText("|cffffd200Output Channel|r")
                maDiv7:SetVertexColor(1, 0.82, 0, 1)
                maBGCover:Hide()
            else
                UIDropDownMenu_DisableDropDown(maBGDropdown)
                maBGCheckbox.Text:SetText("|cffffd200Enable in Battlegrounds|r")
                maBGText:SetText("|cff323232Output Channel|r")
                maDiv7:SetVertexColor(0.5, 0.5, 0.5, 1)
                maBGCover:Show()
            end
        end)

        if HealerUtilsDB.maBG then
            UIDropDownMenu_EnableDropDown(maBGDropdown)
            maBGCheckbox.Text:SetText("|cffff2020Enable in Battlegrounds|r")
            maBGText:SetText("|cffffd200Output Channel|r")
            maDiv7:SetVertexColor(1, 0.82, 0, 1)
            maBGCover:Hide()
        else
            UIDropDownMenu_DisableDropDown(maBGDropdown)
            maBGCheckbox.Text:SetText("|cffffd200Enable in Battlegrounds|r")
            maBGText:SetText("|cff323232Output Channel|r")
            maDiv7:SetVertexColor(0.5, 0.5, 0.5, 1)
            maBGCover:Show()
        end
        maBGCheckbox:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText("|cffff2020Use at your own risk!")
        end)
        maBGCheckbox:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
        end)




        function createAnnounceSettings()
            if not loadCheck then
                return
            end

            local maText3 = mafDeco1:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            maText3:SetPoint("CENTER", -150, -37)
            maText3:SetText("Mana Threshold 1:          %")

            local maText4 = mafDeco1:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            maText4:SetPoint("CENTER", -150, -62)
            maText4:SetText("Mana Threshold 2:          %")

            local maText5 = mafDeco1:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            maText5:SetPoint("CENTER", -150, -87)
            maText5:SetText("Mana Threshold 3:          %")

            local maText6 = mafDeco1:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            maText6:SetPoint("CENTER", -150, -112)
            maText6:SetText("Mana Threshold 4:          %")

            local maText7 = mafDeco1:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            maText7:SetPoint("CENTER", -150, -137)
            maText7:SetText("Mana Threshold 5:          %")

            local maText8 = mafDeco1:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            maText8:SetPoint("CENTER", 100, -37)
            maText8:SetText("|cffffd200Message Cooldown:          seconds|r")

            local maText9 = mafDeco1:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            maText9:SetPoint("CENTER", 150, -77)
            maText9:SetText("|cffff2020(Setting this to '0' may spam, depending on mana fluctuation frequency.)|r")
            maText9:SetScale(0.75)
            if HealerUtilsDB.maCDValue == "0" then
                maText9:Show()
            else
                maText9:Hide()
            end

            local maCDValBox = CreateFrame("EditBox", "huMaCVBox", mafDeco1, "InputBoxTemplate")
            maCDValBox:SetSize(25, 15)
            maCDValBox:SetPoint("CENTER", maText8, "RIGHT", -62.5, 0)
            maCDValBox:SetAutoFocus(false)
            maCDValBox:SetMaxLetters(2)
            maCDValBox:SetNumeric(true)
            maCDValBox:SetText(HealerUtilsDB.maCDValue or 10)
            maCDValBox:SetScript("OnEnterPressed", function(self)
                local input = self:GetText()
                HealerUtilsDB.maCDValue = input
                if input == "0" then
                    maText9:Show()
                else
                    maText9:Hide()
                end
                self:ClearFocus()
            end)
            maCDValBox:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText(
                    "Any value from 1-99")
            end)
            maCDValBox:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
            end)

            local maThreshVal1Box = CreateFrame("EditBox", "huMaTV1Box", mafDeco1, "InputBoxTemplate")
            maThreshVal1Box:SetSize(25, 15)
            maThreshVal1Box:SetPoint("CENTER", maText3, "RIGHT", -25, 0)
            maThreshVal1Box:SetAutoFocus(false)
            maThreshVal1Box:SetMaxLetters(5)
            maThreshVal1Box:SetNumeric(true)
            maThreshVal1Box:SetText(HealerUtilsDB.MAThreshVal1 or 75)
            maThreshVal1Box:SetScript("OnEnterPressed", function(self)
                local input = self:GetText()
                HealerUtilsDB.MAThreshVal1 = input
                self:ClearFocus()
            end)
            maThreshVal1Box:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText("Value between 1-100")
            end)
            maThreshVal1Box:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
            end)
            local maThreshVal2Box = CreateFrame("EditBox", "huMaTV2Box", mafDeco1, "InputBoxTemplate")
            maThreshVal2Box:SetSize(25, 15)
            maThreshVal2Box:SetPoint("CENTER", maText4, "RIGHT", -25, 0)
            maThreshVal2Box:SetAutoFocus(false)
            maThreshVal2Box:SetMaxLetters(5)
            maThreshVal2Box:SetNumeric(true)
            maThreshVal2Box:SetText(HealerUtilsDB.MAThreshVal2 or "50")
            maThreshVal2Box:SetScript("OnEnterPressed", function(self)
                local input = self:GetText()
                HealerUtilsDB.MAThreshVal2 = input
                self:ClearFocus()
            end)
            maThreshVal2Box:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText("Value between 1-100")
            end)
            maThreshVal2Box:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
            end)
            local maThreshVal3Box = CreateFrame("EditBox", "huMaTV3Box", mafDeco1, "InputBoxTemplate")
            maThreshVal3Box:SetSize(25, 15)
            maThreshVal3Box:SetPoint("CENTER", maText5, "RIGHT", -25, 0)
            maThreshVal3Box:SetAutoFocus(false)
            maThreshVal3Box:SetMaxLetters(5)
            maThreshVal3Box:SetNumeric(true)
            maThreshVal3Box:SetText(HealerUtilsDB.MAThreshVal33 or "25")
            maThreshVal3Box:SetScript("OnEnterPressed", function(self)
                local input = self:GetText()
                HealerUtilsDB.MAThreshVal3 = input
                self:ClearFocus()
            end)
            maThreshVal3Box:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText("Value between 1-100")
            end)
            maThreshVal3Box:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
            end)
            local maThreshVal4Box = CreateFrame("EditBox", "huMaTV4Box", mafDeco1, "InputBoxTemplate")
            maThreshVal4Box:SetSize(25, 15)
            maThreshVal4Box:SetPoint("CENTER", maText6, "RIGHT", -25, 0)
            maThreshVal4Box:SetAutoFocus(false)
            maThreshVal4Box:SetMaxLetters(5)
            maThreshVal4Box:SetNumeric(true)
            maThreshVal4Box:SetText(HealerUtilsDB.MAThreshVal4 or "10")
            maThreshVal4Box:SetScript("OnEnterPressed", function(self)
                local input = self:GetText()
                HealerUtilsDB.MAThreshVal4 = input
                self:ClearFocus()
            end)
            maThreshVal4Box:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText("Value between 1-100")
            end)
            maThreshVal4Box:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
            end)
            local maThreshVal5Box = CreateFrame("EditBox", "huMaTV5Box", mafDeco1, "InputBoxTemplate")
            maThreshVal5Box:SetSize(25, 15)
            maThreshVal5Box:SetPoint("CENTER", maText7, "RIGHT", -25, 0)
            maThreshVal5Box:SetAutoFocus(false)
            maThreshVal5Box:SetMaxLetters(5)
            maThreshVal5Box:SetNumeric(true)
            maThreshVal5Box:SetText(HealerUtilsDB.MAThreshVal5 or "5")
            maThreshVal5Box:SetScript("OnEnterPressed", function(self)
                local input = self:GetText()
                HealerUtilsDB.MAThreshVal5 = input
                self:ClearFocus()
            end)
            maThreshVal2Box:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText("Value between 1-100")
            end)
            maThreshVal2Box:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
            end)
        end

        optionsPanel.Tab1 = aboutTab
        optionsPanel.Tab2 = settingsTab
        PanelTemplates_SetNumTabs(optionsPanel, 2)
        PanelTemplates_SetTab(optionsPanel, 1)
        settingsFrame.Tab1 = dbTab
        settingsFrame.Tab2 = maTab
        PanelTemplates_SetNumTabs(settingsFrame, 2)
        PanelTemplates_SetTab(settingsFrame, 1)

        local function selectTab(source, id)
            if source ~= "settingsFrame" then
                PanelTemplates_SetTab(optionsPanel, id)
                aboutFrame:SetShown(id == 1)
                settingsFrame:SetShown(id == 2)
            else
                PanelTemplates_SetTab(settingsFrame, id)
                dbFrame:SetShown(id == 1)
                maFrame:SetShown(id == 2)
            end
        end

        aboutTab:SetScript("OnClick", function() selectTab(nil, 1) end)
        settingsTab:SetScript("OnClick", function()
            selectTab(nil, 2)
            selectTab("settingsFrame", 1)
        end)
        dbTab:SetScript("OnClick", function() selectTab("settingsFrame", 1) end)
        maTab:SetScript("OnClick", function() selectTab("settingsFrame", 2) end)




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
