#!/usr/bin/env bash
# Rebuild portable AppImage from latest upstream GoClaw when it changes
# Requires CachyOS/Arch build toolchain (same as setup-all.sh)
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
LANG_UI="${LANG_UI:-en}"
FORCE="${FORCE:-0}"
BRANCH="${GOCLAW_BRANCH:-dev}"

if [[ "$LANG_UI" == "ru" ]]; then
  echo "==> Пересборка из официального upstream GoClaw"
else
  echo "==> Rebuild from official upstream GoClaw"
fi

export PATH="$PATH:$(go env GOPATH 2>/dev/null)/bin"
export LANG_UI
export GOCLAW_BRANCH="$BRANCH"

chmod +x scripts/*.sh 2>/dev/null || true

# 1) Check upstream
set +e
bash scripts/check-upstream.sh
CHECK=$?
set -e

if [[ "$CHECK" -eq 0 && "$FORCE" != "1" ]]; then
  if [[ "$LANG_UI" == "ru" ]]; then
    echo "==> Upstream не изменился. Пересборка не нужна."
    echo "    Принудительно: FORCE=1 bash scripts/rebuild-from-upstream.sh"
  else
    echo "==> Upstream unchanged. Rebuild not needed."
    echo "    Force: FORCE=1 bash scripts/rebuild-from-upstream.sh"
  fi
  exit 0
fi

# 2) Ensure deps + upstream tree + build + package
if [[ ! -d upstream/.git ]]; then
  bash scripts/clone-upstream.sh
else
  bash scripts/clone-upstream.sh
fi

bash scripts/build-lite.sh
bash scripts/package-appimage.sh

# 3) Stamp with packaging tag + upstream SHA
SHA="$(git -C upstream rev-parse --short HEAD)"
FULL="$(git -C upstream rev-parse HEAD)"
TAG="lite-${SHA}-$(date -u +%Y%m%d)"
bash scripts/write-version-stamp.sh "$TAG" "$FULL" "$BRANCH"

if [[ "$LANG_UI" == "ru" ]]; then
  echo
  echo "==> Пересборка готова"
  echo "    AppImage: dist/GoClaw-Lite-x86_64.AppImage"
  echo "    Tag stamp: $TAG"
  echo "    Upstream: $FULL"
  echo
  echo "Следующий шаг (релиз для update.sh пользователей):"
  echo "  gh release create $TAG dist/GoClaw-Lite-x86_64.AppImage --title \"GoClaw Lite $TAG\""
else
  echo
  echo "==> Rebuild complete"
  echo "    AppImage: dist/GoClaw-Lite-x86_64.AppImage"
  echo "    Tag stamp: $TAG"
  echo "    Upstream: $FULL"
  echo
  echo "Next step (publish so update.sh can ship it):"
  echo "  gh release create $TAG dist/GoClaw-Lite-x86_64.AppImage --title \"GoClaw Lite $TAG\""
fi
