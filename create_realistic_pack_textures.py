#!/usr/bin/env python3
"""
Create realistic MTG Beta pack and binder textures to replace base textures
"""
from PIL import Image, ImageDraw, ImageFont
import os

def create_foil_booster_pack():
    """Create a realistic foil booster pack texture"""
    # Standard PZ item texture size
    size = (256, 357)
    
    # Create base with metallic/foil appearance
    img = Image.new('RGB', size, (180, 160, 140))  # Brownish base like Beta packs
    draw = ImageDraw.Draw(img)
    
    # Main pack body (rectangular foil wrapper)
    pack_margin = 20
    pack_top = 30
    pack_bottom = size[1] - 30
    
    # Main foil body with gradient effect
    for y in range(pack_top, pack_bottom):
        # Create subtle gradient from light to darker
        intensity = 180 + int(20 * (y - pack_top) / (pack_bottom - pack_top))
        color = (min(200, intensity), min(180, intensity-20), min(160, intensity-40))
        draw.line([(pack_margin, y), (size[0] - pack_margin, y)], fill=color)
    
    # Pack edges/seams
    edge_color = (120, 100, 80)
    draw.rectangle([pack_margin, pack_top, size[0] - pack_margin, pack_bottom], 
                   outline=edge_color, width=3)
    
    # Top and bottom sealed edges (characteristic of foil packs)
    seal_height = 15
    seal_color = (140, 120, 100)
    
    # Top seal
    draw.rectangle([pack_margin - 5, pack_top - seal_height, size[0] - pack_margin + 5, pack_top],
                   fill=seal_color, outline=edge_color, width=2)
    
    # Bottom seal  
    draw.rectangle([pack_margin - 5, pack_bottom, size[0] - pack_margin + 5, pack_bottom + seal_height],
                   fill=seal_color, outline=edge_color, width=2)
    
    # Central logo area (simplified MTG style)
    center_x = size[0] // 2
    logo_y = 80
    logo_width = 120
    logo_height = 60
    
    # Logo background
    draw.rectangle([center_x - logo_width//2, logo_y, center_x + logo_width//2, logo_y + logo_height],
                   fill=(200, 180, 160), outline=edge_color, width=2)
    
    # "MAGIC" text area (simplified)
    text_y = logo_y + 20
    draw.rectangle([center_x - 50, text_y, center_x + 50, text_y + 20],
                   fill=(220, 200, 180), outline=(100, 80, 60), width=1)
    
    # Set name area
    set_y = 180
    draw.rectangle([pack_margin + 10, set_y, size[0] - pack_margin - 10, set_y + 40],
                   fill=(160, 140, 120), outline=edge_color, width=2)
    
    # "BETA" indicator area
    beta_y = set_y + 10
    draw.rectangle([center_x - 30, beta_y, center_x + 30, beta_y + 20],
                   fill=(200, 180, 160), outline=(80, 60, 40), width=1)
    
    # Booster pack info area at bottom
    info_y = 280
    draw.rectangle([pack_margin + 10, info_y, size[0] - pack_margin - 10, info_y + 30],
                   fill=(140, 120, 100), outline=edge_color, width=1)
    
    # Foil sheen effects (vertical highlights)
    for x in range(pack_margin + 20, size[0] - pack_margin - 20, 40):
        for y in range(pack_top + 10, pack_bottom - 10, 8):
            draw.point((x, y), fill=(220, 200, 180))
            draw.point((x + 1, y), fill=(200, 180, 160))
    
    return img

def create_card_binder():
    """Create a card binder texture"""
    size = (256, 357)
    
    # Create base binder color (classic dark blue/black)
    img = Image.new('RGB', size, (30, 30, 50))
    draw = ImageDraw.Draw(img)
    
    # Binder spine and edges
    spine_width = 20
    edge_color = (100, 100, 120)
    
    # Left spine
    draw.rectangle([0, 0, spine_width, size[1]], fill=(20, 20, 40), outline=edge_color, width=2)
    
    # Main binder body
    draw.rectangle([spine_width, 10, size[0] - 10, size[1] - 10],
                   fill=(40, 40, 70), outline=edge_color, width=3)
    
    # Binder rings (3-ring style)
    ring_x = spine_width // 2
    ring_positions = [size[1] // 4, size[1] // 2, 3 * size[1] // 4]
    
    for ring_y in ring_positions:
        draw.ellipse([ring_x - 6, ring_y - 8, ring_x + 6, ring_y + 8],
                     fill=(150, 150, 170), outline=(80, 80, 100), width=2)
        # Ring hole
        draw.ellipse([ring_x - 3, ring_y - 5, ring_x + 3, ring_y + 5],
                     fill=(0, 0, 0))
    
    # Front cover label area
    label_margin = 40
    label_y = 60
    label_height = 80
    
    draw.rectangle([label_margin, label_y, size[0] - 20, label_y + label_height],
                   fill=(60, 60, 100), outline=edge_color, width=2)
    
    # Inner label for title
    inner_margin = label_margin + 15
    inner_y = label_y + 15
    inner_height = label_height - 30
    
    draw.rectangle([inner_margin, inner_y, size[0] - 35, inner_y + inner_height],
                   fill=(80, 80, 120), outline=(120, 120, 140), width=1)
    
    # Bottom info section
    bottom_y = 250
    draw.rectangle([label_margin, bottom_y, size[0] - 20, bottom_y + 50],
                   fill=(50, 50, 80), outline=edge_color, width=2)
    
    # Corner reinforcements
    corner_size = 12
    corners = [
        (spine_width + 5, 15),
        (size[0] - 25, 15),
        (spine_width + 5, size[1] - 25),
        (size[0] - 25, size[1] - 25)
    ]
    
    for x, y in corners:
        draw.rectangle([x, y, x + corner_size, y + corner_size],
                       fill=edge_color, outline=(70, 70, 90))
    
    return img

def apply_pixelation(img, pixel_size=4):
    """Apply pixelation effect to match PZ style"""
    original_size = img.size
    
    # Shrink image
    small_size = (original_size[0] // pixel_size, original_size[1] // pixel_size)
    small = img.resize(small_size, Image.Resampling.BILINEAR)
    
    # Enlarge with nearest neighbor to create pixel effect
    pixelated = small.resize(original_size, Image.Resampling.NEAREST)
    
    return pixelated

def main():
    texture_dir = "42/media/textures"
    
    print("Creating realistic MTG textures...")
    
    # Create and replace booster pack texture
    print("Creating foil booster pack texture...")
    pack_img = create_foil_booster_pack()
    pack_pixelated = apply_pixelation(pack_img)
    pack_path = os.path.join(texture_dir, "Item_base_pack.png")
    pack_pixelated.save(pack_path, 'PNG')
    print(f"Replaced: {pack_path}")
    
    # Create and replace binder texture
    print("Creating card binder texture...")
    binder_img = create_card_binder()
    binder_pixelated = apply_pixelation(binder_img)
    binder_path = os.path.join(texture_dir, "Item_base_binder.png")
    binder_pixelated.save(binder_path, 'PNG')
    print(f"Replaced: {binder_path}")
    
    print("Realistic MTG textures created successfully!")

if __name__ == "__main__":
    main()