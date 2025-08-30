# Project Zomboid Build 42 Modding Guide

This guide documents key insights learned while creating the MTGBeta42 mod, focusing on common pitfalls and solutions.

## Table of Contents
1. [Texture System](#texture-system)
2. [Model System](#model-system)
3. [Container Items](#container-items)
4. [AcceptItemFunction](#acceptitemfunction)
5. [Spawning and Distribution](#spawning-and-distribution)
6. [File Structure](#file-structure)
7. [Common Errors](#common-errors)

## Texture System

### Key Insight: Icons vs World Models
Project Zomboid separates inventory icons from world model textures:

- **Inventory Icons**: `/media/textures/Item_*.png` - flat 2D images for UI
- **World Model Textures**: `/media/textures/WorldItems/Item_*.png` - textures for 3D models

### Texture Loading Rules
1. **Both directories needed**: For items to work properly in inventory AND world placement, you often need textures in both locations
2. **Model references**: Model definitions use `texture = WorldItems/Item_name` format
3. **Icon references**: Item definitions use `Icon = name` (without Item_ prefix)

### Working Example
```
/media/textures/Item_base_pack.png          <- Inventory icon
/media/textures/WorldItems/Item_base_pack.png <- World model texture
```

Model definition:
```
model base_pack {
    texture = WorldItems/Item_base_pack,
    ...
}
```

Item definition:
```
item base_pack {
    Icon = base_pack,
    ...
}
```

## Model System

### Model File Structure
Models must be defined in `/media/scripts/*_models.txt` files:

```
module modulename {
    imports { Base }
    
    model modelname {
        mesh = WorldItems/MeshFile,
        texture = WorldItems/TexturePath,
        scale = 0.27,
    }
}
```

### Mesh Sources
- Use existing base game meshes: `/ProjectZomboid/media/models_X/WorldItems/*.FBX`
- Copy to your mod: `/yourmod/media/models_X/WorldItems/YourMesh.FBX`
- Reference in model: `mesh = WorldItems/YourMesh`

### Scale Guidelines
- **Cards**: 0.27 (small items)
- **Books/Notebooks**: 0.3-0.72 (medium items)
- **PhotoAlbum/Binders**: 0.08 (specific to filing cabinet mesh)
- **Packs**: 0.4-1.0 (depending on desired size)

### Mesh Recommendations by Item Type
- **Cards**: `WorldItems/Notebook` (flat rectangular items)
- **Thin packs**: `WorldItems/SheetOfPaper` (booster packs)
- **Thick decks**: `WorldItems/Notebook` (starter decks)
- **Binders**: `WorldItems/PhotoAlbum` (filing cabinet appearance)

## Container Items

### Container Configuration
```
item container_name {
    Type = Container,
    Capacity = 350,
    WeightReduction = 80,
    AcceptItemFunction = ModuleName.function_name,
    OpenSound = OpenBag,
    CloseSound = CloseBag,
    PutInSound = PutItemInBag,
}
```

### Key Properties
- **Capacity**: Maximum number of items
- **WeightReduction**: Percentage weight reduction (80 = 80% reduction)
- **AcceptItemFunction**: Controls what items can be placed inside

## AcceptItemFunction

### Critical Rules
1. **Location**: MUST be in `/media/lua/server/Items/` (NOT client!)
2. **Simple methods**: Use reliable item methods, avoid complex module inspection
3. **Error handling**: Always check for nil items

### Proper Implementation Pattern
```lua
-- File: /media/lua/server/Items/YourAcceptFunctions.lua

YourModule_AcceptItemFunction = YourModule_AcceptItemFunction or {}

function YourModule_AcceptItemFunction.function_name(container, item)
    if not item then
        return false
    end
    
    -- Use simple, reliable methods:
    local category = item:getDisplayCategory()
    if category == "YourCategory" then
        return true
    end
    
    local fullType = item:getFullType()
    if fullType and string.find(fullType, "^yourmodule%.") then
        return true
    end
    
    return false
end
```

### Reliable Item Methods
- `item:getDisplayCategory()` - Most reliable for custom categories
- `item:getFullType()` - Returns "module.itemname" format
- `item:hasTag("TagName")` - Check for specific tags
- `item:getStringItemType()` - Get item type category

### Methods to Avoid
- Complex module inspection with `getModule():getName()`
- Overly complex string parsing
- Methods that can return nil unexpectedly

## Spawning and Distribution

### Overview
Project Zomboid offers multiple systems for spawning items in the world. Each system has different use cases and advantages.

### 1. ProceduralDistributions (Container-Based Spawning)
Most flexible and commonly used system for adding items to containers.

#### Implementation
```lua
-- File: /media/lua/server/items/YourMod_distributions.lua
require 'Items/ProceduralDistributions'

-- Add to existing container types
table.insert(ProceduralDistributions.list["BookstoreMisc"].items, "yourmod.item_name")
table.insert(ProceduralDistributions.list["BookstoreMisc"].items, 0.5)  -- Spawn rate

-- Common container types:
-- BookstoreMisc, GasStorageCombo, StoreShelfCombo, SchoolLockers
-- BedroomDresser, WardrobeChild, CrateToys, OfficeDesk
-- GloveBox, TruckBed, MagazineRackMixed
```

#### Spawn Rate Guidelines
- 0.1-0.5: Very rare
- 0.5-2.0: Uncommon
- 2.0-5.0: Common
- 5.0-10.0: Very common
- 10.0+: Abundant

### 2. Zombie Loot Drops
Items that spawn when zombies are killed.

#### Implementation
```lua
-- File: /media/lua/client/YourMod_ZombieDrops.lua
local function OnZombieDead(zombie)
    -- Check sandbox variable if you have one
    if SandboxVars.YourMod and SandboxVars.YourMod.ZombieDrops then
        -- Random chance (1 in 1000)
        if ZombRand(1000) >= SandboxVars.YourMod.ZombieDropRate * 10 then 
            return 
        end
        
        -- Add item to zombie inventory
        zombie:getInventory():AddItem("yourmod.item_name")
    end
end
Events.OnZombieDead.Add(OnZombieDead)
```

### 3. Vehicle Distributions
Spawn items in vehicle compartments.

#### Implementation
```lua
-- File: /media/lua/server/Vehicles/YourMod_VehicleDistributions.lua
require 'Vehicles/VehicleDistributions'

-- Add to glove boxes
table.insert(VehicleDistributions.GloveBox.items, "yourmod.item_name")
table.insert(VehicleDistributions.GloveBox.items, 1.0)

-- Add to trunks
table.insert(VehicleDistributions.TrunkStandard.items, "yourmod.item_name")
table.insert(VehicleDistributions.TrunkStandard.items, 0.5)

-- Vehicle container types:
-- GloveBox, TrunkStandard, TrunkHeavy, TrunkSports
-- Seat, SeatRear, DriverSeat
```

### 4. Dynamic Container Spawning (OnFillContainer)
Spawn items when containers are first opened.

#### Implementation
```lua
-- File: /media/lua/client/YourMod_DynamicSpawns.lua
local function OnFillContainer(roomType, containerType, container)
    -- Check container type
    if container:getType() == "desk" or container:getType() == "drawer" then
        -- Random chance
        if ZombRand(100) < 5 then  -- 5% chance
            container:AddItem("yourmod.item_name")
        end
    end
end
Events.OnFillContainer.Add(OnFillContainer)
```

#### Common Container Types
```lua
-- Furniture
"desk", "drawer", "wardrobe", "dresser", "shelves", "sidetable"
"locker", "filingcabinet", "counter", "overhead", "metal_shelves"

-- Storage
"crate", "cardboardbox", "bin", "dumpster"

-- Vehicles
"GloveBox", "TruckBed", "TruckBedOpen"

-- Small containers
"postbox", "smallbox"

-- Special
"vendingpop", "vendingsnack"
```

### 5. SuburbsDistributions (Location-Based)
Target specific building types or pre-placed containers.

#### Implementation
```lua
-- File: /media/lua/server/items/YourMod_distributions.lua
require 'Items/SuburbsDistributions'

-- Add to zombie inventories
table.insert(SuburbsDistributions.all.inventorymale.items, "yourmod.item_name")
table.insert(SuburbsDistributions.all.inventorymale.items, 0.1)

table.insert(SuburbsDistributions.all.inventoryfemale.items, "yourmod.item_name")
table.insert(SuburbsDistributions.all.inventoryfemale.items, 0.1)

-- Add to specific bags/containers
table.insert(SuburbsDistributions.Bag_Schoolbag.items, "yourmod.item_name")
table.insert(SuburbsDistributions.Bag_Schoolbag.items, 5.0)
```

### 6. Sandbox Variables (Player Configuration)
Allow players to customize spawn rates in game settings.

#### Create Sandbox Options
```
-- File: /media/sandbox-options.txt
VERSION = 1,

option YourMod.EnableMod
{
    type = boolean, default = true,
    page = YourMod, translation = YourMod_EnableMod,
}

option YourMod.SpawnRate
{
    type = double, default = 1.0, min = 0.1, max = 10.0,
    page = YourMod, translation = YourMod_SpawnRate,
}

option YourMod.ZombieDrops
{
    type = boolean, default = false,
    page = YourMod, translation = YourMod_ZombieDrops,
}

option YourMod.ZombieDropRate
{
    type = double, default = 1.0, min = 0.1, max = 100.0,
    page = YourMod, translation = YourMod_ZombieDropRate,
}
```

#### Translation File
```
-- File: /media/lua/shared/Translate/EN/Sandbox_EN.txt
Sandbox_EN = {
    Sandbox_YourMod = "Your Mod Name",
    Sandbox_YourMod_EnableMod = "Enable Mod",
    Sandbox_YourMod_SpawnRate = "Item Spawn Rate",
    Sandbox_YourMod_SpawnRate_tooltip = "Multiplier for item spawn rates",
    Sandbox_YourMod_ZombieDrops = "Enable Zombie Drops",
    Sandbox_YourMod_ZombieDrops_tooltip = "Allow items to drop from zombies",
    Sandbox_YourMod_ZombieDropRate = "Zombie Drop Chance",
    Sandbox_YourMod_ZombieDropRate_tooltip = "0.1 = 0.1%, 50 = 50%, 100 = 100%",
}
```

#### Using Sandbox Variables
```lua
-- In your distribution code
local spawnRate = SandboxVars.YourMod and SandboxVars.YourMod.SpawnRate or 1.0

table.insert(ProceduralDistributions.list["BookstoreMisc"].items, "yourmod.item")
table.insert(ProceduralDistributions.list["BookstoreMisc"].items, 0.5 * spawnRate)
```

### Spawning Strategy Recommendations

#### For Trading Card Games (Like MTG):
1. **Primary Distribution**: ProceduralDistributions
   - Bookstores (high rate)
   - Toy stores (high rate)
   - School lockers (medium rate)
   - Gas stations (low rate)
   - Bedroom dressers (low rate)

2. **Zombie Drops**: Very low chance (0.1-1%)
   - Creates excitement for rare finds
   - Simulates people carrying cards

3. **Vehicle Spawns**: Glove boxes and trunks
   - Moderate chance in luxury vehicles
   - Low chance in standard vehicles

4. **Thematic Locations**:
   - High spawn in: toy stores, bookstores, comic shops
   - Medium spawn in: schools, bedrooms, offices
   - Low spawn in: gas stations, grocery stores

### Complete Distribution Example
```lua
-- File: /media/lua/server/items/YourMod_distributions.lua
require 'Items/ProceduralDistributions'
require 'Items/SuburbsDistributions'
require 'Vehicles/VehicleDistributions'

local spawnRate = SandboxVars.YourMod and SandboxVars.YourMod.SpawnRate or 1.0

-- High spawn locations (toy/hobby related)
local highSpawnLocations = {
    "CrateToys", "GigamartToys", "Gifts", "Hobbies", 
    "ComicStoreShelfGames", "WardrobeChild"
}

-- Medium spawn locations (general retail)
local mediumSpawnLocations = {
    "BookstoreMisc", "SchoolLockers", "ClassroomDesk",
    "BedroomDresser", "OfficeDesk"
}

-- Low spawn locations (random finds)
local lowSpawnLocations = {
    "GasStorageCombo", "StoreShelfSnacks", "BarCounterMisc",
    "RandomFiller", "BinGeneric"
}

-- Add to high spawn locations
for _, location in ipairs(highSpawnLocations) do
    if ProceduralDistributions.list[location] then
        table.insert(ProceduralDistributions.list[location].items, "yourmod.booster_pack")
        table.insert(ProceduralDistributions.list[location].items, 3.0 * spawnRate)
    end
end

-- Add to medium spawn locations
for _, location in ipairs(mediumSpawnLocations) do
    if ProceduralDistributions.list[location] then
        table.insert(ProceduralDistributions.list[location].items, "yourmod.booster_pack")
        table.insert(ProceduralDistributions.list[location].items, 1.0 * spawnRate)
    end
end

-- Add to low spawn locations
for _, location in ipairs(lowSpawnLocations) do
    if ProceduralDistributions.list[location] then
        table.insert(ProceduralDistributions.list[location].items, "yourmod.booster_pack")
        table.insert(ProceduralDistributions.list[location].items, 0.3 * spawnRate)
    end
end

-- Vehicle distributions
table.insert(VehicleDistributions.GloveBox.items, "yourmod.booster_pack")
table.insert(VehicleDistributions.GloveBox.items, 0.5 * spawnRate)

-- Zombie inventories (very rare)
table.insert(SuburbsDistributions.all.inventorymale.items, "yourmod.booster_pack")
table.insert(SuburbsDistributions.all.inventorymale.items, 0.01 * spawnRate)
```

### Testing Spawn Rates
1. Use Debug Mode to spawn containers
2. Check multiple containers of each type
3. Adjust rates based on testing
4. Consider player feedback on rarity

### Performance Considerations
- ProceduralDistributions: Processed once when container generates
- OnFillContainer: Called every time container opens (use sparingly)
- OnZombieDead: Called for every zombie death (keep lightweight)
- Large item lists can impact load times

## File Structure

### Required Directories
```
YourMod/
├── 42/
│   ├── mod.info
│   └── media/
│       ├── scripts/
│       │   ├── items/
│       │   │   └── items_yourmod.txt
│       │   └── your_models.txt
│       ├── textures/
│       │   ├── Item_*.png           <- Inventory icons
│       │   └── WorldItems/
│       │       └── Item_*.png       <- World model textures
│       ├── models_X/
│       │   └── WorldItems/
│       │       └── YourMesh.FBX     <- Custom meshes
│       └── lua/
│           └── server/
│               └── Items/
│                   └── YourAcceptFunctions.lua
```

### mod.info Requirements
```
name=Your Mod Name
id=YourModID
author=Your Name
versionMin=42.0.0
```

**Critical**: Do NOT include `pack=` references unless you have actual texture packs.

## Common Errors

### Game Crashes on Startup
**Cause**: Syntax errors in script files, missing closing braces, invalid pack references

**Solutions**:
- Check all `.txt` files for missing `}` braces
- Remove `pack=` lines from mod.info unless you have texture packs
- Validate script syntax

### Textures Not Loading
**Cause**: Wrong texture locations or incorrect model references

**Solutions**:
- Ensure textures exist in both `/textures/` and `/textures/WorldItems/`
- Check model texture references use `WorldItems/` prefix
- Verify file naming matches exactly (case-sensitive)

### AcceptItemFunction Crashes
**Cause**: Client-side implementation or unreliable item methods

**Solutions**:
- Move AcceptItemFunction to `/server/Items/`
- Add nil checks for all parameters
- Use simple, reliable item methods only
- Test with drag-and-drop operations

### Placeholder "Not Found" Textures
**Cause**: Missing world model textures in WorldItems directory

**Solutions**:
- Copy textures to `/textures/WorldItems/` directory
- Ensure model texture references are correct
- Check file naming conventions

### Wrong 3D Models
**Cause**: Using inappropriate base game meshes

**Solutions**:
- Research appropriate base game meshes in `/models_X/WorldItems/`
- Copy and rename meshes to your mod
- Update model definitions with correct mesh references
- Adjust scale values appropriately

## Best Practices

1. **Start Simple**: Begin with working base game examples
2. **Test Incrementally**: Test each component (textures, models, items) separately
3. **Use Base Game Assets**: Copy and modify existing meshes/textures rather than creating from scratch
4. **Follow Conventions**: Match base game file naming and structure patterns
5. **Error Handling**: Always include nil checks in Lua functions
6. **Server-Side Logic**: Keep game logic (AcceptItemFunction) server-side
7. **Documentation**: Comment your code and document custom implementations

## Debugging Tips

1. **Console Logs**: Use `print()` statements in Lua for debugging
2. **Incremental Testing**: Add one feature at a time
3. **Base Game Reference**: Study working base game implementations
4. **File Verification**: Ensure all referenced files actually exist
5. **Case Sensitivity**: Linux systems are case-sensitive for file names

## Resources

- Base Game Scripts: `/ProjectZomboid/media/scripts/`
- Base Game Models: `/ProjectZomboid/media/models_X/WorldItems/`
- Base Game Textures: `/ProjectZomboid/media/textures/`
- AcceptItemFunction Examples: `/media/lua/server/Items/AcceptItemFunction.lua`

This guide represents lessons learned from practical mod development and should help avoid common pitfalls in Project Zomboid Build 42 modding.