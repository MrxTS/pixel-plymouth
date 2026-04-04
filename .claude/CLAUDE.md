# CLAUDE.md — pixel-plymouth

## Project Overview

Plymouth boot theme with pixel art character animation.
Frames are generated externally (ComfyUI on Windows) and dropped into `media/`.

## Stack

- **Plymouth Script** — custom scripting language, C/JS-like syntax
- **Shell** — install.sh, convert.sh (bash, no external deps except ffmpeg)
- No build system, no package manager

## Key Files

| File | Purpose |
|------|---------|
| `pixel-plymouth.script` | Main animation logic — edit this for behavior changes |
| `pixel-plymouth.plymouth` | Theme metadata (name, module, paths) |
| `install.sh` | Installs theme system-wide, rebuilds initramfs |
| `convert.sh` | Converts GIF/video to `media/frame-N.png` sequence |
| `media/` | PNG frames, named `frame-0.png` … `frame-N.png` |

## Plymouth Script Constraints

- No stdlib, no file I/O beyond `Image()` loader
- `Image()` paths are relative to `ImageDir` (defined in `.plymouth`)
- `Plymouth.SetRefreshFunction()` is called at display refresh rate (~60 Hz)
- Integer arithmetic: use `Math.Int()` for floor division
- No error handling — a missing frame crashes the splash silently

## Frame Naming Convention

Frames must be named `frame-0.png`, `frame-1.png`, … (zero-based, no gaps).
`install.sh` auto-detects count via glob and patches `frame_count` in the script.

## Install Target

```
/usr/share/plymouth/themes/pixel-plymouth/
├── pixel-plymouth.plymouth
├── pixel-plymouth.script
└── media/frame-*.png
```

After install, initramfs must be rebuilt: `sudo mkinitcpio -P`

## Testing Without Reboot

```bash
sudo plymouthd --debug --attach-to-session
sudo plymouth --show-splash
sleep 5
sudo plymouth quit
```

## System Context

- OS: CachyOS (Arch-based)
- initramfs: mkinitcpio
- Current default theme before this project: `onePiece-plymouth`
