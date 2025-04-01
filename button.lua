local function iconUpdate()
    if not drinkBtn or not drinkBtn:IsShown() then
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

    function manaCheckBtnToggle()
    if not drinkBtn then
        return
    end

    if manaPercent >=75 then
        if drinkBtn:IsShown() then
            drinkBtn:Hide()
        end
    elseif not drinkBtn:IsShown() and not InCombatLockdown() then
        if bestWater then
            drinkBtn:Show()
        end
    end
    if not bestWater and drinkBtn:IsShown() then
        drinkBtn:Hide()
            end
        end

function createDrinkBtn()
    if drinkBtn then
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
                GameTooltip:SetText("No valid water.")
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
            if not HealerUtilsDB.position then HealerUtilsDB.position = { x = 0, y = 0} end
            local point, _, _, x, y = self:GetPoint()
            HealerUtilsDB.position.x = x
            HealerUtilsDB.position.y = y
            print("Healer Utilities Button Position Saved at ["..x.." , "..y.."]!")
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
        manaCheckBtnToggle()
    end

local bagCheckFrame = CreateFrame("Frame")
bagCheckFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
bagCheckFrame:RegisterEvent("BAG_UPDATE")
bagCheckFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" or event == "BAG_UPDATE" then
        iconUpdate()
    end
end)
