require 'Items/ProceduralDistributions'
require 'Items/SuburbsDistributions'
require 'Items/Distributions'

-- MTG Card Pack World Distributions
-- Adds MTG packs to various world locations

local spawnRate = SandboxVars.MTG and SandboxVars.MTG.spawnRate or 1

-- Add to procedural distributions
local function addToProceduralDistributions()
    -- Bookstore shelves
    table.insert(ProceduralDistributions.list["BookstoreMisc"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["BookstoreMisc"].items, 0.5 * spawnRate)
    table.insert(ProceduralDistributions.list["BookstoreMisc"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["BookstoreMisc"].items, 0.2 * spawnRate)
    
    -- Gas station counters
    table.insert(ProceduralDistributions.list["GasStorageCombo"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["GasStorageCombo"].items, 0.3 * spawnRate)
    
    -- Grocery store shelves
    table.insert(ProceduralDistributions.list["StoreShelfCombo"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["StoreShelfCombo"].items, 0.2 * spawnRate)
    
    -- School lockers
    table.insert(ProceduralDistributions.list["SchoolLockers"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["SchoolLockers"].items, 0.4 * spawnRate)
    
    -- Bedroom drawers
    table.insert(ProceduralDistributions.list["BedroomDresser"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.1 * spawnRate)
    
    -- Kids bedroom
    table.insert(ProceduralDistributions.list["WardrobeChild"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["WardrobeChild"].items, 0.3 * spawnRate)
    
    -- Crate distributions
    table.insert(ProceduralDistributions.list["CrateToys"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["CrateToys"].items, 0.8 * spawnRate)
    table.insert(ProceduralDistributions.list["CrateToys"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["CrateToys"].items, 0.3 * spawnRate)
end

-- Initialize distributions if enabled
if SandboxVars.MTG and SandboxVars.MTG.enableMod then
    addToProceduralDistributions()
end