# MTGBeta42 Testing Guide

## Setup
1. Ensure the mod is in your Project Zomboid mods folder
2. Enable "MTGBeta42" in the mods menu
3. Start a new game or load existing save

## Debug Mode Testing

### Spawning Items
Use debug mode to spawn test items:
- `mtgcards.booster_pack_beta` - Beta Booster Pack
- `mtgcards.starter_deck_beta` - Beta Starter Deck  
- `mtgcards.complete_set_binder` - Complete Set Binder
- `mtgcards.power_nine_binder` - Power Nine Binder

### Testing Pack Opening
1. Spawn a booster pack or starter deck
2. Right-click the pack in inventory
3. Select "Open Beta Booster Pack" or "Open Beta Starter Deck"
4. Cards should appear in your inventory:
   - Booster: 15 cards (11 commons, 3 uncommons, 1 rare)
   - Starter: 60 cards (45 commons, 13 uncommons, 2 rares)

### Testing Binders
1. Spawn a binder
2. Spawn or obtain cards from packs
3. Try placing cards in binders:
   - Complete Set Binder: Should accept any Beta card
   - Power Nine Binder: Should only accept the 9 power cards:
     - Black Lotus
     - Mox Pearl, Sapphire, Ruby, Jet, Emerald
     - Ancestral Recall
     - Time Walk
     - Timetwister

### Testing World Spawns
Check these locations for naturally spawning packs:
- Bookstores
- Gas stations
- Grocery stores
- School lockers
- Bedroom dressers
- Toy crates

## What's Working
✅ 292 Beta cards with pixelated images
✅ Pack opening mechanics with proper rarity distribution
✅ Two binder types with filtering
✅ World spawn distributions
✅ Sandbox options
✅ Recipe system for pack opening

## Known Limitations (Phase 1-4)
- UI still shows Pokemon theming (will be fixed in Phase 5)
- Card viewing uses Pokemon infrastructure temporarily
- No custom pack/binder icons yet (using Pokemon placeholders)
- No zombie drop system implemented yet

## Console Commands for Testing
```lua
-- Give yourself a booster pack
getPlayer():getInventory():AddItem("mtgcards.booster_pack_beta")

-- Give yourself a starter deck
getPlayer():getInventory():AddItem("mtgcards.starter_deck_beta")

-- Give yourself binders
getPlayer():getInventory():AddItem("mtgcards.complete_set_binder")
getPlayer():getInventory():AddItem("mtgcards.power_nine_binder")

-- Give yourself specific cards
getPlayer():getInventory():AddItem("mtgcards.black-lotus")
getPlayer():getInventory():AddItem("mtgcards.lightning-bolt")
```

## Verifying Card Data
- Commons: 95 cards
- Uncommons: 95 cards
- Rares: 117 cards (includes dual lands and Power Nine)
- Basic Lands: 5 cards
- Total: 292 unique Beta cards

## Special Mechanics
- Island has 1/121 chance to replace rare in boosters (authentic to Beta)
- Basic lands can replace commons/uncommons at realistic rates
- Starter decks have higher land replacement rate for playability