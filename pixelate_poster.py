#!/usr/bin/env python3
"""
Pixelate poster.png and replace Item_base_pack.png
"""
from PIL import Image
import os

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
    poster_path = "42/poster.png"
    output_path = "42/media/textures/Item_base_pack.png"
    target_size = (256, 357)  # Standard PZ item texture size
    
    # Check if poster.png exists
    if not os.path.exists(poster_path):
        print(f"Error: {poster_path} not found")
        return
    
    print(f"Loading {poster_path}...")
    
    # Load the poster image
    try:
        img = Image.open(poster_path)
        print(f"Original size: {img.size}")
        
        # Resize to target size first
        print(f"Resizing to {target_size}...")
        resized_img = img.resize(target_size, Image.Resampling.LANCZOS)
        
        # Apply pixelation
        print("Applying pixelation effect...")
        pixelated_img = apply_pixelation(resized_img)
        
        # Save as Item_base_pack.png
        pixelated_img.save(output_path, 'PNG')
        print(f"Successfully created resized and pixelated version: {output_path}")
        print(f"Final size: {target_size}")
        
    except Exception as e:
        print(f"Error processing image: {e}")

if __name__ == "__main__":
    main()