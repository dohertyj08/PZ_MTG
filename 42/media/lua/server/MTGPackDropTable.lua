-- MTG Pack Drop Table for Beta packs
-- Author: James Doherty

require("MTGCardLists")

-- Track currently running pack openings (for animation timing)
MTGcurrentlyRunning = MTGcurrentlyRunning or 0

-- Helper function to get random card from rarity table
local function getRandomCardFromRarityTable(rarityTable)
    if not rarityTable or #rarityTable == 0 then
        return nil
    end
    local index = ZombRand(#rarityTable) + 1
    return rarityTable[index]
end

-- Helper function to get day length settings
local function getDayLengthSettings()
    local gameOptions = getSandboxOptions()
    local dayLengthMinutes = gameOptions:getOptionByName("DayLength"):getValue()
    
    local dayLengthHours = dayLengthMinutes / 60
    local settings = {
        delayTicks = 200,
        increasedDelayTicks = 300
    }
    
    if dayLengthHours >= 8 then
        settings.delayTicks = 100
        settings.increasedDelayTicks = 150
    elseif dayLengthHours >= 4 then
        settings.delayTicks = 150
        settings.increasedDelayTicks = 200
    elseif dayLengthHours >= 2 then
        settings.delayTicks = 200
        settings.increasedDelayTicks = 250
    end
    
    return settings.delayTicks, settings.increasedDelayTicks
end

-- Beta Booster Pack opening function
-- 15 cards: 11 commons, 3 uncommons, 1 rare
-- Basic lands can replace commons/uncommons
-- Island has 1/121 chance to replace the rare
function open_booster_pack_beta(items, result, player)
    local player = getSpecificPlayer(0)
    player:getEmitter():playSound("packOpen2")
    
    local cardQueue = {}
    
    -- Generate 11 commons (lands can replace)
    for i = 1, 11 do
        local selectedCard = nil
        -- 20% chance for a basic land instead of common
        if ZombRand(5) == 0 then
            selectedCard = getRandomCardFromRarityTable(beta_lands)
        else
            selectedCard = getRandomCardFromRarityTable(beta_c)
        end
        if selectedCard then
            table.insert(cardQueue, selectedCard)
        end
    end
    
    -- Generate 3 uncommons (lands can replace)
    for i = 1, 3 do
        local selectedCard = nil
        -- 10% chance for a basic land instead of uncommon
        if ZombRand(10) == 0 then
            selectedCard = getRandomCardFromRarityTable(beta_lands)
        else
            selectedCard = getRandomCardFromRarityTable(beta_u)
        end
        if selectedCard then
            table.insert(cardQueue, selectedCard)
        end
    end
    
    -- Generate 1 rare
    -- Island has 1/121 chance to replace rare (Beta print run specifics)
    local rareCard = nil
    if ZombRand(121) == 0 then
        -- Island replaces the rare
        rareCard = "mtgcards.island"
    else
        rareCard = getRandomCardFromRarityTable(beta_r)
    end
    if rareCard then
        table.insert(cardQueue, rareCard)
    end
    
    -- Add all cards immediately (simplified for testing)
    for _, card in ipairs(cardQueue) do
        if card then
            player:getInventory():AddItem(card)
        end
    end
    
    print("MTGBeta42: Opened booster pack - " .. #cardQueue .. " cards added")
end

-- Beta Starter Deck opening function
-- 60 cards: 45 commons, 13 uncommons, 2 rares
-- Basic lands can replace commons/uncommons
function open_starter_deck_beta(items, result, player)
    local player = getSpecificPlayer(0)
    player:getEmitter():playSound("packOpen2")
    
    MTGcurrentlyRunning = MTGcurrentlyRunning + 1
    local cardQueue = {}
    local delayTicks, increasedDelayTicks = getDayLengthSettings()
    
    -- Generate 45 commons (lands can replace)
    for i = 1, 45 do
        local selectedCard = nil
        -- 40% chance for a basic land in starter deck (need mana base)
        if ZombRand(5) < 2 then
            selectedCard = getRandomCardFromRarityTable(beta_lands)
        else
            selectedCard = getRandomCardFromRarityTable(beta_c)
        end
        if selectedCard then
            table.insert(cardQueue, selectedCard)
        end
    end
    
    -- Generate 13 uncommons (lands can replace)
    for i = 1, 13 do
        local selectedCard = nil
        -- 15% chance for a basic land instead of uncommon
        if ZombRand(100) < 15 then
            selectedCard = getRandomCardFromRarityTable(beta_lands)
        else
            selectedCard = getRandomCardFromRarityTable(beta_u)
        end
        if selectedCard then
            table.insert(cardQueue, selectedCard)
        end
    end
    
    -- Generate 2 rares (no land replacement for rares in starter)
    for i = 1, 2 do
        local rareCard = getRandomCardFromRarityTable(beta_r)
        if rareCard then
            table.insert(cardQueue, rareCard)
        end
    end
    
    -- Shuffle the deck
    for i = #cardQueue, 2, -1 do
        local j = ZombRand(i) + 1
        cardQueue[i], cardQueue[j] = cardQueue[j], cardQueue[i]
    end
    
    -- Add all cards at once (no animation for 60 cards)
    for _, card in ipairs(cardQueue) do
        if card then
            player:getInventory():AddItem(card)
        end
    end
    
    MTGcurrentlyRunning = MTGcurrentlyRunning - 1
    
    -- Show completion message (texture display disabled for now)
    print("MTGBeta42: Opened starter deck - " .. #cardQueue .. " cards added")
end