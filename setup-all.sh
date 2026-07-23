#!/usr/bin/env bash
# One-shot: deps → clone upstream → build Lite → AppImage
set -euo pipefail

cd "$(cd "$(dirname "$0")" && pwd)"

echo
echo "======================================"
echo " GoClaw Lite — CachyOS / Arch build"
echo "======================================"
echo
echo "This will run all steps (needs network; may take a while)."
echo

if [[ -t 0 ]]; then
  read -r -p "Continue? [y/N]: " ans
  case "${ans,,}" in
    y|yes|да|д|"") ;;
    *) echo "Cancelled."; exit 0 ;;
  esac
fi

chmod +x scripts/*.sh 2>/dev/null || true

step() { echo; echo "==> $1"; echo; }

step "1/4 Install build dependencies"
bash scripts/install-deps-cachyos.sh

step "2/4 Clone upstream GoClaw"
bash scripts/clone-upstream.sh

step "3/4 Build Lite"
bash scripts/build-lite.sh

step "4/4 Package AppImage"
bash scripts/package-appimage.sh

echo
echo "======================================"
echo " Done"
echo "======================================"
echo
if ls dist/*.AppImage >/dev/null 2>&1; then
  echo "Artifact:"
  ls -lh dist/*.AppImage
  echo
  echo "Run:"
  echo "  chmod +x dist/GoClaw-Lite-x86_64.AppImage"
  echo "  ./dist/GoClaw-Lite-x86_64.AppImage"
else
  echo "AppImage not found. Check errors above."
  exit 1
fi
echo
if [[ -t 0 ]]; then
  read -r -p "Press Enter to exit..." _
fi
