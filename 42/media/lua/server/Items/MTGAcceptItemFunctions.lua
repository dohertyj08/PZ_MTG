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

-- Shared validation function for all binders
local function acceptAllMTGCards(container, item)
    return isMTGBetaCard(item)
end

-- Complete Set Binder - Accepts all MTG Beta cards
function MTG_AcceptItemFunction.beta_complete(container, item)
    return acceptAllMTGCards(container, item)
end

-- Power Nine Binder - Accepts all MTG Beta cards
function MTG_AcceptItemFunction.power_nine(container, item)
    return acceptAllMTGCards(container, item)
end

-- Land Binder - Accepts all MTG Beta cards
function MTG_AcceptItemFunction.land_binder(container, item)
    return acceptAllMTGCards(container, item)
end