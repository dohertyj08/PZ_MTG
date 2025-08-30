#!/usr/bin/env python3
"""
Update MTG card models to use multi-line format like working packs
"""

def update_models_format():
    models_file = "42/media/scripts/mtgcards_models.txt"
    
    with open(models_file, 'r') as f:
        content = f.read()
    
    # Find the start of individual card models
    start_marker = "// Individual MTG Beta Cards\n"
    before_cards = content[:content.find(start_marker) + len(start_marker)]
    
    # Get the texture files to rebuild models
    import os
    texture_dir = "42/media/textures/WorldItems"
    texture_files = []
    
    for file in os.listdir(texture_dir):
        if file.startswith("Item_") and file.endswith(".png") and "-" in file:
            model_name = file[5:-4]  # Remove "Item_" and ".png"
            texture_files.append(model_name)
    
    texture_files.sort()
    
    # Generate new models in multi-line format
    new_models = ""
    for model_name in texture_files:
        new_models += f"""
model {model_name}
{{
    mesh = WorldItems/Notebook,
    texture = WorldItems/Item_{model_name},
    scale = 0.27,
}}
"""
    
    # Write updated file
    with open(models_file, 'w') as f:
        f.write(before_cards + new_models + "\n}")
    
    print(f"Updated {len(texture_files)} card models to multi-line format")

if __name__ == "__main__":
    update_models_format()