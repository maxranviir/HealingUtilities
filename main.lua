local lastAnnounceTime = 0


function manaAnnounce()
    local _, zoneType = IsInInstance()
    if not HealerUtilsDB.loadAnnounce or zoneType == "pvp" then
        return
    end

    local currentTime = GetTime()
    if currentTime - lastAnnounceTime >= 10 then
        if manaPercent <= 75 and manaPercent > 50 and lastManaPercent > 75 then
            SendChatMessage("{star} Mana is at " .. math.floor(manaPercent) .. "%! {star}", "PARTY")
            lastAnnounceTime = currentTime
        elseif manaPercent <= 50 and manaPercent > 25 and lastManaPercent > 50 then
            SendChatMessage("{circle} Mana is at " .. math.floor(manaPercent) .. "%! {circle}", "PARTY")
            lastAnnounceTime = currentTime
        elseif manaPercent <= 25 and manaPercent > 10 and lastManaPercent > 25 then
            SendChatMessage("{cross} Mana is at " .. math.floor(manaPercent) .. "%! {cross}", "PARTY")
            lastAnnounceTime = currentTime
        elseif manaPercent <= 10 and manaPercent > 5 and lastManaPercent > 10 then
            SendChatMessage("{skull} Mana is at " .. math.floor(manaPercent) .. "%! {skull}", "PARTY")
            lastAnnounceTime = currentTime
        elseif manaPercent <= 5 and lastManaPercent > 5 then
            SendChatMessage("I am out of mana!", "PARTY")
            lastAnnounceTime = currentTime
        end
    end
    lastManaPercent = manaPercent
end
