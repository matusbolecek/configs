#!/usr/bin/env bash
 
set -euo pipefail
 
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$HOME"
EXCLUDE_DIRS=("redundant")
STOW_FLAGS="--verbose=1"
 
die()  { echo "ERROR: $*" >&2; exit 1; }
info() { echo "  » $*"; }
 
command -v stow &>/dev/null || die "stow is not installed."
 
# Get packages 
is_excluded() {
    local name="$1"
    for ex in "${EXCLUDE_DIRS[@]}"; do
        [[ "$name" == "$ex" ]] && return 0
    done
    return 1
}
 
mapfile -t packages < <(
    find "$DOTFILES_DIR" -maxdepth 1 -mindepth 1 -type d -printf '%f\n' \
    | sort \
    | while read -r d; do is_excluded "$d" || echo "$d"; done
)
 
[[ ${#packages[@]} -gt 0 ]] || die "No packages found in $DOTFILES_DIR"
 
# Pick folder 
echo ""
echo "┌─ Available packages ─────────────────────────────────────┐"
for i in "${!packages[@]}"; do
    printf "│  %2d)  %-51s│\n" "$((i+1))" "${packages[$i]}"
done
echo "│   a)  All                                                │"
echo "└──────────────────────────────────────────────────────────┘"
echo ""
echo "Enter numbers separated by spaces, or 'a' for all."
read -rp "Install: " raw_selection
echo ""
 
selected=()
if [[ "$raw_selection" =~ ^[[:space:]]*[aA][[:space:]]*$ ]]; then
    selected=("${packages[@]}")
else
    for token in $raw_selection; do
        if [[ "$token" =~ ^[0-9]+$ ]] && (( token >= 1 && token <= ${#packages[@]} )); then
            selected+=("${packages[$((token - 1))]}")
        else
            echo "  [!] Ignoring unknown selection: '$token'"
        fi
    done
fi
 
[[ ${#selected[@]} -gt 0 ]] || die "Nothing selected."
 
echo "Packages to deploy: ${selected[*]}"
echo ""
 
# Create directories in advance 
precreate_dirs() {
    local pkg="$1"
    local pkg_path="$DOTFILES_DIR/$pkg"
 
    while IFS= read -r -d '' dir; do
        local rel="${dir#"$pkg_path"/}"
        local target="$TARGET_DIR/$rel"
 
        if [[ -L "$target" ]]; then
            # It's already a stow-managed directory symlink — warn, skip.
            echo "  [!] $target is a symlink (possible previous stow dir-fold)."
            echo "      Remove it manually if you want file-level symlinks here."
        elif [[ ! -d "$target" ]]; then
            info "mkdir -p $target"
            mkdir -p "$target"
        fi
        # If it's already a real dir, nothing to do.
    done < <(find "$pkg_path" -mindepth 1 -type d -print0)
}
 
echo "── Pre-creating directories ──────────────────────────────────"
for pkg in "${selected[@]}"; do
    echo "[$pkg]"
    precreate_dirs "$pkg"
done
echo ""
 
# Stow main part 
echo "── Running stow ──────────────────────────────────────────────"
for pkg in "${selected[@]}"; do
    echo "[$pkg]"
    # shellcheck disable=SC2086  # intentional word-splitting of STOW_FLAGS
    stow $STOW_FLAGS --target="$TARGET_DIR" --dir="$DOTFILES_DIR" "$pkg"
done
 
echo ""
echo "Done."
