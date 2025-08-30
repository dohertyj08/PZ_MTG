#!/usr/bin/env python3
"""
Create Beta-style pack and deck textures for MTGBeta42 mod
"""
from PIL import Image, ImageDraw, ImageFont
import os

def create_beta_pack_texture():
    """Create a Beta booster pack texture"""
    # Standard PZ item texture size
    size = (256, 357)
    
    # Create base image with dark blue/black background (classic MTG)
    img = Image.new('RGB', size, (15, 15, 30))
    draw = ImageDraw.Draw(img)
    
    # Create border frame
    border_color = (200, 180, 120)  # Gold/tan border like original Beta
    draw.rectangle([10, 10, size[0]-10, size[1]-10], outline=border_color, width=3)
    draw.rectangle([15, 15, size[0]-15, size[1]-15], outline=border_color, width=2)
    
    # Central orb/mana symbol area
    center_x, center_y = size[0] // 2, size[1] // 2 - 20
    orb_radius = 60
    
    # Create mana symbol orb (simplified)
    draw.ellipse([center_x - orb_radius, center_y - orb_radius, 
                  center_x + orb_radius, center_y + orb_radius], 
                  fill=(40, 40, 80), outline=border_color, width=3)
    
    # Inner orb details
    draw.ellipse([center_x - orb_radius//2, center_y - orb_radius//2,
                  center_x + orb_radius//2, center_y + orb_radius//2],
                  fill=(60, 60, 120), outline=(150, 150, 200), width=2)
    
    # Top banner area
    banner_y = 40
    draw.rectangle([25, banner_y, size[0]-25, banner_y + 40], 
                   fill=(30, 30, 60), outline=border_color, width=2)
    
    # Bottom banner area  
    bottom_banner_y = size[1] - 80
    draw.rectangle([25, bottom_banner_y, size[0]-25, bottom_banner_y + 40],
                   fill=(30, 30, 60), outline=border_color, width=2)
    
    # Add some mystical details
    for i in range(5):
        x = 30 + i * 40
        y = center_y + 80
        draw.polygon([(x, y), (x+10, y+15), (x-10, y+15)], fill=border_color)
    
    # Side decorative elements
    for y in range(100, size[1]-100, 50):
        draw.ellipse([20, y, 30, y+10], fill=border_color)
        draw.ellipse([size[0]-30, y, size[0]-20, y+10], fill=border_color)
    
    return img

def create_beta_deck_texture():
    """Create a Beta starter deck texture (wider/flatter than booster)"""
    size = (256, 357)
    
    # Create base with darker background for deck
    img = Image.new('RGB', size, (20, 10, 10))
    draw = ImageDraw.Draw(img)
    
    # More rectangular design for deck box
    border_color = (200, 180, 120)
    draw.rectangle([8, 50, size[0]-8, size[1]-50], outline=border_color, width=4)
    draw.rectangle([12, 54, size[0]-12, size[1]-54], outline=border_color, width=2)
    
    # Lid indication (top section)
    lid_height = 80
    draw.rectangle([12, 54, size[0]-12, 54 + lid_height], 
                   fill=(35, 20, 20), outline=border_color, width=2)
    
    # Main box body
    draw.rectangle([12, 54 + lid_height, size[0]-12, size[1]-54],
                   fill=(25, 15, 15))
    
    # Central emblem area (larger than booster)
    center_x = size[0] // 2
    center_y = 54 + lid_height + 60
    emblem_width, emblem_height = 120, 80
    
    draw.rectangle([center_x - emblem_width//2, center_y - emblem_height//2,
                    center_x + emblem_width//2, center_y + emblem_height//2],
                   fill=(40, 40, 80), outline=border_color, width=3)
    
    # Inner emblem design
    draw.rectangle([center_x - emblem_width//3, center_y - emblem_height//3,
                    center_x + emblem_width//3, center_y + emblem_height//3],
                   fill=(60, 60, 120), outline=(150, 150, 200), width=2)
    
    # Deck capacity indication (bottom area)
    bottom_y = size[1] - 100
    draw.rectangle([30, bottom_y, size[0]-30, bottom_y + 30],
                   fill=(30, 30, 60), outline=border_color, width=2)
    
    # Corner reinforcements (typical of card boxes)
    corner_size = 15
    corners = [(15, 60), (size[0]-30, 60), (15, size[1]-75), (size[0]-30, size[1]-75)]
    for x, y in corners:
        draw.rectangle([x, y, x+corner_size, y+corner_size], 
                      fill=border_color, outline=(150, 150, 150))
    
    # Side clasps/hinges
    for y in [80, size[1]-100]:
        draw.rectangle([5, y, 15, y+20], fill=border_color, outline=(100, 100, 100))
        draw.rectangle([size[0]-15, y, size[0]-5, y+20], fill=border_color, outline=(100, 100, 100))
    
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
    output_dir = "42/media/textures/Item"
    os.makedirs(output_dir, exist_ok=True)
    
    print("Creating Beta-style pack textures...")
    
    # Create booster pack texture
    booster_img = create_beta_pack_texture()
    booster_pixelated = apply_pixelation(booster_img)
    booster_path = os.path.join(output_dir, "Item_booster_pack_beta.png")
    booster_pixelated.save(booster_path, 'PNG')
    print(f"Created: {booster_path}")
    
    # Create starter deck texture  
    deck_img = create_beta_deck_texture()
    deck_pixelated = apply_pixelation(deck_img)
    deck_path = os.path.join(output_dir, "Item_starter_deck_beta.png")
    deck_pixelated.save(deck_path, 'PNG')
    print(f"Created: {deck_path}")
    
    print("Pack textures created successfully!")

if __name__ == "__main__":
    main()