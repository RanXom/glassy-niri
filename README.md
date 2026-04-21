# Glassy Niri + Noctalia Setup

This repository contains my personal **Niri Wayland + Noctalia Shell**
configuration, extended with a **glassy / translucent aesthetic layer**
and an optional interactive setup script.

It serves both as:
- a **daily-driver environment**
- a **reference for building a minimal, keyboard-first Wayland setup**

This is not intended to be a universal, one-command desktop replacement.

## What’s Included

- Glassy / blurred UI (Niri + Kitty + Noctalia)
- Custom **Fastfetch** configuration and ASCII
- **Obsidian transparency snippets**
- **Zen Browser** styling (extensions + mods)
- Interactive **setup script** (backup + dry run support)

## Disclaimer

This setup is **hardware-specific and opinionated**.

It assumes:
- familiarity with Wayland
- comfort debugging broken sessions
- willingness to read configuration files before applying them

Do not blindly run things and expect everything to work perfectly.

---

## Important Before Installing

### 0. Niri (IMPORTANT! Git Version Required)

This setup uses `niri-git` instead of the stable `niri` package
(for blur and newer features).

* On CachyOS:
  ```bash
  sudo pacman -S niri-git
  ```

* On Arch Linux:
  Install via an AUR helper (e.g. yay, paru):
  ```bash
  yay -S niri-git
  ```

### 1. Font Requirement

This setup uses **JetBrains Mono Nerd Font**.

Install it before proceeding:

```bash
# Arch Linux
sudo pacman -S ttf-jetbrains-mono-nerd
````

Or install it manually from Nerd Fonts.

### 2. Display Configuration (Critical)

The Niri configuration is tuned for a **high-DPI display**
(2560×1600 at scale 1.5).

If your display differs, you must adjust it.

Run:

```bash
niri msg outputs
```

Then edit:

```bash
~/.config/niri/config.kdl
```

Update:

* resolution
* refresh rate
* scale

Example:

```kdl
output "eDP-2" {
    mode "2560x1600@60.002"
    scale 1.5
}
```

If your display is below 2K, set:

```kdl
scale 1
```

If you skip this step, the layout WILL break.

---

## Prerequisites

CachyOS (or any other Arch-based) is recommended.

Install required packages:

```bash
niri-git
noctalia-shell
kitty
vicinae
neovim
zathura
zsh
starship
zen-browser
yazi
eza
```

---

## Setup (Recommended)

An interactive setup script is included:

```bash
chmod +x setup.sh
./setup.sh
```

Features:

* selective module installation
* automatic backups (`.bak.timestamp`)
* dry-run preview mode
* uninstall (restore) support

> *NOTE:* You are still expected to review what the script does before running it.

---

## Stack Overview

### Core

* Compositor / WM: niri
* Shell UI: noctalia-shell
* Display Server: Wayland
* Login Manager: SDDM (not included in the dots)

### Applications

* Terminal: kitty
* Editor: Neovim
* Launcher: Vicinae
* File Manager: yazi
* Browser: Zen Browser
* Notes: Obsidian
* Music: kew
* PDF Viewer: zathura
* Prompt: starship
* Shell: zsh

---

## Post Installation Setup for Zen Browser & Obsidian

This setup includes additional visual customization:

### Obsidian

After applying custom CSS snippets (`obsidian-snippets/`), you may proceed this way:
* Install Zen theme
* Allow community plugins and install style settings
* Open up style settings and tweak Zen theme this way:
  * Window Settings -> Brightness = 1.0
  * Editor Settings -> Hide heading prompt & hide bottom line & text justification= on, width of editor = 750
  * Windows/Linux -> Transparency for windows = 0, adjust colors to be '#FFFFFF0D' for both light and dark

### Zen Browser

For Zen-Browser's Transparency install:

  * Zen Internet extension
  * Transparent Zen mod

---

## Repository Structure

```text
glassy-dots/
├── config/
├── obsidian-snippets/
├── wallpapers/
├── setup.sh
└── README.md
```

---

## Notes

Obsidian snippets must be placed inside your vault manually or via script.
Zen Browser configuration is manual and done via extension and mods.
Output configuration is always device-specific.

If something does not work:

* check your display configuration
* verify dependencies
* read the configs

If it still does not work, there is a high probability that
something important was skipped earlier.

---

## Status

Stable. Actively used. Changes will be incremental with time.
