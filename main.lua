local lastAnnounceTime = 0


function manaAnnounce()
    local _, zoneType = IsInInstance()
    if not HealerUtilsDB.loadAnnounce or (not HealerUtilsDB.maBG and zoneType == "pvp") or not huLoadConditions then
        return
    end

    if HealerUtilsDB.maBG and zoneType == "pvp" then
        HealerUtilsDB.maChannel = HealerUtilsDB.maBGChannel
    elseif HealerUtilsDB.maRaidChannel and zoneType == "raid" then
        HealerUtilsDB.maChannel = HealerUtilsDB.maRaidChannel
    elseif HealerUtilsDB.maPartyChannel and zoneType == "party" then
        HealerUtilsDB.maChannel = HealerUtilsDB.maPartyChannel
    end

    local currentTime = GetTime()
    if currentTime - lastAnnounceTime >= HealerUtilsDB.maCDValue then
        if manaPercent <= HealerUtilsDB.MAThreshVal1 and manaPercent > HealerUtilsDB.MAThreshVal2 and lastManaPercent > HealerUtilsDB.MAThreshVal1 then
            SendChatMessage("{star} Mana is at " .. math.floor(manaPercent) .. "%! {star}", HealerUtilsDB.maChannel)
            lastAnnounceTime = currentTime
        elseif manaPercent <= HealerUtilsDB.MAThreshVal2 and manaPercent > HealerUtilsDB.MAThreshVal3 and lastManaPercent > HealerUtilsDB.MAThreshVal2 then
            SendChatMessage("{circle} Mana is at " .. math.floor(manaPercent) .. "%! {circle}", HealerUtilsDB.maChannel)
            lastAnnounceTime = currentTime
        elseif manaPercent <= HealerUtilsDB.MAThreshVal3 and manaPercent > HealerUtilsDB.MAThreshVal4 and lastManaPercent > HealerUtilsDB.MAThreshVal3 then
            SendChatMessage("{cross} Mana is at " .. math.floor(manaPercent) .. "%! {cross}", HealerUtilsDB.maChannel)
            lastAnnounceTime = currentTime
        elseif manaPercent <= HealerUtilsDB.MAThreshVal4 and manaPercent > HealerUtilsDB.MAThreshVal5 and lastManaPercent > HealerUtilsDB.MAThreshVal4 then
            SendChatMessage("{skull} Mana is at " .. math.floor(manaPercent) .. "%! {skull}", HealerUtilsDB.maChannel)
            lastAnnounceTime = currentTime
        elseif manaPercent <= HealerUtilsDB.MAThreshVal5 and lastManaPercent > HealerUtilsDB.MAThreshVal5 then
            SendChatMessage("I am out of mana!", HealerUtilsDB.maChannel)
            lastAnnounceTime = currentTime
        end
    end
    lastManaPercent = manaPercent
end
