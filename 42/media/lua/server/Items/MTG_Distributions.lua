-- MTG Card Spawning Distribution System

require 'Items/ProceduralDistributions'
require 'Items/SuburbsDistributions'



-- Apply spawn rates
local function addMTGSpawns()
    local spawnRate = 1.0
    
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
    table.insert(ProceduralDistributions.list["ComicStoreDisplayBooks"].items, "mtgcards.complete_set_binder")
    table.insert(ProceduralDistributions.list["ComicStoreDisplayBooks"].items, 5 * spawnRate)
    table.insert(ProceduralDistributions.list["ComicStoreDisplayBooks"].items, "mtgcards.power_nine_binder")
    table.insert(ProceduralDistributions.list["ComicStoreDisplayBooks"].items, 5 * spawnRate)
    table.insert(ProceduralDistributions.list["ComicStoreDisplayBooks"].items, "mtgcards.land_binder")
    table.insert(ProceduralDistributions.list["ComicStoreDisplayBooks"].items, 5 * spawnRate)
    
    -- ComicStoreDisplayDice - MTG items at RPGmanual rate (1)
    table.insert(ProceduralDistributions.list["ComicStoreDisplayDice"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["ComicStoreDisplayDice"].items, 1 * spawnRate)
    table.insert(ProceduralDistributions.list["ComicStoreDisplayDice"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["ComicStoreDisplayDice"].items, 1 * spawnRate)
    
    -- BOOKSTORES
    -- BookStoreCounter - Booster packs (5)
    table.insert(ProceduralDistributions.list["BookStoreCounter"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["BookStoreCounter"].items, 5 * spawnRate)
    
    -- BookstoreMisc - Booster packs (2), Starter decks (1)
    table.insert(ProceduralDistributions.list["BookstoreMisc"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["BookstoreMisc"].items, 2 * spawnRate)
    table.insert(ProceduralDistributions.list["BookstoreMisc"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["BookstoreMisc"].items, 1 * spawnRate)
    
    -- BookstoreBooks - Empty binders (rare - 1)
    table.insert(ProceduralDistributions.list["BookstoreBooks"].items, "mtgcards.complete_set_binder")
    table.insert(ProceduralDistributions.list["BookstoreBooks"].items, 1 * spawnRate)
    table.insert(ProceduralDistributions.list["BookstoreBooks"].items, "mtgcards.power_nine_binder")
    table.insert(ProceduralDistributions.list["BookstoreBooks"].items, 1 * spawnRate)
    table.insert(ProceduralDistributions.list["BookstoreBooks"].items, "mtgcards.land_binder")
    table.insert(ProceduralDistributions.list["BookstoreBooks"].items, 1 * spawnRate)
    
    -- TOY STORES
    -- CrateToys - Booster packs (15, 10, 5), Starter decks (5, 1)
    table.insert(ProceduralDistributions.list["CrateToys"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["CrateToys"].items, 15 * spawnRate)
    table.insert(ProceduralDistributions.list["CrateToys"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["CrateToys"].items, 10 * spawnRate)
    table.insert(ProceduralDistributions.list["CrateToys"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["CrateToys"].items, 5 * spawnRate)
    
    table.insert(ProceduralDistributions.list["CrateToys"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["CrateToys"].items, 5 * spawnRate)
    table.insert(ProceduralDistributions.list["CrateToys"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["CrateToys"].items, 1 * spawnRate)
    
    -- GigamartToys - Booster packs (15, 10, 5), Starter decks (5, 1)
    table.insert(ProceduralDistributions.list["GigamartToys"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["GigamartToys"].items, 15 * spawnRate)
    table.insert(ProceduralDistributions.list["GigamartToys"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["GigamartToys"].items, 10 * spawnRate)
    table.insert(ProceduralDistributions.list["GigamartToys"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["GigamartToys"].items, 5 * spawnRate)
    
    table.insert(ProceduralDistributions.list["GigamartToys"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["GigamartToys"].items, 5 * spawnRate)
    table.insert(ProceduralDistributions.list["GigamartToys"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["GigamartToys"].items, 1 * spawnRate)
    
    -- GiftStoreToys - Booster packs (15, 10, 5), Starter decks (5, 1)
    table.insert(ProceduralDistributions.list["GiftStoreToys"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["GiftStoreToys"].items, 15 * spawnRate)
    table.insert(ProceduralDistributions.list["GiftStoreToys"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["GiftStoreToys"].items, 10 * spawnRate)
    table.insert(ProceduralDistributions.list["GiftStoreToys"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["GiftStoreToys"].items, 5 * spawnRate)
    
    table.insert(ProceduralDistributions.list["GiftStoreToys"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["GiftStoreToys"].items, 5 * spawnRate)
    table.insert(ProceduralDistributions.list["GiftStoreToys"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["GiftStoreToys"].items, 1 * spawnRate)
    
    -- PAWN SHOPS
    -- PawnShopCases - Booster packs (medium=5), Starter decks (medium=5)
    table.insert(ProceduralDistributions.list["PawnShopCases"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["PawnShopCases"].items, 5 * spawnRate)
    table.insert(ProceduralDistributions.list["PawnShopCases"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["PawnShopCases"].items, 5 * spawnRate)
    
    -- SCHOOLS
    -- SchoolLockers - Booster packs (medium=5), Starter decks (small=1)
    table.insert(ProceduralDistributions.list["SchoolLockers"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["SchoolLockers"].items, 5 * spawnRate)
    table.insert(ProceduralDistributions.list["SchoolLockers"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["SchoolLockers"].items, 1 * spawnRate)
    
    -- ClassroomDesk - Booster packs (medium=5), Starter decks (small=1)
    table.insert(ProceduralDistributions.list["ClassroomDesk"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["ClassroomDesk"].items, 5 * spawnRate)
    table.insert(ProceduralDistributions.list["ClassroomDesk"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["ClassroomDesk"].items, 1 * spawnRate)
    
    -- UniversityWardrobe - Booster packs (medium=5), Starter decks (small=1)
    table.insert(ProceduralDistributions.list["UniversityWardrobe"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["UniversityWardrobe"].items, 5 * spawnRate)
    table.insert(ProceduralDistributions.list["UniversityWardrobe"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["UniversityWardrobe"].items, 1 * spawnRate)
    
    -- Bag_Schoolbag - Booster packs (12.0), Starter decks (5.0)
    table.insert(SuburbsDistributions.Bag_Schoolbag.items, "mtgcards.booster_pack_beta")
    table.insert(SuburbsDistributions.Bag_Schoolbag.items, 12.0 * spawnRate)
    table.insert(SuburbsDistributions.Bag_Schoolbag.items, "mtgcards.starter_deck_beta")
    table.insert(SuburbsDistributions.Bag_Schoolbag.items, 5.0 * spawnRate)
    
    -- ZOMBIE INVENTORIES - Only booster packs (increased rates to compensate)
    -- inventorymale/inventoryfemale - Booster packs (1)
    table.insert(SuburbsDistributions.all.inventoryfemale.items, "mtgcards.booster_pack_beta")
    table.insert(SuburbsDistributions.all.inventoryfemale.items, 1 * spawnRate)
    
    table.insert(SuburbsDistributions.all.inventorymale.items, "mtgcards.booster_pack_beta")
    table.insert(SuburbsDistributions.all.inventorymale.items, 1 * spawnRate)
    
    
    -- BEDROOMS
    -- WardrobeChild - Booster packs (high=10), Starter decks (medium=5)
    table.insert(ProceduralDistributions.list["WardrobeChild"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["WardrobeChild"].items, 10 * spawnRate)
    table.insert(ProceduralDistributions.list["WardrobeChild"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["WardrobeChild"].items, 5 * spawnRate)
    
    -- WardrobeGeneric - Booster packs (medium=5), Starter decks (small=1)
    table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 5 * spawnRate)
    table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["WardrobeGeneric"].items, 1 * spawnRate)
    
    -- BedroomDresser - Booster packs (small=1)
    table.insert(ProceduralDistributions.list["BedroomDresser"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["BedroomDresser"].items, 1 * spawnRate)
    
    -- BedroomDresserChild - Booster packs (high=10), Starter decks (medium=5)
    table.insert(ProceduralDistributions.list["BedroomDresserChild"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["BedroomDresserChild"].items, 10 * spawnRate)
    table.insert(ProceduralDistributions.list["BedroomDresserChild"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["BedroomDresserChild"].items, 5 * spawnRate)
    
    -- BedroomSidetable - Booster packs (medium=5), Starter decks (small=1)
    table.insert(ProceduralDistributions.list["BedroomSidetable"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["BedroomSidetable"].items, 5 * spawnRate)
    table.insert(ProceduralDistributions.list["BedroomSidetable"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["BedroomSidetable"].items, 1 * spawnRate)
    
    -- BedroomSidetableChild - Booster packs (high=10), Starter decks (medium=5)
    table.insert(ProceduralDistributions.list["BedroomSidetableChild"].items, "mtgcards.booster_pack_beta")
    table.insert(ProceduralDistributions.list["BedroomSidetableChild"].items, 10 * spawnRate)
    table.insert(ProceduralDistributions.list["BedroomSidetableChild"].items, "mtgcards.starter_deck_beta")
    table.insert(ProceduralDistributions.list["BedroomSidetableChild"].items, 5 * spawnRate)
    
    -- RESIDENTIAL BOOKSHELVES
    -- LivingRoomShelf - Empty binders (rare)
    table.insert(ProceduralDistributions.list["LivingRoomShelf"].items, "mtgcards.complete_set_binder")
    table.insert(ProceduralDistributions.list["LivingRoomShelf"].items, 0.5 * spawnRate)
    table.insert(ProceduralDistributions.list["LivingRoomShelf"].items, "mtgcards.power_nine_binder")
    table.insert(ProceduralDistributions.list["LivingRoomShelf"].items, 0.5 * spawnRate)
    table.insert(ProceduralDistributions.list["LivingRoomShelf"].items, "mtgcards.land_binder")
    table.insert(ProceduralDistributions.list["LivingRoomShelf"].items, 0.5 * spawnRate)
    
    -- LivingRoomShelfNoTapes - Empty binders (rare)  
    table.insert(ProceduralDistributions.list["LivingRoomShelfNoTapes"].items, "mtgcards.complete_set_binder")
    table.insert(ProceduralDistributions.list["LivingRoomShelfNoTapes"].items, 0.5 * spawnRate)
    table.insert(ProceduralDistributions.list["LivingRoomShelfNoTapes"].items, "mtgcards.power_nine_binder")
    table.insert(ProceduralDistributions.list["LivingRoomShelfNoTapes"].items, 0.5 * spawnRate)
    table.insert(ProceduralDistributions.list["LivingRoomShelfNoTapes"].items, "mtgcards.land_binder")
    table.insert(ProceduralDistributions.list["LivingRoomShelfNoTapes"].items, 0.5 * spawnRate)
end

-- Initialize spawning directly
addMTGSpawns()