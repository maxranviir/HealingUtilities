debugEnable = true

debugPrint = function(...) end

local function updateDebugPrint()
    if debugEnable then
        debugPrint = function(...) print(...) end
    else
        debugPrint = function(...) end
    end
end

SLASH_HEALUTILS1 = "/hutil"
SlashCmdList["HEALUTILS"] = function(msg)
if msg == "debug" then
    debugEnable = not debugEnable
    print("Healer Utilities: Debug:", debugEnable and "Enabled" or "Disabled")
end
end


