debugPrint = function(...) end

local function updateDebugPrint()
    if HealerUtilsDB.debug then
        debugPrint = function(...) print(...) end
    else
        debugPrint = function(...) end
    end
end

SLASH_HEALUTILS1 = "/hutil"
SlashCmdList["HEALUTILS"] = function(msg)
if msg == "debug" then
    HealerUtilsDB.debug = not HealerUtilsDB.debug
    print("[Healer Utilities] |cffe08612Debug|r |ccffffff00is now|r", HealerUtilsDB.debug and "|cff00ff00Enabled|r" or "|cffff0000Disabled|r")
    return
end
if msg == "toggleindev" then
    HealerUtilsDB.inDev = not HealerUtilsDB.inDev
    print("[Healer Utilities] |cff00eeffinDev|r |cffffff00is now|r", HealerUtilsDB.inDev and "|cff00ff00Enabled.|r |cffffff00Experimental features are now loaded. You may experience bugs or errors." or "|cffff0000Disabled|r")
    return
end

if msg == "options" then
    if not HealerUtilsDB.inDev and not createOptionsPanel() then
        return
    end

    if not optionsPanel then
        createOptionsPanel()
    end

    if optionsPanel:IsShown() then
            optionsPanel:Hide()
        else
            optionsPanel:Show()
            end
            end
        end

