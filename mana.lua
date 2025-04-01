function manaAnnounce()
    if manaPercent <=75 and manaPercent > 50 and lastManaPercent > 75 then
        SendChatMessage("{star} Mana is at " .. math.floor(manaPercent) .. "%! {star}", "PARTY")
    end

    if manaPercent <=50 and manaPercent > 25 and lastManaPercent > 50 then
        SendChatMessage("{circle} Mana is at " .. math.floor(manaPercent) .. "%! {circle}", "PARTY")
    end

    if manaPercent <=25 and manaPercent > 10 and lastManaPercent > 25 then
        SendChatMessage("{cross} Mana is at " .. math.floor(manaPercent) .. "%! {cross}", "PARTY")
    end

    if manaPercent <=10 and manaPercent > 0 and lastManaPercent > 10 then
        SendChatMessage("{skull} Mana is at " .. math.floor(manaPercent) .. "%! {skull}", "PARTY")
    end

    if manaPercent == 0 and lastManaPercent > 0 then
        SendChatMessage("I am out of mana!", "PARTY")
    end

    lastManaPercent = manaPercent
end

