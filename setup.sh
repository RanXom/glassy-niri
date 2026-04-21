#!/usr/bin/env bash

set -euo pipefail

DOTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "======================================"
echo "   Glassy Niri Dots Setup"
echo "======================================"
echo "1) Install dotfiles"
echo "2) Uninstall (restore backups)"
echo "3) Preview (dry run)"
read -p "Choose an option: " ACTION

if [[ ! "$ACTION" =~ ^[123]$ ]]; then
  echo "[!] Invalid option"
  exit 1
fi

timestamp() {
  date +%s
}

backup() {
  local target="$1"
  if [ -e "$target" ]; then
    local backup_name="${target}.bak.$(timestamp)"
    mv "$target" "$backup_name"
    echo "[+] Backup created: $backup_name"
  fi
}

restore() {
  local target="$1"
  local latest
  latest=$(ls -t "${target}.bak."* 2>/dev/null | head -n1 || true)

  if [ -n "$latest" ]; then
    if [ -e "$target" ]; then
      rm -rf "$target"
    fi
    mv "$latest" "$target"
    echo "[+] Restored: $target"
  else
    echo "[!] No backup found for $target"
  fi
}

install_module() {
  local name="$1"
  local src="$2"
  local dest="$3"

  if [[ ! -e "$src" ]]; then
    echo "[!] Skipping $name (source not found)"
    return
  fi

  if [[ "$ACTION" == "3" ]]; then
    echo "[DRY RUN] Would install $name -> $dest"
    return
  fi

  backup "$dest"
  mkdir -p "$(dirname "$dest")"
  cp -r "$src" "$(dirname "$dest")"
  echo "[+] Installed $name"
}

ask() {
  read -p "$1 (y/N): " ans
  [[ "$ans" =~ ^[Yy]$ ]]
}

echo ""

if [[ "$ACTION" == "1" ]]; then
  echo ""
  echo "======================================"
  echo "   IMPORTANT SETUP NOTES"
  echo "======================================"
  echo ""
  echo "[1] Font Requirement"
  echo "This setup uses JetBrains Mono Nerd Font."
  echo ""
  echo "Install it before proceeding:"
  echo "  Arch Linux: sudo pacman -S ttf-jetbrains-mono-nerd"
  echo "  Or install manually from Nerd Fonts."
  echo ""
  echo "[2] Display Configuration (VERY IMPORTANT!!)"
  echo "This Niri config is designed for high-DPI displays."
  echo ""
  echo "- If your display is below 2K, set scale to 1"
  echo "- You MUST edit the output section to match your monitor"
  echo ""
  echo "Run this command inside Niri to get your display info:"
  echo "  niri msg outputs"
  echo ""
  echo "Then update:"
  echo "  - resolution"
  echo "  - refresh rate"
  echo "  - scale"
  echo ""
  echo "Example (from this setup):"
  echo ""
  echo "  output \"eDP-2\" {"
  echo "      mode \"2560x1600@60.002\""
  echo "      scale 1.5"
  echo "  }"
  echo ""
  echo "If you skip this, your layout WILL break!!"
  echo ""
  echo "======================================"
  echo ""

  read -p "Continue with installation? (y/N): " confirm
  [[ ! "$confirm" =~ ^[Yy]$ ]] && exit 0
fi

# ---------------- INSTALL ----------------
if [[ "$ACTION" == "1" || "$ACTION" == "3" ]]; then

  if [[ "$ACTION" == "1" ]]; then
    echo "This will modify your config files (backups will be created)."
    read -p "Continue? (y/N): " confirm
    [[ ! "$confirm" =~ ^[Yy]$ ]] && exit 0
  fi

  echo ""
  echo "[*] Starting module installation..."
  echo ""

  ask "Install Niri?" && install_module "niri" "$DOTS_DIR/config/niri" "$HOME/.config/niri"

  ask "Install Kitty?" && install_module "kitty" "$DOTS_DIR/config/kitty" "$HOME/.config/kitty"

  ask "Install Fastfetch?" && install_module "fastfetch" "$DOTS_DIR/config/fastfetch" "$HOME/.config/fastfetch"

  ask "Install Noctalia?" && install_module "noctalia" "$DOTS_DIR/config/noctalia" "$HOME/.config/noctalia"

  ask "Install Neovim?" && install_module "nvim" "$DOTS_DIR/config/nvim" "$HOME/.config/nvim"

  ask "Install Zathura?" && install_module "zathura" "$DOTS_DIR/config/zathura" "$HOME/.config/zathura"

  ask "Install Starship config?" && install_module "starship" "$DOTS_DIR/config/starship.toml" "$HOME/.config/starship.toml"

  # Wallpapers
  if ask "Install wallpapers?"; then
    WALL_DIR="$HOME/Pictures/Wallpapers"

    if [[ "$ACTION" == "3" ]]; then
      echo "[DRY RUN] Would copy wallpapers -> $WALL_DIR"
    else
      mkdir -p "$WALL_DIR"
      if compgen -G "$DOTS_DIR/wallpapers/*" >/dev/null; then
        cp -r "$DOTS_DIR/wallpapers/"* "$WALL_DIR"
        echo "[+] Wallpapers installed"
      else
        echo "[!] No wallpapers found"
      fi
    fi
  fi

  # Obsidian
  if ask "Install Obsidian snippets?"; then
    read -p "Enter your Obsidian vault path (e.g. /home/user/Documents/Obsidian/Vault): " VAULT

    if [[ ! -d "$VAULT" ]]; then
      echo "[!] Path does not exist. Skipping Obsidian."
    else
      SNIPPETS="$VAULT/.obsidian/snippets"

      if [[ "$ACTION" == "3" ]]; then
        echo "[DRY RUN] Would copy snippets -> $SNIPPETS"
      else
        mkdir -p "$SNIPPETS"
        cp -r "$DOTS_DIR/obsidian-snippets/"* "$SNIPPETS"
        echo "[+] Obsidian snippets installed"
      fi
    fi
  fi

fi

# ---------------- UNINSTALL ----------------
if [[ "$ACTION" == "2" ]]; then
  restore "$HOME/.config/niri"
  restore "$HOME/.config/kitty"
  restore "$HOME/.config/fastfetch"
  restore "$HOME/.config/noctalia"
  restore "$HOME/.config/nvim"
  restore "$HOME/.config/zathura"
  restore "$HOME/.config/starship.toml"
fi

echo ""
echo "======================================"
echo "Done."
echo "======================================"
