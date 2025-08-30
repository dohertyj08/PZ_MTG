# Project Zomboid Build 42 Modding Guide

This guide documents key insights learned while creating the MTGBeta42 mod, focusing on common pitfalls and solutions.

## Table of Contents
1. [Texture System](#texture-system)
2. [Model System](#model-system)
3. [Container Items](#container-items)
4. [AcceptItemFunction](#acceptitemfunction)
5. [File Structure](#file-structure)
6. [Common Errors](#common-errors)

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