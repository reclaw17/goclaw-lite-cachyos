#!/usr/bin/env bash
# Interactive: deps → clone → build → optional AppImage
set -euo pipefail

cd "$(cd "$(dirname "$0")" && pwd)"

echo
echo "======================================"
echo " GoClaw Lite build (CachyOS / Arch)"
echo "======================================"
echo
echo "3–4 steps. Dependency install may ask for sudo password."
echo

ask() {
  local q="$1" a
  while true; do
    read -r -p "==> $q [y/N]: " a
    case "${a,,}" in
      y|yes|да|д|"") return 0 ;;
      n|no|нет|н) return 1 ;;
      *) echo "    Type y or n" ;;
    esac
  done
}

if ! ask "Start build?"; then
  echo "==> Cancelled"
  exit 0
fi

chmod +x scripts/*.sh 2>/dev/null || true

echo
echo "==> Step 1/4: dependencies"
bash scripts/install-deps-cachyos.sh

echo
echo "==> Step 2/4: upstream sources"
bash scripts/clone-upstream.sh

echo
echo "==> Step 3/4: build Lite"
bash scripts/build-lite.sh

echo
if ask "Package AppImage for USB?"; then
  echo "==> Step 4/4: AppImage"
  bash scripts/package-appimage.sh
  echo
  echo "==> Done — see dist/"
else
  echo "==> AppImage skipped"
  echo "    Binary: upstream/ui/desktop/build/bin/"
fi

echo
echo "==> Press Enter to exit"
read -r _
