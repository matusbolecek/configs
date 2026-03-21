#!/bin/bash

# If this changes in the configs, it will not be replaced
DEFAULT_ACCENT="#74c7ec"

# mocha @ catppuccin.com/palette
accent_names=("Rosewater" "Flamingo" "Pink" "Mauve" "Red" "Maroon"
              "Peach" "Yellow" "Green" "Teal" "Sky" "Sapphire" "Blue" "Lavender")

accent_colors=("#f5e0dc" "#f2cdcd" "#f5c2e7" "#cba6f7" "#f38ba8" "#eba0ac"
               "#fab387" "#f9e2af" "#a6e3a1" "#94e2d5" "#89dceb" "#74c7ec"
               "#89b4fa" "#b4befe")

# Get the package list
dirs=()
for dir in */; do
    [ -d "$dir" ] && dirs+=("${dir%/}")
done

if [ "${#dirs[@]}" -eq 0 ]; then
    echo "No subdirectories found. Exiting."
    exit 1
fi

# Select what to install
echo ""
echo "┌─ Components ───────────────────────────────────────────┐"
for i in "${!dirs[@]}"; do
    printf "│ %2d) %-51s│\n" "$((i+1))" "${dirs[$i]}"
done
echo "│                                                        │"
echo "│   0) All                                               │"
echo "└────────────────────────────────────────────────────────┘"
echo ""
read -rp "Select components (space-separated, 0 = all): " comp_sel
echo ""

selected_dirs=()
if echo "$comp_sel" | grep -qw "0"; then
    selected_dirs=("${dirs[@]}")
else
    for num in $comp_sel; do
        if [[ "$num" =~ ^[0-9]+$ ]]; then
            idx=$((num - 1))
            if [ "$idx" -ge 0 ] && [ "$idx" -lt "${#dirs[@]}" ]; then
                selected_dirs+=("${dirs[$idx]}")
            else
                echo "Warning: $num is out of range, skipping."
            fi
        fi
    done
fi

if [ "${#selected_dirs[@]}" -eq 0 ]; then
    echo "No valid components selected. Exiting."
    exit 1
fi

# Pick accent
echo ""
echo "┌─ Catppuccin Mocha — Accent Color ──────────────────────┐"
for i in "${!accent_names[@]}"; do
    printf "│ %2d) %-15s  %-29s│\n" \
        "$((i+1))" "${accent_names[$i]}" "${accent_colors[$i]}"
done
echo "└────────────────────────────────────────────────────────┘"
echo ""
read -rp "Select accent color: " color_sel
echo ""

if ! [[ "$color_sel" =~ ^[0-9]+$ ]] || \
   [ "$color_sel" -lt 1 ] || \
   [ "$color_sel" -gt "${#accent_names[@]}" ]; then
    echo "Invalid color selection. Exiting."
    exit 1
fi

accent_idx=$((color_sel - 1))
chosen_color="${accent_colors[$accent_idx]}"
chosen_name="${accent_names[$accent_idx]}"

echo "Accent  : $chosen_name ($chosen_color)"
echo "Targets : ${selected_dirs[*]}"
echo ""

# Main loop
for dir in "${selected_dirs[@]}"; do
    [ -d "$dir" ] || continue
    echo "==> Entering $dir"
    cd "$dir"

    if [ ! -f Makefile ]; then
        echo "    No Makefile found, skipping."
        cd ..
        continue
    fi

    # detect source header
    if [ -f config.def.h ]; then
        src="config.def.h"
        dst="config.h"
    elif [ -f blocks.def.h ]; then
        src="blocks.def.h"
        dst="blocks.h"
    else
        echo "    No config.def.h or blocks.def.h found, skipping."
        cd ..
        continue
    fi

    if [ -f "$dst" ]; then
        echo "    $dst already exists, skipping to avoid overwrite."
        cd ..
        continue
    fi

    echo "    Creating $dst with accent $chosen_color ..."
    sed "s|${DEFAULT_ACCENT}|${chosen_color}|g" "$src" > "$dst"

    echo "    Building..."
    if make clean install; then
        make clean
    else
        echo "    Build failed for $dir."
    fi

    echo "    Removing $dst ..."
    rm -f "$dst"

    cd ..
    echo ""
done

echo "Done."
