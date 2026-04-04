#!/usr/bin/env bash
set -euo pipefail

THEME_NAME="pixel-plymouth"
THEME_DIR="/usr/share/plymouth/themes/${THEME_NAME}"
SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Prüfen ob media/ Frames enthält
frame_count=$(ls "${SRC_DIR}/media/frame-"*.png 2>/dev/null | wc -l)
if [[ "$frame_count" -eq 0 ]]; then
  echo "FEHLER: Keine Frames in media/ gefunden (erwartet: media/frame-0.png, frame-1.png, ...)"
  exit 1
fi
echo "Frames gefunden: ${frame_count}"

# Frame-Count automatisch ins Script schreiben
sed -i "s/^frame_count\s*=\s*[0-9]*/frame_count     = ${frame_count}/" \
  "${SRC_DIR}/pixel-plymouth.script"
echo "frame_count im Script auf ${frame_count} gesetzt"

# Theme-Verzeichnis anlegen und Dateien kopieren
sudo mkdir -p "${THEME_DIR}/media"
sudo cp "${SRC_DIR}/pixel-plymouth.plymouth" "${THEME_DIR}/"
sudo cp "${SRC_DIR}/pixel-plymouth.script"   "${THEME_DIR}/"
sudo cp "${SRC_DIR}/media/"*.png             "${THEME_DIR}/media/"

# Als Standard-Theme setzen
sudo plymouth-set-default-theme "${THEME_NAME}"

# Initramfs neu bauen (CachyOS / Arch)
echo "Baue Initramfs neu..."
sudo mkinitcpio -P

echo "Fertig! Theme '${THEME_NAME}' ist aktiv."
echo "Test: sudo plymouthd --debug && sudo plymouth --show-splash && sleep 5 && sudo plymouth quit"
