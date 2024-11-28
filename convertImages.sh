#!/bin/bash

# Function to convert and resize PNG to WebP
convert_image() {
    local image="$1"
    local width="$2"
    cwebp -q 80 -resize "$width" 0 "$image" -o "${image%.png}.webp"
}

# Check if a file path was provided as an argument
if [[ -n "$1" && -f "$1" && "${1: -4}" == ".png" ]]; then
    image="$1"
else
    # Use fzf to select the PNG file
    image=$(find . -type f -name '*.png' | fzf --height 40% --reverse --preview 'cat {}')
fi

# Specify the desired width (adjust as needed)
desired_width=1200

# Check if the file exists and has a .png extension
if [[ -f "$image" && "${image: -4}" == ".png" ]]; then
    convert_image "$image" "$desired_width"
    echo "Converted and resized $image to ${image%.png}.webp with width $desired_width pixels."
else
    echo "File not found or not a PNG file."
fi