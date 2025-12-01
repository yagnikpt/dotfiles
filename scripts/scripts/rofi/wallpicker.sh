#!/usr/bin/env bash

wall_dirs="$HOME/Pictures/wallpapers/alt:$HOME/Pictures/wallpapers/arc_raiders"
cache_dir="$HOME/.cache/wallpaper_thumbnails/"

# Convert colon-separated string to array
IFS=':' read -ra WALL_DIRS <<< "$wall_dirs"

# Check if at least one wallpaper directory exists and has images
found_images=false
for dir in "${WALL_DIRS[@]}"; do
    if [ -d "$dir" ] && [ -n "$(find "$dir" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \))" ]; then
        found_images=true
        break
    fi
done

if [ "$found_images" = false ]; then
    exit 1
fi

# Create cache directory if it doesn't exist
mkdir -p "${cache_dir}"

# Generate thumbnails for images
shopt -s nullglob # Prevent glob from returning pattern if no files match
for wall_dir in "${WALL_DIRS[@]}"; do
    for image in "$wall_dir"/*.{jpg,jpeg,png,webp}; do
        if [ -f "$image" ]; then
            filename=$(basename "$image")
            if [ ! -f "${cache_dir}/${filename}" ]; then
                echo "Generating thumbnail for $filename..."
                if ! magick "$image" -strip -thumbnail 500x500^ -gravity center -extent 500x500 "${cache_dir}/${filename}"; then
                    echo "Error: Failed to generate thumbnail for $image"
                fi
            else
                echo "Thumbnail for $filename already exists."
            fi
        fi
    done
done

# Check if thumbnails were created
if [ -z "$(find "$cache_dir" -maxdepth 1 -type f)" ]; then
    echo "Error: No thumbnails generated in $cache_dir."
    exit 1
fi

# Use rofi to select an image with previews
wall_selection=$(for wall_dir in "${WALL_DIRS[@]}"; do
    find "${wall_dir}" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -exec basename {} \;
done | sort -u | while read -r filename; do
    if [ -f "${cache_dir}/${filename}" ]; then
        echo -en "$filename\x00icon\x1f${cache_dir}/${filename}\n"
    else
        echo "Warning: Thumbnail for $filename not found, skipping icon."
        echo -en "$filename\x00icon\x1f\n"
    fi
done | rofi -dmenu -theme "${HOME}/.config/rofi/wallpicker.rasi")

if [[ -n "$wall_selection" ]]; then
    current_theme=$(gsettings get org.gnome.desktop.interface color-scheme)
    mode=$([[ "$current_theme" = "'prefer-dark'" ]] && echo "dark" || echo "light")

    selected_path=""
    for wall_dir in "${WALL_DIRS[@]}"; do
        if [ -f "${wall_dir}/${wall_selection}" ]; then
            selected_path="${wall_dir}/${wall_selection}"
            break
        fi
    done

    if [ -n "$selected_path" ]; then
        if [[ -n "$(pgrep ignis)" ]]; then
            bash -lc "ignis run-command set-wallpaper $selected_path"
        elif [[ -n "$(pgrep dms)" ]]; then
            dms ipc call wallpaper set "$selected_path"
        else
            matugen image "$selected_path" -m "$mode"
        fi
    else
        echo "Error: Selected file $wall_selection does not exist in any wallpaper directory."
        exit 1
    fi
else
    echo "No wallpaper selected."
    exit 1
fi

exit 0
