function iconUpdate()
    if not drinkBtn or not drinkBtn:IsShown() or InCombatLockdown() then
        return
    end

    bestWater = GetBestWater()
    if bestWater then
        drinkBtn:SetAttribute("item", bestWater.name)
        drinkBtn.tex:SetTexture("Interface\\Icons\\" .. bestWater.icon)
    else
        drinkBtn:SetAttribute("item", nil)
        drinkBtn.tex:SetTexture("Interface\\Icons\\inv_drink_07")
        drinkBtn.cooldown:Clear()
    end
end

function buttonUpdater()
    if not drinkBtn then
        return
    end
    if HealerUtilsDB.dbScaleValue and not InCombatLockdown() then
        local scale = HealerUtilsDB.dbScaleValue
        local x = HealerUtilsDB.dBtnPos.x / scale
        local y = HealerUtilsDB.dBtnPos.y / scale
        drinkBtn:SetScale(HealerUtilsDB.dbScaleValue)
        drinkBtn:ClearAllPoints()
        drinkBtn:SetPoint("CENTER", UIParent, "CENTER", x, y)
    end

    if HealerUtilsDB.dBtnLock then
        drinkBtn:SetScript("OnDragStart", nil)
    else
        drinkBtn:SetScript("OnDragStart", function(self)
            self:StartMoving()
        end)
    end
end

function buttonVisibilityCheck()
    if not drinkBtn then
        return
    end

    if HealerUtilsDB.dBtnCombatHide and InCombatLockdown() then
        drinkBtn:SetAlpha(0.0)
        drinkBtn:SetHighlightTexture("", "ADD")
        drinkBtn:SetScript("OnEnter", nil)
        drinkBtn:SetScript("OnLeave", nil)
        return
    end


    drinkBtn:SetAlpha(1.0)
    drinkBtn:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
    drinkBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        if bestWater and bestWater.itemID then
            GameTooltip:SetItemByID(bestWater.itemID)
        else
            GameTooltip:SetText("No valid water found.")
        end
        GameTooltip:Show()
    end)
    drinkBtn:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    if InCombatLockdown() then
        return
    end

    if zoneType == "pvp" and not HealerUtilsDB.dBtnBG then
        drinkBtn:Hide()
        return
    end

    if UnitIsDead("player") or manaPercent >= 75 or not bestWater then
        if drinkBtn:IsShown() then
            drinkBtn:Hide()
        end
    elseif not drinkBtn:IsShown() and bestWater then
        drinkBtn:Show()
    end
end

function createDrinkBtn()
    if drinkBtn or not huLoadConditions or not HealerUtilsDB.dButton then
        return
    end

    drinkBtn = CreateFrame("Button", "DrinkButtonFrame", UIParent, "SecureActionButtonTemplate")
    drinkBtn:SetAttribute("type", "item")
    drinkBtn:SetPoint("CENTER")
    drinkBtn:SetSize(64, 64)
    drinkBtn:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
    drinkBtn:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress")
    drinkBtn:RegisterForClicks("AnyUp")
    drinkBtn:SetMovable(true)
    drinkBtn:EnableMouse(true)
    drinkBtn:RegisterForDrag("LeftButton")

    drinkBtn.tex = drinkBtn:CreateTexture()
    drinkBtn.tex:SetAllPoints(drinkBtn)

    drinkBtn.cooldown = CreateFrame("Cooldown", nil, drinkBtn, "CooldownFrameTemplate")
    drinkBtn.cooldown:SetAllPoints(drinkBtn)
    drinkBtn.cooldown:SetBlingTexture("Interface\\Cooldown\\star4")
    drinkBtn.cooldown:SetDrawEdge(false)

    drinkBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        if bestWater then
            GameTooltip:SetItemByID(bestWater.itemID)
        else
            GameTooltip:SetText("No valid water found.")
        end
        GameTooltip:Show()
    end)

    drinkBtn:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    drinkBtn:SetScript("OnDragStart", function(self)
        self:StartMoving()
    end)

    drinkBtn:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        local point, _, _, x, y = self:GetPoint()
        HealerUtilsDB.dBtnPos.x = x
        HealerUtilsDB.dBtnPos.y = y
        print("Healer Utilities Button Position Saved at [" .. x .. " , " .. y .. "]!")
    end)

    drinkBtn:SetScript("PostClick", function()
        if bestWater then
            local start = GetTime()
            local duration = 1.5
            drinkBtn.cooldown:SetCooldown(start, duration)
        end
    end)

    bestWater = GetBestWater()
    if bestWater then
        drinkBtn:SetAttribute("item", bestWater.name)
        drinkBtn.tex:SetTexture("Interface\\Icons\\" .. bestWater.icon)
    else
        drinkBtn:SetAttribute("item", nil)
        drinkBtn.tex:SetTexture("Interface\\Icons\\inv_drink_07")
        drinkBtn.cooldown:Clear()
    end
    buttonVisibilityCheck()
    drinkBtn:ClearAllPoints()
    drinkBtn:SetPoint("CENTER", UIParent, "CENTER", HealerUtilsDB.dBtnPos.x, HealerUtilsDB.dBtnPos.y)
end
