# TODO

## In Progress

- [ ] Design pixel art character (Windows / ComfyUI)

## Pending

### Animation
- [ ] Set up ComfyUI workflow (AnimateDiff + Pixel Art LoRA)
- [ ] Generate character idle animation (24–48 frames)
- [ ] Export as PNG sequence or GIF
- [ ] Run `convert.sh` to normalize frames

### Theme
- [ ] Test `install.sh` on CachyOS
- [ ] Tune `ticks_per_frame` for correct playback speed
- [ ] Test Plymouth rendering at boot

### Polish
- [ ] Add optional background (dark/transparent)
- [ ] Test at different screen resolutions
- [ ] Add password prompt styling (if needed for LUKS)

## Done

- [x] Plymouth theme file structure
- [x] Animation script (`pixel-plymouth.script`)
- [x] Install script (`install.sh`)
- [x] Frame conversion helper (`convert.sh`)
