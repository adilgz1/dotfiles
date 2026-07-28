#!/usr/bin/env bash
#
# config_symlinker.sh
#
# Two-part setup for a fresh machine after cloning your dotfiles repo:
#   1. Lists directories in ~/.dotfiles/config/ and symlinks chosen ones into ~/.config/
#   2. Lists files directly in ~/.dotfiles/ and symlinks chosen ones into ~/
#      (auto-prefixes a leading '.' if the filename doesn't already have one,
#      so a repo file named 'zshrc' becomes ~/.zshrc — skips this if the name
#      already starts with a dot)

set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"
CONFIG_SRC_DIR="$DOTFILES_DIR/config"
CONFIG_DEST_DIR="$HOME/.config"

if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Error: $DOTFILES_DIR does not exist. Did you clone the dotfiles repo?"
    exit 1
fi

echo "Fetching git submodules..."
(cd "$DOTFILES_DIR" && git submodule update --init --recursive)
echo ""

mkdir -p "$CONFIG_DEST_DIR"

# ---------------------------------------------------------------------------
# Reusable function: list items of a given type in a source dir, ask which
# ones to symlink, then create the symlinks (with backup-on-conflict).
#
# Args: <source_dir> <dest_dir> <find_type: f|d> <add_dot_prefix: true|false>
# ---------------------------------------------------------------------------
symlink_selection() {
    local src_dir="$1"
    local dest_dir="$2"
    local add_dot="$3"


    available=()
    while IFS= read -r line; do
      available+=("$line")
    done < <(find "$src_dir" -mindepth 1 -maxdepth 1 \( -type f -o -type d \) ! -name "config" -exec basename {} \; | sort)



    if [ "${#available[@]}" -eq 0 ]; then
        echo "No matching items found in $src_dir — skipping this section."
        return
    fi

    echo "Available items in $src_dir:"
    for item in "${available[@]}"; do
        echo "  - $item"
    done
    echo ""

    read -rp "Enter the items you want to symlink (space-separated), or press Enter to skip: " -a chosen

    if [ "${#chosen[@]}" -eq 0 ]; then
        echo "Skipping this section — no items entered."
        return
    fi

    for item in "${chosen[@]}"; do
        local name="$item"
        if [ "$add_dot" = true ] && [[ "$name" != .* ]]; then
            name=".$name"
        fi

        local src="$src_dir/$item"
        local dest="$dest_dir/$name"

        if [ ! -e "$src" ]; then
            echo "Skipping '$item' — not found in $src_dir"
            continue
        fi

        if [ -e "$dest" ] || [ -L "$dest" ]; then
            if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
                echo "Skipping '$name' — already correctly symlinked."
                continue
            fi

            read -rp "  '$dest' already exists. Back it up and replace with symlink? [y/N] " confirm
            if [[ "$confirm" =~ ^[Yy]$ ]]; then
                local backup="${dest}.bak.$(date +%Y%m%d%H%M%S)"
                mv "$dest" "$backup"
                echo "  Backed up existing '$name' to $backup"
            else
                echo "  Skipping '$name'."
                continue
            fi
        fi

        ln -s "$src" "$dest"
        echo "Linked $dest -> $src"
    done
}

# ---------------------------------------------------------------------------
# Part 1: config/ directories -> ~/.config/
# ---------------------------------------------------------------------------
echo "=== Part 1: Config directories (~/.dotfiles/config/*  ->  ~/.config/) ==="
echo ""
symlink_selection "$CONFIG_SRC_DIR" "$CONFIG_DEST_DIR" false

echo ""
echo "=== Part 2: Dotfiles (~/.dotfiles/*  ->  ~/) ==="
echo ""
symlink_selection "$DOTFILES_DIR" "$HOME" true

echo ""
echo "Done."
