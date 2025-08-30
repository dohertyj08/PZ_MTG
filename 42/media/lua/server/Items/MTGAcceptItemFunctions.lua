-- MTG Binder Accept Item Functions
-- Controls which items can be placed in which binders

MTG_AcceptItemFunction = MTG_AcceptItemFunction or {}

-- Helper function to check if item is an MTG Beta card (not packs/decks/binders)
local function isMTGBetaCard(item)
    if not item then
        return false
    end
    
    -- Only accept items with DisplayCategory "MTG Card"
    local category = item:getDisplayCategory()
    return category == "MTG Card"
end

-- Complete Set Binder - Accepts all MTG Beta cards
function MTG_AcceptItemFunction.beta_complete(container, item)
    return isMTGBetaCard(item)
end

-- Power Nine Binder - Accepts only the 9 most valuable cards
function MTG_AcceptItemFunction.power_nine(container, item)
    if not isMTGBetaCard(item) then
        return false
    end
    
    -- Power Nine card list - using full type names
    local powerNineCards = {
        ["mtgcards.ancestral-recall-48"] = true,
        ["mtgcards.black-lotus-149"] = true,
        ["mtgcards.mox-emerald-191"] = true,
        ["mtgcards.mox-jet-192"] = true,
        ["mtgcards.mox-pearl-193"] = true,
        ["mtgcards.mox-ruby-194"] = true,
        ["mtgcards.mox-sapphire-195"] = true,
        ["mtgcards.time-walk-245"] = true,
        ["mtgcards.timetwister-246"] = true
    }
    
    local fullType = item:getFullType()
    return powerNineCards[fullType] == true
end