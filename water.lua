debugPrint("|cFF00FF00[INFO]|r debug water.lua loaded")

waterItems = {
    [8079] = { name = "Conjured Crystal Water", level = 55, itemID = 8079, icon = "inv_drink_18"},
    [19318] = { name = "Bottled Alterac Spring Water", level = 55, itemID = 19318, icon = "inv_drink_11"},
    [8078] = { name = "Conjured Sparkling Water", level = 45, itemID = 8078, icon = "inv_drink_11"},
    [8766] = { name = "Morning Glory Dew", level = 45, itemID = 8766, icon = "inv_potion_01"},
    [8077] = { name = "Conjured Mineral Water", level = 35, itemID = 8077, icon = "inv_drink_09"},
    [1645] = { name = "Moonberry Juice", level = 35, itemID = 1645, icon = "inv_drink_02"},
    [3772] = { name = "Conjured Spring Water", level = 25, itemID = 3772, icon = "inv_drink_10"},
    [1708] = { name = "Sweet Nectar", level = 25, itemID = 1708, icon = "inv_drink_12"},
    [2136] = { name = "Conjured Purified Water", level = 15, itemID = 2136, icon = "inv_drink_milk_02"},
    [1205] = { name = "Melon Juice", level = 15, itemID = 1205, icon = "inv_drink_09"}
}

waterPriority = { 8079, 19318, 8078, 8766, 8077, 1645, 3772, 1708, 2136, 1205 }

debugPrint("|cFF00FF00[INFO]|r DEBUG: water.lua loaded successfully!")
debugPrint("|cFF00FF00[INFO]|r DEBUG: waterPriority contains", #waterPriority, "items.")



function GetBestWater()
    debugPrint("|cFF00FF00[INFO]|r DEBUG: Entering GetBestWater()")

    local playerLvl = UnitLevel("player") or 1
    debugPrint("|cFF00FF00[INFO]|r DEBUG: Player Level:", playerLvl)

    if type(waterPriority) ~= "table" then
        debugPrint("ERROR: waterPriority is not a table!")
        return nil
    end

    if type(waterItems) ~= "table" then
        debugPrint("ERROR: waterItems is not a table!")
return nil
end

for _, itemID in ipairs(waterPriority) do
    local data = waterItems[itemID]

    if not data then
        debugPrint("ERROR: No data found for itemID:", itemID)
    else

        if not data.level then
        debugPrint("ERROR: Missing Level for itemID:", itemID)
        else

            local requiredLevel = tonumber(data.level)
    if not requiredLevel then
        debugPrint("ERROR: data.level is not a number for itemID:", itemID)
        else

            local itemCount = GetItemCount(itemID) or 0
    debugPrint("|cFF00FF00[INFO]|r DEBUG: Checking Item:", data.name, "| Level:", requiredLevel, "| Count:", itemCount)

    if itemCount > 0 and playerLvl >= requiredLevel then
        debugPrint("|cFF00FF00[INFO]|r DEBUG: Best Water Found:", data.name)
        return data
    end
end
end
end
end

debugPrint("DEBUG: No valid water found.")
return nil
end




