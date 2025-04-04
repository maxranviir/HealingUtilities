--SAVED VARIABLES DATA--
if not HealerUtilsDB then HealerUtilsDB = {} end
HealerUtilsDB.inDev = HealerUtilsDB.inDev or false
HealerUtilsDB.debug = HealerUtilsDB.debug or false
HealerUtilsDB.dButtonPosition = HealerUtilsDB.dButtonPosition or { x = 0, y = 0}
HealerUtilsDB.dButtonPosition.x = HealerUtilsDB.dButtonPosition.x or 0
HealerUtilsDB.dButtonPosition.y = HealerUtilsDB.dButtonPosition.y or 0
HealerUtilsDB.loadAnnounce = HealerUtilsDB.loadAnnounce or true
-----------------------------------------------------------------------
--LOAD CONDITIONS-----
huLoadConditions = false
huIsHealer = false
drinkBtn = nil
manaPercent = 100
lastManaPercent = 100



-----------------------------------------------------------------------
print("[Healer Utilities] Version-1.0.0 |cff00ff00Loaded. Parsing...|r")
-----------------------------------------------------------------------
function GetManaPercent()
    manaPercent = (UnitPower("player", 0) / UnitPowerMax("player", 0)) * 100
end
--LOAD CHECKER--
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
    end

    huInit()

elseif event == "PLAYER_ROLES_ASSIGNED" or event == "PLAYER_ENTERING_WORLD" then
        local role = UnitGroupRolesAssigned("player")
        if role == "HEALER" and self.lastRole ~= "HEALER" then
            if not self.roleMsg then
                C_Timer.After(0.5, function()
                    print("[Healer Utilities] " .. 
                        (huClassColor and string.format("|cFF%02X%02X%02X%s|r",
                            huClassColor.r * 255, huClassColor.g * 255, huClassColor.b * 255, huClass)) 
                        .. "|cffffff00 healer detected.|r |cff00ff00Active!|r")
                end)
                self.roleMsg = true
            end
            if drinkBtn then
                drinkBtn:Hide()
            end
        end
        self.lastRole = role
        huIsHealer = (role == "HEALER")

    elseif event == "UNIT_DISPLAYPOWER" and unit == "player" then
        huLoadConditions = loadCheck()
        if huLoadConditions then
            huInit()
        elseif drinkBtn then
            drinkBtn:Hide()
            end

        elseif event == "UNIT_POWER_UPDATE" and unit == "player" and huLoadConditions then
    if type(GetManaPercent) == "function" then
        GetManaPercent()
    end
    if type(buttonVisibilityCheck) == "function" then 
            buttonVisibilityCheck()
        end
        if type(manaAnnounce) == "function" and IsInGroup() and huIsHealer then
                manaAnnounce()
            end

        elseif (event == "BAG_UPDATE" or event == "PLAYER_ENTERING_WORLD") and type(iconUpdate) == "function" then
            iconUpdate()
        end
    end)