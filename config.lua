debugPrint = function(...) end

local function updateDebugPrint()
    if HealerUtilsDB.debug then
        debugPrint = function(...) print(...) end
    else
        debugPrint = function(...) end
    end
end
