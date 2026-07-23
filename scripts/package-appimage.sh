#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
UPSTREAM="$ROOT/upstream"
DIST="$ROOT/dist"
APPDIR="$DIST/GoClaw-Lite.AppDir"
APP_NAME="GoClaw-Lite"
ARCH="x86_64"
OUT_APPIMAGE="$DIST/${APP_NAME}-${ARCH}.AppImage"
LANG_UI="${LANG_UI:-en}"
UPDATE_REPO="${UPDATE_REPO:-reclaw17/goclaw-lite-cachyos}"
ASSET_NAME="${ASSET_NAME:-GoClaw-Lite-x86_64.AppImage}"

log() { echo "==> $*"; }
err() { echo "==> ERROR: $*" >&2; exit 1; }

mkdir -p "$DIST"

BIN="$(find "$UPSTREAM/ui/desktop/build" -type f -executable 2>/dev/null | head -n 1 || true)"
if [[ -z "$BIN" || ! -f "$BIN" ]]; then
  if [[ "$LANG_UI" == "ru" ]]; then
    err "Бинарник не найден. Сначала: bash scripts/build-lite.sh"
  else
    err "Binary not found. Run build-lite.sh first."
  fi
fi
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

# Embed update defaults (baked at package time)
cat > "$APPDIR/usr/share/goclaw-lite-update.env" <<EOF
UPDATE_REPO=${UPDATE_REPO}
ASSET_NAME=${ASSET_NAME}
EOF

# Self-contained AppRun with --update / --check-update
cat > "$APPDIR/AppRun" <<'EOF'
#!/bin/bash
# GoClaw Lite portable launcher + embedded updater
set -euo pipefail

HERE="$(dirname "$(readlink -f "$0")")"
export PATH="$HERE/usr/bin:$PATH"
export LD_LIBRARY_PATH="$HERE/usr/lib:${LD_LIBRARY_PATH:-}"

# When running as AppImage these are set by the runtime:
#   APPIMAGE = path to the .AppImage file on disk
#   APPDIR   = mounted squashfs root
SELF="${APPIMAGE:-}"
if [[ -z "$SELF" ]]; then
  # running extracted AppDir
  SELF="$HERE/AppRun"
fi

ENV_FILE="$HERE/usr/share/goclaw-lite-update.env"
UPDATE_REPO="reclaw17/goclaw-lite-cachyos"
ASSET_NAME="GoClaw-Lite-x86_64.AppImage"
if [[ -f "$ENV_FILE" ]]; then
  # shellcheck disable=SC1090
  source "$ENV_FILE" || true
fi
UPDATE_REPO="${UPDATE_REPO:-reclaw17/goclaw-lite-cachyos}"
ASSET_NAME="${ASSET_NAME:-GoClaw-Lite-x86_64.AppImage}"
API="https://api.github.com/repos/${UPDATE_REPO}/releases/latest"

version_file_for() {
  local app="$1"
  echo "$(dirname "$app")/.goclaw-lite-version"
}

read_local_ver() {
  local vf
  vf="$(version_file_for "$SELF")"
  if [[ -f "$vf" ]]; then tr -d '\r\n' < "$vf"; else echo "unknown"; fi
}

fetch_latest() {
  # sets: LATEST_TAG LATEST_URL
  local tmp
  tmp="$(mktemp)"
  if ! curl -fsSL -H "Accept: application/vnd.github+json" -H "User-Agent: goclaw-lite-appimage" \
      "$API" -o "$tmp"; then
    rm -f "$tmp"
    echo "ERROR: cannot reach GitHub Releases ($UPDATE_REPO)" >&2
    return 1
  fi
  LATEST_TAG="$(python3 -c 'import json,sys; print(json.load(open(sys.argv[1])).get("tag_name") or "")' "$tmp")"
  LATEST_URL="$(python3 -c '
import json,sys
r=json.load(open(sys.argv[1])); name=sys.argv[2]
for a in r.get("assets") or []:
  if a.get("name")==name:
    print(a.get("browser_download_url") or ""); break
' "$tmp" "$ASSET_NAME")"
  rm -f "$tmp"
  [[ -n "$LATEST_TAG" && -n "$LATEST_URL" ]]
}

do_check_update() {
  local cur
  cur="$(read_local_ver)"
  echo "AppImage: $SELF"
  echo "Local:    $cur"
  if ! fetch_latest; then
    return 1
  fi
  echo "Latest:   $LATEST_TAG"
  if [[ "$cur" == "$LATEST_TAG" ]]; then
    echo "Status:   up to date"
    return 0
  fi
  echo "Status:   update available"
  return 2
}

do_self_update() {
  if [[ -z "${APPIMAGE:-}" ]]; then
    echo "ERROR: self-update works when launched as an AppImage (APPIMAGE is unset)." >&2
    echo "       Use: ./GoClaw-Lite-x86_64.AppImage --update" >&2
    return 1
  fi
  if [[ ! -f "$SELF" ]]; then
    echo "ERROR: cannot locate AppImage path: $SELF" >&2
    return 1
  fi
  if ! fetch_latest; then
    return 1
  fi
  local cur
  cur="$(read_local_ver)"
  echo "Local:  $cur"
  echo "Latest: $LATEST_TAG"
  if [[ "$cur" == "$LATEST_TAG" ]]; then
    echo "Already up to date."
    return 0
  fi
  echo "Downloading $ASSET_NAME ..."
  local tmp new bak vf
  tmp="$(mktemp)"
  new="${SELF}.new"
  if ! curl -fL --progress-bar -o "$tmp" "$LATEST_URL"; then
    rm -f "$tmp"
    echo "ERROR: download failed" >&2
    return 1
  fi
  chmod +x "$tmp"
  mv -f "$tmp" "$new"
  bak="${SELF}.bak-$(date +%Y%m%d-%H%M%S)"
  cp -f "$SELF" "$bak" 2>/dev/null || true
  # Replace on-disk AppImage (not the mounted image)
  mv -f "$new" "$SELF"
  chmod +x "$SELF"
  vf="$(version_file_for "$SELF")"
  echo "$LATEST_TAG" > "$vf"
  echo "Updated to $LATEST_TAG"
  echo "Backup: $bak"
  echo "Run again: $SELF"
}

usage_update() {
  cat <<U
GoClaw Lite portable AppImage

  (no args)           Start GoClaw Lite
  --update            Download latest AppImage from GitHub Releases and replace this file
  --check-update      Only check whether an update is available
  --help-update       Show this help

Optional env:
  GOCLAW_LITE_AUTO_UPDATE=1   Check on startup and print a notice if update exists
  UPDATE_REPO=owner/repo        Override releases repo (default baked in)
U
}

case "${1:-}" in
  --update|update)
    do_self_update
    exit $?
    ;;
  --check-update|--check-updates)
    set +e
    do_check_update
    rc=$?
    set -e
    exit "$rc"
    ;;
  --help-update)
    usage_update
    exit 0
    ;;
esac

# Optional non-blocking notice (does not auto-download)
if [[ "${GOCLAW_LITE_AUTO_UPDATE:-0}" == "1" ]]; then
  set +e
  do_check_update >/tmp/goclaw-lite-update-check.$$ 2>&1
  rc=$?
  set -e
  if [[ "$rc" -eq 2 ]]; then
    echo "==> GoClaw Lite: update available. Run:"
    echo "    $SELF --update"
  fi
  rm -f /tmp/goclaw-lite-update-check.$$
fi

exec "$HERE/usr/bin/goclaw-lite" "$@"
EOF
chmod +x "$APPDIR/AppRun"

cat > "$APPDIR/goclaw-lite.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=GoClaw Lite
Comment=Portable GoClaw Lite (Arch/CachyOS)
Exec=goclaw-lite
Icon=goclaw-lite
Categories=Utility;Development;
Terminal=false
Actions=Update;

[Desktop Action Update]
Name=Update GoClaw Lite
Exec=goclaw-lite --update
EOF
cp "$APPDIR/goclaw-lite.desktop" "$APPDIR/usr/share/applications/"

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

log "Building AppImage (with embedded --update)..."
cd "$DIST"
ARCH="$ARCH" "$APPIMAGETOOL" "$APPDIR" "$OUT_APPIMAGE"
chmod +x "$OUT_APPIMAGE"

# local stamps for repo-side update.sh
if [[ -d "$UPSTREAM/.git" ]]; then
  UP_SHA="$(git -C "$UPSTREAM" rev-parse HEAD 2>/dev/null || true)"
  if [[ -n "$UP_SHA" ]]; then
    echo "$UP_SHA" > "$DIST/.upstream-revision"
    echo "upstream-${UP_SHA:0:7}" > "$DIST/.goclaw-lite-version"
  fi
fi

log "Done: $OUT_APPIMAGE"
log "Self-update: ./GoClaw-Lite-x86_64.AppImage --update"
ls -lh "$OUT_APPIMAGE"
