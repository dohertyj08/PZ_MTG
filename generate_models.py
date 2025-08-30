#!/usr/bin/env python3
"""
Generate model definitions for all MTG cards
"""
import os

def generate_models():
    models_file_path = "42/media/scripts/mtgcards_models.txt"
    textures_dir = "42/media/textures/WorldItems"
    
    # Get all card texture files
    texture_files = []
    for file in os.listdir(textures_dir):
        if file.startswith("Item_") and file.endswith(".png") and "-" in file:
            # Extract model name (remove Item_ prefix and .png suffix)
            model_name = file[5:-4]  # Remove "Item_" and ".png"
            texture_files.append((model_name, file))
    
    # Sort for consistent output
    texture_files.sort()
    
    # Read existing models file
    with open(models_file_path, "r") as f:
        existing_content = f.read()
    
    # Generate new models for cards
    card_models = ""
    for model_name, texture_file in texture_files:
        card_models += f"model {model_name} {{mesh=WorldItems/Notebook,texture=WorldItems/{texture_file[:-4]},scale=0.27,}}\n"
    
    # Append card models to existing file
    with open(models_file_path, "w") as f:
        f.write(existing_content + "\n")
        f.write("// Individual MTG Beta Cards\n")
        f.write(card_models)
    
    print(f"Generated {len(texture_files)} card models")

if __name__ == "__main__":
    generate_models()