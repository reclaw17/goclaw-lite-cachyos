#!/usr/bin/env bash
# Package built GoClaw Lite into an AppImage (USB-portable target)
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
UPSTREAM="$ROOT/upstream"
DESKTOP_BIN="$UPSTREAM/ui/desktop/build/bin"
DIST="$ROOT/dist"
APPDIR="$DIST/GoClaw-Lite.AppDir"
APP_NAME="GoClaw-Lite"
ARCH="x86_64"
OUT_APPIMAGE="$DIST/${APP_NAME}-${ARCH}.AppImage"

log() { echo "==> $*"; }
err() { echo "==> ERROR: $*" >&2; exit 1; }

log "AppImage packaging for GoClaw Lite"
mkdir -p "$DIST"

# 1) Find binary from wails build
BIN=""
if [[ -d "$DESKTOP_BIN" ]]; then
  BIN="$(find "$DESKTOP_BIN" -maxdepth 3 -type f -executable ! -name "*.so" 2>/dev/null | head -n 1 || true)"
fi
if [[ -z "$BIN" ]]; then
  # fallback: any built binary under desktop/build
  BIN="$(find "$UPSTREAM/ui/desktop/build" -type f -executable 2>/dev/null | head -n 1 || true)"
fi
[[ -n "$BIN" && -f "$BIN" ]] || err "Сначала собери Lite: bash scripts/build-lite.sh (бинарник не найден)"

log "Binary: $BIN"

# 2) Tools: appimagetool
APPIMAGETOOL=""
if command -v appimagetool >/dev/null 2>&1; then
  APPIMAGETOOL="$(command -v appimagetool)"
elif [[ -x "$DIST/appimagetool" ]]; then
  APPIMAGETOOL="$DIST/appimagetool"
else
  log "Скачиваю appimagetool..."
  curl -L --fail --progress-bar \
    -o "$DIST/appimagetool" \
    "https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-x86_64.AppImage" \
    || err "Не удалось скачать appimagetool"
  chmod +x "$DIST/appimagetool"
  APPIMAGETOOL="$DIST/appimagetool"
fi

# 3) Build AppDir layout
rm -rf "$APPDIR"
mkdir -p "$APPDIR/usr/bin" "$APPDIR/usr/lib" "$APPDIR/usr/share/applications" "$APPDIR/usr/share/icons/hicolor/256x256/apps"

cp "$BIN" "$APPDIR/usr/bin/goclaw-lite"
chmod +x "$APPDIR/usr/bin/goclaw-lite"

# Apprun
cat > "$APPDIR/AppRun" <<'EOF'
#!/bin/bash
set -e
HERE="$(dirname "$(readlink -f "$0")")"
export PATH="$HERE/usr/bin:$PATH"
export LD_LIBRARY_PATH="$HERE/usr/lib:${LD_LIBRARY_PATH:-}"
exec "$HERE/usr/bin/goclaw-lite" "$@"
EOF
chmod +x "$APPDIR/AppRun"

# Desktop entry
cat > "$APPDIR/goclaw-lite.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=GoClaw Lite
Exec=goclaw-lite
Icon=goclaw-lite
Categories=Utility;Development;
Terminal=false
EOF
cp "$APPDIR/goclaw-lite.desktop" "$APPDIR/usr/share/applications/"

# Placeholder icon (empty png not required for tool; create simple text mark)
if command -v convert >/dev/null 2>&1; then
  convert -size 256x256 xc:'#1e1e2e' -fill white -gravity center -pointsize 28 -annotate 0 'GC' \
    "$APPDIR/goclaw-lite.png" || true
fi
if [[ ! -f "$APPDIR/goclaw-lite.png" ]]; then
  # minimal valid 1x1 png
  printf '\x89PNG\r\n\x1a\n\x00\x00\x00\rIHDR\x00\x00\x00\x01\x00\x00\x00\x01\x08\x02\x00\x00\x00\x90wS\xde\x00\x00\x00\x0cIDATx\x9cc\xf8\x0f\x00\x00\x01\x01\x00\x05\x18\xd8N\x00\x00\x00\x00IEND\xaeB`\x82' \
    > "$APPDIR/goclaw-lite.png"
fi
cp "$APPDIR/goclaw-lite.png" "$APPDIR/usr/share/icons/hicolor/256x256/apps/goclaw-lite.png"

# 4) Optional: copy linked libs (best-effort local portable boost)
log "Собираю shared-libs рядом (best-effort)..."
if command -v ldd >/dev/null 2>&1; then
  ldd "$BIN" 2>/dev/null | awk '/=> \// {print $3}' | while read -r so; do
    [[ -f "$so" ]] || continue
    # skip glibc core — AppImage host usually provides these
    base="$(basename "$so")"
    case "$base" in
      libc.so.*|libm.so.*|libdl.so.*|libpthread.so.*|libresolv.so.*|ld-linux-*.so.*) continue ;;
    esac
    cp -n "$so" "$APPDIR/usr/lib/" 2>/dev/null || true
  done
fi

# 5) Create AppImage
log "Собираю AppImage..."
cd "$DIST"
ARCH="$ARCH" "$APPIMAGETOOL" "$APPDIR" "$OUT_APPIMAGE"
chmod +x "$OUT_APPIMAGE"

log "Готово: $OUT_APPIMAGE"
ls -lh "$OUT_APPIMAGE"
echo
echo "Скопируй на флешку и запусти:"
echo "  chmod +x $(basename "$OUT_APPIMAGE")"
echo "  ./$(basename "$OUT_APPIMAGE")"
