# MTG Beta 42 Spawning Strategy - Final Implementation

## Phase 1: Core Distribution 

### Comic Stores
- `ComicStoreShelfComics` - Booster packs (25, 10, 10, 5, 5), Starter decks (6.25, 2.5, 2.5, 1.25)
- `ComicStoreCounter` - Individual cards (10)
- `ComicStoreShelfGames` - Starter decks (25, 10, 10, 5) - add alongside existing items
- `ComicStoreDisplayBooks` - Empty binders (5)

### Bookstores
- `BookStoreCounter` - Booster packs (5)

### Toy Stores
- `CrateToys` - Booster packs (10), Starter decks (1)
- `GigamartToys` - Booster packs (10)
- `GiftStoreToys` - Booster packs (3)

### Schools
- `SchoolLockers` - Individual cards (0.90), Booster packs (0.30)
- `ClassroomDesk` - Individual cards (1.20), Booster packs (0.40)
- `Bag_Schoolbag` - Individual cards (24.0), Booster packs (8.0)

### Zombie/Character Inventories
- `inventorymale/inventoryfemale` - Individual cards (0.1), Booster packs (0.05)
- `Outfit_Student` - Individual cards (4.0), Booster packs (0.1)

## Phase 2: Bedroom Collections
- `BedroomDresser` - Pre-filled binders ONLY (2.0)
- `WardrobeChild` - Individual cards (3), Booster packs (2), Pre-filled binders (1), Starter decks (0.25)

## Phase 3: Sandbox Controls
- Single spawn rate multiplier setting

## Items to Implement
- **Individual Cards**: Use normal rarity distribution (11 commons, 3 uncommons, 1 rare)
- **Booster Packs**: mtgcards.booster_pack_beta (drainable system)
- **Starter Decks**: mtgcards.starter_deck_beta
- **Empty Binders**: mtgcards.complete_set_binder, mtgcards.power_nine_binder, mtgcards.land_binder
- **Pre-filled Binders**: Special items that spawn with cards already inside

## Pre-filled Binder Types

**Spawn Weights:**
- Regular Collection: 70%
- Rare Collection: 20%
- Basic Lands Collection: 9.95%
- Ultra-rare Collections: 0.05% each (0.15% total)

**Collection Contents:**

### Regular Collection (Complete Set Binder)
- 30-50 random commons
- 10-16 random uncommons
- 6-10 random rares (higher rare density than normal packs)

### Rare Collection (Power Nine Binder)
- 16-30 random rares only

### Basic Lands Collection (Land Binder)
- Random assortment of basic lands only

### Ultra-rare Collections (0.05% each):
- **Complete Dual Lands** - Land Binder + all 10 dual lands
- **Complete Power Nine** - Power Nine Binder + all 9 Power Nine cards  
- **Lightning Cycle Collection** - Complete Set Binder + Lightning Bolt, Dark Ritual, Ancestral Recall, Healing Salve, Giant Growth