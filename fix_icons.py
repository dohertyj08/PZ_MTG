#!/usr/bin/env python3
"""
Fix icon references in MTG item definitions
"""

def fix_icons():
    items_file = "42/media/scripts/items/items_mtgcards_generated.txt"
    
    with open(items_file, 'r') as f:
        content = f.read()
    
    # Replace all Icon=Item_ with Icon=
    content = content.replace('Icon=Item_', 'Icon=')
    
    with open(items_file, 'w') as f:
        f.write(content)
    
    print("Fixed all icon references")

if __name__ == "__main__":
    fix_icons()