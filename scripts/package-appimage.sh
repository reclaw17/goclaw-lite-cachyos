#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
UPSTREAM="$ROOT/upstream"
DIST="$ROOT/dist"
APPDIR="$DIST/GoClaw-Lite.AppDir"
APP_NAME="GoClaw-Lite"
ARCH="x86_64"
OUT_APPIMAGE="$DIST/${APP_NAME}-${ARCH}.AppImage"

log() { echo "==> $*"; }
err() { echo "==> ERROR: $*" >&2; exit 1; }

mkdir -p "$DIST"

BIN="$(find "$UPSTREAM/ui/desktop/build" -type f -executable 2>/dev/null | head -n 1 || true)"
[[ -n "$BIN" && -f "$BIN" ]] || err "Binary not found. Run build-lite.sh first."
log "Binary: $BIN"

if command -v appimagetool >/dev/null 2>&1; then
  APPIMAGETOOL="$(command -v appimagetool)"
elif [[ -x "$DIST/appimagetool" ]]; then
  APPIMAGETOOL="$DIST/appimagetool"
else
  log "Downloading appimagetool..."
  curl -L --fail --progress-bar -o "$DIST/appimagetool" \
    "https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-x86_64.AppImage"
  chmod +x "$DIST/appimagetool"
  APPIMAGETOOL="$DIST/appimagetool"
fi

rm -rf "$APPDIR"
mkdir -p "$APPDIR/usr/bin" "$APPDIR/usr/lib" "$APPDIR/usr/share/applications" "$APPDIR/usr/share/icons/hicolor/256x256/apps"
cp "$BIN" "$APPDIR/usr/bin/goclaw-lite"
chmod +x "$APPDIR/usr/bin/goclaw-lite"

cat > "$APPDIR/AppRun" <<'EOF'
#!/bin/bash
set -e
HERE="$(dirname "$(readlink -f "$0")")"
export PATH="$HERE/usr/bin:$PATH"
export LD_LIBRARY_PATH="$HERE/usr/lib:${LD_LIBRARY_PATH:-}"
exec "$HERE/usr/bin/goclaw-lite" "$@"
EOF
chmod +x "$APPDIR/AppRun"

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

# minimal png placeholder
printf '\x89PNG\r\n\x1a\n\x00\x00\x00\rIHDR\x00\x00\x00\x01\x00\x00\x00\x01\x08\x02\x00\x00\x00\x90wS\xde\x00\x00\x00\x0cIDATx\x9cc\xf8\x0f\x00\x00\x01\x01\x00\x05\x18\xd8N\x00\x00\x00\x00IEND\xaeB`\x82' \
  > "$APPDIR/goclaw-lite.png"
cp "$APPDIR/goclaw-lite.png" "$APPDIR/usr/share/icons/hicolor/256x256/apps/goclaw-lite.png"

if command -v ldd >/dev/null 2>&1; then
  ldd "$BIN" 2>/dev/null | awk '/=> \// {print $3}' | while read -r so; do
    [[ -f "$so" ]] || continue
    base="$(basename "$so")"
    case "$base" in
      libc.so.*|libm.so.*|libdl.so.*|libpthread.so.*|libresolv.so.*|ld-linux-*.so.*) continue ;;
    esac
    cp -n "$so" "$APPDIR/usr/lib/" 2>/dev/null || true
  done
fi

log "Building AppImage..."
cd "$DIST"
ARCH="$ARCH" "$APPIMAGETOOL" "$APPDIR" "$OUT_APPIMAGE"
chmod +x "$OUT_APPIMAGE"
log "Done: $OUT_APPIMAGE"
ls -lh "$OUT_APPIMAGE"
