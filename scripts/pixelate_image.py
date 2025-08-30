#!/usr/bin/env python3
"""
Pixelate Image Script
Usage: python3 pixelate_image.py <input_image> [output_image] [pixel_size]

Pixelates an image using the same method as the MTG cards.
If output_image is not specified, it will save as <input_name>_pixelated.<extension>
If pixel_size is not specified, it defaults to 4 (same as MTG cards)
"""

import sys
import os
from PIL import Image
from pathlib import Path


def pixelate_image(input_path, output_path=None, pixel_size=4):
    """
    Pixelate an image using downsampling and nearest neighbor upsampling.
    
    Args:
        input_path: Path to input image
        output_path: Path to output image (optional)
        pixel_size: Size of pixels (default 4, same as MTG cards)
    """
    try:
        # Open the image
        img = Image.open(input_path)
        
        # Convert RGBA to RGB if needed (handling transparency)
        if img.mode == 'RGBA':
            # Create a white background
            background = Image.new('RGB', img.size, (255, 255, 255))
            background.paste(img, mask=img.split()[3])  # 3 is the alpha channel
            img = background
        elif img.mode != 'RGB':
            img = img.convert('RGB')
        
        # Get original size
        original_size = img.size
        
        # Downscale the image (this creates the pixelation effect)
        small = img.resize(
            (original_size[0] // pixel_size, original_size[1] // pixel_size),
            Image.Resampling.BILINEAR
        )
        
        # Scale back up using nearest neighbor (keeps the pixels sharp)
        pixelated = small.resize(original_size, Image.Resampling.NEAREST)
        
        # Determine output path if not specified
        if output_path is None:
            input_path_obj = Path(input_path)
            output_path = input_path_obj.parent / f"{input_path_obj.stem}_pixelated{input_path_obj.suffix}"
        
        # Save the pixelated image
        pixelated.save(output_path, quality=95, optimize=True)
        
        print(f"✅ Successfully pixelated: {input_path}")
        print(f"   Saved to: {output_path}")
        print(f"   Pixel size: {pixel_size}x{pixel_size}")
        print(f"   Original dimensions: {original_size[0]}x{original_size[1]}")
        
        return True
        
    except Exception as e:
        print(f"❌ Error processing {input_path}: {e}")
        return False


def main():
    # Check arguments
    if len(sys.argv) < 2:
        print("Usage: python3 pixelate_image.py <input_image> [output_image] [pixel_size]")
        print("\nExamples:")
        print("  python3 pixelate_image.py my_image.png")
        print("  python3 pixelate_image.py my_image.png output.png")
        print("  python3 pixelate_image.py my_image.png output.png 8")
        print("\nDefault pixel_size is 4 (same as MTG cards)")
        print("Larger pixel_size = more pixelated")
        sys.exit(1)
    
    # Parse arguments
    input_image = sys.argv[1]
    output_image = sys.argv[2] if len(sys.argv) > 2 else None
    
    # Parse pixel size if provided
    pixel_size = 4  # Default, same as MTG cards
    if len(sys.argv) > 3:
        try:
            pixel_size = int(sys.argv[3])
            if pixel_size < 1:
                print("Error: pixel_size must be at least 1")
                sys.exit(1)
        except ValueError:
            print(f"Error: Invalid pixel_size '{sys.argv[3]}', must be an integer")
            sys.exit(1)
    
    # Check if input file exists
    if not os.path.exists(input_image):
        print(f"Error: Input file '{input_image}' not found")
        sys.exit(1)
    
    # Process the image
    success = pixelate_image(input_image, output_image, pixel_size)
    
    if not success:
        sys.exit(1)


if __name__ == "__main__":
    main()