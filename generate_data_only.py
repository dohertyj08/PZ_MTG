#!/usr/bin/env python3
"""
Generate just the Lua and item files without re-downloading images
"""
import requests
import time
import json
import os
from collections import defaultdict

# Power Nine cards
POWER_NINE = [
    "Black Lotus",
    "Mox Pearl", 
    "Mox Sapphire",
    "Mox Ruby",
    "Mox Jet",
    "Mox Emerald",
    "Ancestral Recall",
    "Time Walk",
    "Timetwister"
]

def fetch_beta_cards():
    """Fetch all cards from Limited Edition Beta from Scryfall"""
    print("Fetching Beta cards from Scryfall...")
    
    # Scryfall API endpoint for Beta set
    url = "https://api.scryfall.com/cards/search"
    params = {
        "q": "set:leb",  # Limited Edition Beta
        "unique": "prints",  # Get all prints including different artworks
        "order": "name"
    }
    
    # Add polite headers
    headers = {
        "User-Agent": "MTGBeta42 PZ Mod/1.0 (Personal Project)"
    }
    
    all_cards = []
    has_more = True
    
    while has_more:
        response = requests.get(url, params=params, headers=headers)
        if response.status_code != 200:
            print(f"Error fetching cards: {response.status_code}")
            return []
        
        data = response.json()
        all_cards.extend(data['data'])
        
        if data.get('has_more'):
            url = data['next_page']
            params = {}  # Next page URL includes all params
            time.sleep(0.5)  # Respectful rate limiting for Scryfall
        else:
            has_more = False
    
    print(f"Fetched {len(all_cards)} cards from Beta")
    return all_cards

def sanitize_filename(name, collector_number=None):
    """Convert card name to valid filename"""
    # Remove special characters and replace spaces
    invalid_chars = ['/', '\\', ':', '*', '?', '"', '<', '>', '|', "'", ',']
    filename = name.lower()
    for char in invalid_chars:
        filename = filename.replace(char, '')
    filename = filename.replace(' ', '-')
    filename = filename.replace('--', '-')
    
    # Add collector number for differentiation (especially for basic lands)
    if collector_number:
        filename += f"-{collector_number}"
    
    return filename

def generate_lua_data(cards):
    """Generate Lua data structures for the mod"""
    
    # Categorize cards
    commons = []
    uncommons = []
    rares = []
    lands = []
    power_nine_list = []
    all_cards = []
    display_names = {}
    
    for card in cards:
        name = card['name']
        collector_number = card.get('collector_number')
        filename = sanitize_filename(name, collector_number)
        item_id = f"mtgcards.{filename}"
        
        all_cards.append(item_id)
        display_names[filename] = name
        
        # Check if it's a basic land
        if card.get('type_line', '').startswith('Basic Land'):
            lands.append(item_id)
        # Check if it's Power Nine
        elif name in POWER_NINE:
            power_nine_list.append(item_id)
            rares.append(item_id)  # Also include in rares
        # Sort by rarity
        elif card['rarity'] == 'common':
            commons.append(item_id)
        elif card['rarity'] == 'uncommon':
            uncommons.append(item_id)
        elif card['rarity'] in ['rare', 'mythic']:
            rares.append(item_id)
    
    # Generate Lua code
    lua_code = """-- MTG Beta Card Lists for Project Zomboid
-- Auto-generated from Scryfall API

beta_c = {
"""
    for card in commons:
        lua_code += f'    "{card}",\n'
    lua_code += "}\n\nbeta_u = {\n"
    
    for card in uncommons:
        lua_code += f'    "{card}",\n'
    lua_code += "}\n\nbeta_r = {\n"
    
    for card in rares:
        lua_code += f'    "{card}",\n'
    lua_code += "}\n\nbeta_lands = {\n"
    
    for card in lands:
        lua_code += f'    "{card}",\n'
    lua_code += "}\n\npower_nine = {\n"
    
    for card in power_nine_list:
        lua_code += f'    "{card}",\n'
    lua_code += "}\n\n"
    
    # Add display names
    lua_code += "-- Display names mapping\nmtgCardDisplayNames = {\n"
    for filename, display_name in sorted(display_names.items()):
        lua_code += f'    ["{filename}"] = "{display_name}",\n'
    lua_code += "}\n"
    
    # Add stats
    lua_code += f"\n-- Stats: {len(commons)} commons, {len(uncommons)} uncommons, "
    lua_code += f"{len(rares)} rares, {len(lands)} lands, {len(power_nine_list)} power nine\n"
    lua_code += f"-- Total: {len(all_cards)} cards\n"
    
    return lua_code, all_cards, display_names

def generate_item_definitions(all_cards, display_names):
    """Generate Project Zomboid item definitions"""
    
    items_code = """module mtgcards
{
imports
{
Base
}

/* Pack and Binder Items */

item booster_pack_beta
{
    DisplayCategory=MTG,
    DisplayName=Beta Booster Pack,
    Icon=Item_base_pack,
    Weight=0.1,
    Type=Normal,
    WorldStaticModel=base_pack,
}

item starter_deck_beta
{
    DisplayCategory=MTG,
    DisplayName=Beta Starter Deck,
    Icon=Item_base_pack,
    Weight=0.3,
    Type=Normal,
    WorldStaticModel=base_pack,
}

item complete_set_binder
{
    DisplayCategory=MTG,
    DisplayName=MTG Beta Complete Set Binder,
    Capacity=350,
    WeightReduction=80,
    Icon=Item_base_binder,
    Weight=0.2,
    Type=Container,
    WorldStaticModel=base_binder,
    OpenSound=OpenBag,
    CloseSound=CloseBag,
    PutInSound=PutItemInBag,
}

item power_nine_binder
{
    DisplayCategory=MTG,
    DisplayName=Power Nine Binder,
    Capacity=9,
    WeightReduction=90,
    Icon=Item_duplicates_binder,
    Weight=0.1,
    Type=Container,
    WorldStaticModel=duplicates_binder,
    OpenSound=OpenBag,
    CloseSound=CloseBag,
    PutInSound=PutItemInBag,
}

/* Individual Cards */

"""
    
    for filename in sorted(display_names.keys()):
        display_name = display_names[filename]
        items_code += f"""item {filename}
{{
    DisplayCategory=MTG,
    DisplayName={display_name},
    Icon=Item_{filename},
    Weight=0.001,
    Type=Normal,
    WorldStaticModel={filename},
}}

"""
    
    items_code += "}\n"
    return items_code

def main():
    # Create directories
    os.makedirs("42/media/lua/server", exist_ok=True)
    os.makedirs("42/media/scripts/items", exist_ok=True)
    
    # Fetch cards
    cards = fetch_beta_cards()
    if not cards:
        print("Failed to fetch cards")
        return
    
    # Generate Lua data
    print("\nGenerating Lua data files...")
    lua_code, all_cards, display_names = generate_lua_data(cards)
    
    with open("42/media/lua/server/MTGCardLists.lua", "w") as f:
        f.write(lua_code)
    
    # Generate item definitions
    print("Generating item definitions...")
    items_code = generate_item_definitions(all_cards, display_names)
    
    with open("42/media/scripts/items/items_mtgcards_generated.txt", "w") as f:
        f.write(items_code)
    
    print("\nComplete! Generated:")
    print(f"  - {len(cards)} card entries")
    print("  - MTGCardLists.lua")
    print("  - items_mtgcards_generated.txt")

if __name__ == "__main__":
    main()