--////////////////////\\\\\\\\\\\\\\\\\\\\\--
----------------===GLOBALS===----------------
huLoadConditions = false
huIsHealer = false
drinkBtn = nil
manaPercent = 100
lastManaPercent = 100
local lastRole = nil
local roleMsg = false
--==============================================--

--//////////////////////\\\\\\\\\\\\\\\\\\\\\\\\--
----------------===CORE HANDLER===----------------
local coreFrame = CreateFrame("Frame")
coreFrame:RegisterEvent("PLAYER_LOGIN")
coreFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
coreFrame:RegisterEvent("PLAYER_ROLES_ASSIGNED")
coreFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
coreFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
coreFrame:RegisterEvent("PLAYER_DEAD")
coreFrame:RegisterEvent("UNIT_DISPLAYPOWER")
coreFrame:RegisterEvent("UNIT_POWER_UPDATE")
coreFrame:RegisterEvent("BAG_UPDATE")
coreFrame:SetScript("OnEvent", function(self, event, unit)
    if event == "PLAYER_LOGIN" then
        -------------------------------------------------------===LOAD  CHECK===-------------------------------------------------------
        loadCheck = function()
            huClass = select(2, UnitClass("player"))
            local manaClass = { PALADIN = true, HUNTER = true, PRIEST = true, SHAMAN = true, MAGE = true, WARLOCK = true, DRUID = true }
            huClassColor = RAID_CLASS_COLORS[huClass]
            if huClass == "DRUID" then
                local form = GetShapeshiftForm()
                local manaForms = { [0] = true, [4] = true, [5] = true }
                return manaForms[form] == true
            else
                return manaClass[huClass] == true
            end
        end

        huLoadConditions = loadCheck()

        if not huLoadConditions then
            C_Timer.After(3, function()
                print("[Healer Utilities] " ..
                    (huClassColor and string.format("|cFF%02X%02X%02X%s|r",
                        huClassColor.r * 255, huClassColor.g * 255, huClassColor.b * 255, huClass))
                    .. "|cffffff00 detected.|r |cffff0000Disabled.|r")
            end)
            return
        else
            createDrinkBtn()
        end
        -------------------------------------------------------------------------------------------------------------------------------

        ------------------------------------------------------===HEALER  CHECK===------------------------------------------------------
    elseif (event == "PLAYER_ROLES_ASSIGNED" or (event == "PLAYER_ENTERING_WORLD" and IsInGroup()))
        and not roleMsg then
        local role = UnitGroupRolesAssigned("player")
        huIsHealer = (role == "HEALER")
        if not huIsHealer then
            return
        end
        local message = "[Healer Utilities] " ..
            (huClassColor and string.format("|cFF%02X%02X%02X%s|r",
                huClassColor.r * 255, huClassColor.g * 255, huClassColor.b * 255, huClass))
            .. "|cffffff00 healer detected.|r |cff00ff00Active!|r"
        if event == "PLAYER_ENTERING_WORLD" then
            C_Timer.After(3, function()
                print(message)
            end)
        else
            print(message)
        end
        roleMsg = true
        ------------------------------------------------------------------------------------------------------------------------------

        ----------------------------------------------------===DRUID  CONDITIONS===---------------------------------------------------
    elseif event == "UNIT_DISPLAYPOWER" and unit == "player" then
        huLoadConditions = loadCheck()
        if huLoadConditions and not drinkBtn then
            createDrinkBtn()
        else
            drinkBtn:Hide()
        end
        ------------------------------------------------------------------------------------------------------------------------------

        ------------------------------------------------------===MANA PERCENT===------------------------------------------------------
    elseif event == "UNIT_POWER_UPDATE" and unit == "player" and huLoadConditions then
        manaPercent = (UnitPower("player", 0) / UnitPowerMax("player", 0)) * 100
        buttonVisibilityCheck()
        if not UnitIsDead("player") and manaPercent < lastManaPercent and IsInGroup() and huIsHealer then
            manaAnnounce()
        end
        ------------------------------------------------------------------------------------------------------------------------------
        ------------------------------------------------------===ICON  UPDATE===------------------------------------------------------
    elseif event == "BAG_UPDATE" or event == "PLAYER_ENTERING_WORLD" then
        iconUpdate()
    end
end)
--==========================================================================================================================--
