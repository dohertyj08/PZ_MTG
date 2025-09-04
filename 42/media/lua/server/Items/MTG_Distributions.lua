-- MTG Card Spawning Distribution System

require 'Items/ProceduralDistributions'
require 'Items/SuburbsDistributions'

-- Regular empty binders for places that sell empty binders
local function getRandomEmptyBinder()
    local rand = ZombRand(5) -- 0-4
    if rand < 2 then
        return "mtgcards.complete_set_binder"
    elseif rand < 4 then
        return "mtgcards.power_nine_binder"
    else
        return "mtgcards.land_binder"
    end
end


-- Get spawn rate multiplier from sandbox
local function getSpawnRate()
    return SandboxVars.MTG.SpawnRate or 1.0
end

-- Apply spawn rates with sandbox multiplier
local function addMTGSpawns()
    local spawnRate = getSpawnRate()
    
    -- COMIC STORES
    -- ComicStoreShelfComics - Booster packs (25, 10, 10, 5, 5), Starter decks (6.25, 2.5, 2.5, 1.25)
    table.insert(ProceduralDistributions.list["ComicStoreShelfComics"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["ComicStoreShelfComics"].items, 25 * spawnRate)
    table.insert(ProceduralDistributions.list["ComicStoreShelfComics"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["ComicStoreShelfComics"].items, 10 * spawnRate)
    table.insert(ProceduralDistributions.list["ComicStoreShelfComics"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["ComicStoreShelfComics"].items, 10 * spawnRate)
    table.insert(ProceduralDistributions.list["ComicStoreShelfComics"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["ComicStoreShelfComics"].items, 5 * spawnRate)
    table.insert(ProceduralDistributions.list["ComicStoreShelfComics"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["ComicStoreShelfComics"].items, 5 * spawnRate)
    
    table.insert(ProceduralDistributions.list["ComicStoreShelfComics"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["ComicStoreShelfComics"].items, 6.25 * spawnRate)
    table.insert(ProceduralDistributions.list["ComicStoreShelfComics"].items, "mtgcards.starter_deck_beta") 
    table.insert(ProceduralDistributions.list["ComicStoreShelfComics"].items, 2.5 * spawnRate)
    table.insert(ProceduralDistributions.list["ComicStoreShelfComics"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["ComicStoreShelfComics"].items, 2.5 * spawnRate)
    table.insert(ProceduralDistributions.list["ComicStoreShelfComics"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["ComicStoreShelfComics"].items, 1.25 * spawnRate)
    
    -- ComicStoreCounter - Booster packs (15) (increased to compensate for no singles)
    table.insert(ProceduralDistributions.list["ComicStoreCounter"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["ComicStoreCounter"].items, 15 * spawnRate)
    
    -- ComicStoreShelfGames - Starter decks (25, 10, 10, 5) - add alongside existing
    table.insert(ProceduralDistributions.list["ComicStoreShelfGames"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["ComicStoreShelfGames"].items, 25 * spawnRate)
    table.insert(ProceduralDistributions.list["ComicStoreShelfGames"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["ComicStoreShelfGames"].items, 10 * spawnRate)
    table.insert(ProceduralDistributions.list["ComicStoreShelfGames"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["ComicStoreShelfGames"].items, 10 * spawnRate)
    table.insert(ProceduralDistributions.list["ComicStoreShelfGames"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["ComicStoreShelfGames"].items, 5 * spawnRate)
    
    -- ComicStoreDisplayBooks - Empty binders (5)
    for i = 1, 5 do
        table.insert(ProceduralDistributions.list["ComicStoreDisplayBooks"].items, function() return getRandomEmptyBinder() end)
        table.insert(ProceduralDistributions.list["ComicStoreDisplayBooks"].items, spawnRate)
    end
    
    -- ComicStoreDisplayDice - MTG items at RPGmanual rate (0.1)
    table.insert(ProceduralDistributions.list["ComicStoreDisplayDice"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["ComicStoreDisplayDice"].items, 0.1 * spawnRate)
    table.insert(ProceduralDistributions.list["ComicStoreDisplayDice"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["ComicStoreDisplayDice"].items, 0.1 * spawnRate)
    
    -- BOOKSTORES
    -- BookStoreCounter - Booster packs (5)
    table.insert(ProceduralDistributions.list["BookStoreCounter"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["BookStoreCounter"].items, 5 * spawnRate)
    
    -- BookstoreMisc - Booster packs (0.5), Starter decks (0.2)
    table.insert(ProceduralDistributions.list["BookstoreMisc"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["BookstoreMisc"].items, 0.5 * spawnRate)
    table.insert(ProceduralDistributions.list["BookstoreMisc"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["BookstoreMisc"].items, 0.2 * spawnRate)
    
    -- BookStoreBooks - Empty binders (very rare - 0.1)
    table.insert(ProceduralDistributions.list["BookStoreBooks"].items, function() return getRandomEmptyBinder() end)
    table.insert(ProceduralDistributions.list["BookStoreBooks"].items, 0.1 * spawnRate)
    
    -- TOY STORES
    -- CrateToys - Booster packs (10), Starter decks (1)
    table.insert(ProceduralDistributions.list["CrateToys"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["CrateToys"].items, 10 * spawnRate)
    table.insert(ProceduralDistributions.list["CrateToys"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["CrateToys"].items, 1 * spawnRate)
    
    -- GigamartToys - Booster packs (10)
    table.insert(ProceduralDistributions.list["GigamartToys"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["GigamartToys"].items, 10 * spawnRate)
    
    -- GiftStoreToys - Booster packs (3)
    table.insert(ProceduralDistributions.list["GiftStoreToys"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["GiftStoreToys"].items, 3 * spawnRate)
    
    -- PAWN SHOPS
    -- PawnShopShelves - Booster packs (small=1), Starter decks (small=1)
    table.insert(ProceduralDistributions.list["PawnShopShelves"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["PawnShopShelves"].items, 1 * spawnRate)
    table.insert(ProceduralDistributions.list["PawnShopShelves"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["PawnShopShelves"].items, 1 * spawnRate)
    
    -- SCHOOLS
    -- SchoolLockers - Booster packs (small=1), Starter decks (very small=0.1)
    table.insert(ProceduralDistributions.list["SchoolLockers"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["SchoolLockers"].items, 1 * spawnRate)
    table.insert(ProceduralDistributions.list["SchoolLockers"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["SchoolLockers"].items, 0.1 * spawnRate)
    
    -- ClassroomDesk - Booster packs (small=1), Starter decks (very small=0.1)
    table.insert(ProceduralDistributions.list["ClassroomDesk"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["ClassroomDesk"].items, 1 * spawnRate)
    table.insert(ProceduralDistributions.list["ClassroomDesk"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["ClassroomDesk"].items, 0.1 * spawnRate)
    
    -- UniversityWardrobe - Booster packs (small=1), Starter decks (very small=0.1)
    table.insert(ProceduralDistributions.list["UniversityWardrobe"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["UniversityWardrobe"].items, 1 * spawnRate)
    table.insert(ProceduralDistributions.list["UniversityWardrobe"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["UniversityWardrobe"].items, 0.1 * spawnRate)
    
    -- Bag_Schoolbag - Booster packs (12.0), Starter decks (1.0)
    table.insert(SuburbsDistributions.Bag_Schoolbag.items, "mtgcards.booster_pack_beta")
    table.insert(SuburbsDistributions.Bag_Schoolbag.items, 12.0 * spawnRate)
    table.insert(SuburbsDistributions.Bag_Schoolbag.items, "mtgcards.starter_deck_beta")
    table.insert(SuburbsDistributions.Bag_Schoolbag.items, 1.0 * spawnRate)
    
    -- ZOMBIE INVENTORIES - Only booster packs (increased rates to compensate)
    -- inventorymale/inventoryfemale - Booster packs (0.15)
    table.insert(SuburbsDistributions.all.inventoryfemale.items, "mtgcards.booster_pack_beta")
    table.insert(SuburbsDistributions.all.inventoryfemale.items, 0.15 * spawnRate)
    
    table.insert(SuburbsDistributions.all.inventorymale.items, "mtgcards.booster_pack_beta")
    table.insert(SuburbsDistributions.all.inventorymale.items, 0.15 * spawnRate)
    
    -- Outfit_Student - Booster packs (4.5)
    table.insert(SuburbsDistributions.Outfit_Student.items, "mtgcards.booster_pack_beta")
    table.insert(SuburbsDistributions.Outfit_Student.items, 4.5 * spawnRate)
    
    -- BEDROOMS
    -- WardrobeChild - Booster packs (medium=5), Starter decks (small=1)
    table.insert(ProceduralDistributions.list["WardrobeChild"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["WardrobeChild"].items, 5 * spawnRate)
    table.insert(ProceduralDistributions.list["WardrobeChild"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["WardrobeChild"].items, 1 * spawnRate)
    
    -- WardrobeGeneric - Booster packs (small=1), Starter decks (very small=0.1)
    table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 1 * spawnRate)
    table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 0.1 * spawnRate)
    
    -- BedroomDresser - Booster packs (very small=0.1)
    table.insert(ProceduralDistributions.list["BedroomDresser"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["BedroomDresser"].items, 0.1 * spawnRate)
    
    -- BedroomDresserChild - Booster packs (medium=5), Starter decks (small=1)
    table.insert(ProceduralDistributions.list["BedroomDresserChild"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["BedroomDresserChild"].items, 5 * spawnRate)
    table.insert(ProceduralDistributions.list["BedroomDresserChild"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["BedroomDresserChild"].items, 1 * spawnRate)
    
    -- BedroomSidetable - Booster packs (small=1), Starter decks (very small=0.1)
    table.insert(ProceduralDistributions.list["BedroomSidetable"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["BedroomSidetable"].items, 1 * spawnRate)
    table.insert(ProceduralDistributions.list["BedroomSidetable"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["BedroomSidetable"].items, 0.1 * spawnRate)
    
    -- BedroomSidetableChild - Booster packs (medium=5), Starter decks (small=1)
    table.insert(ProceduralDistributions.list["BedroomSidetableChild"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["BedroomSidetableChild"].items, 5 * spawnRate)
    table.insert(ProceduralDistributions.list["BedroomSidetableChild"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["BedroomSidetableChild"].items, 1 * spawnRate)
    
    -- RESIDENTIAL BOOKSHELVES
    -- LivingRoomShelf - Empty binders (very rare - 0.05)
    table.insert(ProceduralDistributions.list["LivingRoomShelf"].items, function() return getRandomEmptyBinder() end)
    table.insert(ProceduralDistributions.list["LivingRoomShelf"].items, 0.05 * spawnRate)
    
    -- LivingRoomShelfNoTapes - Empty binders (very rare - 0.05)  
    table.insert(ProceduralDistributions.list["LivingRoomShelfNoTapes"].items, function() return getRandomEmptyBinder() end)
    table.insert(ProceduralDistributions.list["LivingRoomShelfNoTapes"].items, 0.05 * spawnRate)
end

-- Initialize spawning when distributions are ready
Events.OnPostDistributionMerge.Add(addMTGSpawns)