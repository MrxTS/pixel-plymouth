# pixel-plymouth

A pixel art character animation Plymouth boot theme.

The animation frames are generated with ComfyUI (AnimateDiff + Pixel Art LoRA) and rendered as a looping sprite during boot.

## Structure

```
pixel-plymouth/
├── pixel-plymouth.plymouth   # Theme metadata
├── pixel-plymouth.script     # Animation logic
├── media/                    # PNG frames (frame-0.png, frame-1.png, ...)
├── install.sh                # Install + auto-detect frame count
└── convert.sh                # Convert GIF/video to PNG sequence
```

## Usage

### 1. Add your frames

Export your animation from ComfyUI as a PNG sequence or GIF and place it in `media/`.

**If you have a GIF or video:**
```bash
./convert.sh your-animation.gif 256 256
```

**If you already have PNG frames**, name them `frame-0.png`, `frame-1.png`, etc. and place them in `media/`.

### 2. Install

```bash
./install.sh
```

This will:
- Auto-detect the frame count and update the script
- Copy the theme to `/usr/share/plymouth/themes/pixel-plymouth/`
- Set it as the default theme
- Rebuild the initramfs via `mkinitcpio -P`

### 3. Test without rebooting

```bash
sudo plymouthd --debug --attach-to-session
sudo plymouth --show-splash
sleep 5
sudo plymouth quit
```

## Configuration

Edit `pixel-plymouth.script` to adjust:

| Variable | Default | Description |
|----------|---------|-------------|
| `frame_count` | `48` | Number of PNG frames |
| `ticks_per_frame` | `5` | Speed (~12 fps at 60 Hz) |

**FPS formula:** `ticks_per_frame = screen_hz / target_fps`

## Recommended frame settings

| Setting | Value |
|---------|-------|
| Resolution | 256×256 or 512×512 px |
| Format | PNG with transparency |
| Frame count | 24–60 |
| Target FPS | 10–15 |

## ComfyUI Setup (Windows)

| Component | Recommendation |
|-----------|---------------|
| Base model | SDXL 1.0 or Pony Diffusion |
| LoRA | `pixel-art-xl` (CivitAI) |
| Animation | AnimateDiff-Evolved node |
| Motion module | `mm_sdxl_v10_beta.ckpt` |
| Export | PNG sequence or GIF |

## Requirements

- `plymouth` (installed on most distros)
- `ffmpeg` (only for `convert.sh`)
- Arch/CachyOS: `mkinitcpio` for initramfs rebuild
