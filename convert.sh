#!/usr/bin/env bash
# Konvertiert eine Video-/GIF-Datei in die benötigte PNG-Frame-Sequenz
# Verwendung: ./convert.sh animation.gif [zielbreite] [zielhöhe]
set -euo pipefail

INPUT="${1:-}"
TARGET_W="${2:-256}"
TARGET_H="${3:-256}"
OUT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/media"

if [[ -z "$INPUT" || ! -f "$INPUT" ]]; then
  echo "Verwendung: $0 <datei.gif|datei.mp4|...> [breite] [höhe]"
  echo "Beispiel:   $0 character.gif 256 256"
  exit 1
fi

echo "Konvertiere '${INPUT}' → PNG-Sequenz in media/ (${TARGET_W}x${TARGET_H}px)..."
mkdir -p "${OUT_DIR}"

ffmpeg -i "${INPUT}" \
  -vf "scale=${TARGET_W}:${TARGET_H}:flags=neighbor" \
  -vsync 0 \
  "${OUT_DIR}/frame-%d.png"

# Umbenennen: frame-1.png → frame-0.png (0-basiert)
count=0
for f in $(ls "${OUT_DIR}/frame-"*.png | sort -V); do
  mv "$f" "${OUT_DIR}/frame-${count}.png"
  count=$((count + 1))
done

echo "Fertig: ${count} Frames in media/"
echo "Nächster Schritt: ./install.sh"
