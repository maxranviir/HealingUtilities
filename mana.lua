local healthPercent = 100
local lastAnnounceTime = 0

local function GetHealthPercent()
    healthPercent = (UnitHealth("player") / UnitHealthMax("player")) * 100
end

function manaAnnounce()
    local _, zoneType = IsInInstance()
    if not HealerUtils.loadAnnounce or healthPercent == 0 or zoneType == "pvp" or not huIsHealer then
        return
    end

    if manaPercent <=75 and manaPercent > 50 and lastManaPercent > 75 then
        SendChatMessage("{star} Mana is at " .. math.floor(manaPercent) .. "%! {star}", "PARTY")
    elseif manaPercent <=50 and manaPercent > 25 and lastManaPercent > 50 then
        SendChatMessage("{circle} Mana is at " .. math.floor(manaPercent) .. "%! {circle}", "PARTY")
    elseif manaPercent <=25 and manaPercent > 10 and lastManaPercent > 25 then
        SendChatMessage("{cross} Mana is at " .. math.floor(manaPercent) .. "%! {cross}", "PARTY")
    elseif manaPercent <=10 and manaPercent > 5 and lastManaPercent > 10 then
        SendChatMessage("{skull} Mana is at " .. math.floor(manaPercent) .. "%! {skull}", "PARTY")
    elseif manaPercent <=5 and lastManaPercent > 5 then
        local currentTime = GetTime()
        if currentTime - lastAnnounceTime >= 10 then
            SendChatMessage("I am out of mana!", "PARTY")
        lastAnnounceTime = currentTime
    end
end
    lastManaPercent = manaPercent
end

