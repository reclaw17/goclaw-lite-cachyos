#!/usr/bin/env bash
# Build GoClaw Lite (sqliteonly) via Wails on Linux
# On modern Arch/CachyOS use webkit2gtk-4.1 → tag webkit2_41
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
UPSTREAM="$ROOT/upstream"
DESKTOP="$UPSTREAM/ui/desktop"
FRONTEND="$DESKTOP/frontend"
VERSION="${VERSION:-dev-cachyos}"

export PATH="$PATH:$(go env GOPATH 2>/dev/null)/bin"

# Detect WebKit ABI
TAGS="sqliteonly"
if pkg-config --exists webkit2gtk-4.1 2>/dev/null; then
  TAGS="sqliteonly,webkit2_41"
  echo "==> WebKit: 4.1 (tag webkit2_41)"
elif pkg-config --exists webkit2gtk-4.0 2>/dev/null; then
  TAGS="sqliteonly"
  echo "==> WebKit: 4.0"
else
  echo "==> ERROR: не найден webkit2gtk-4.1 или webkit2gtk-4.0"
  echo "    Установи: sudo pacman -S webkit2gtk-4.1"
  exit 1
fi

echo "==> Сборка GoClaw Lite"
echo "==> Version: $VERSION"
echo "==> Tags:    $TAGS"
echo "==> Desktop: $DESKTOP"

if [[ ! -d "$DESKTOP" ]]; then
  echo "==> Нет upstream/ui/desktop. Сначала: bash scripts/clone-upstream.sh"
  exit 1
fi

if ! command -v wails >/dev/null 2>&1; then
  echo "==> Нет wails в PATH"
  exit 1
fi

wails version || true

if [[ -f "$FRONTEND/package.json" ]]; then
  echo "==> Frontend deps in $FRONTEND"
  if command -v pnpm >/dev/null 2>&1; then
    (cd "$FRONTEND" && pnpm install --frozen-lockfile || pnpm install)
  else
    (cd "$FRONTEND" && npm install)
  fi
elif [[ -f "$DESKTOP/package.json" ]]; then
  echo "==> Frontend deps in $DESKTOP"
  if command -v pnpm >/dev/null 2>&1; then
    (cd "$DESKTOP" && pnpm install || npm install)
  else
    (cd "$DESKTOP" && npm install)
  fi
fi

cd "$DESKTOP"
echo "==> wails build -tags $TAGS"
set +e
wails build -tags "$TAGS" \
  -ldflags "-s -w -X github.com/nextlevelbuilder/goclaw/cmd.Version=${VERSION}"
status=$?
set -e

if [[ "$status" -ne 0 ]]; then
  echo "==> wails build failed ($status). Retry via make..."
  if grep -q 'desktop-build:' "$UPSTREAM/Makefile" 2>/dev/null; then
    (cd "$UPSTREAM" && make desktop-build VERSION="$VERSION" WAILS_TAGS="$TAGS") || exit "$status"
  else
    exit "$status"
  fi
fi

echo
echo "==> Artifacts under build/:"
find "$DESKTOP/build" -maxdepth 5 -type f 2>/dev/null | head -n 80 || true

if ! find "$DESKTOP/build" -type f -executable 2>/dev/null | head -n 1 | grep -q .; then
  echo "==> ERROR: no executable produced"
  exit 1
fi

echo "==> Build OK"
