-- MTG Binder Accept Item Functions
-- Controls which items can be placed in binders

MTG_AcceptItemFunction = MTG_AcceptItemFunction or {}

-- Single function for all MTG binders - accepts MTG cards only
function MTG_AcceptItemFunction.acceptMTGCards(container, item)
    if not item then
        return false
    end
    
    -- Only accept items with DisplayCategory "MTG Card"
    local category = item:getDisplayCategory()
    return category == "MTG Card"
end