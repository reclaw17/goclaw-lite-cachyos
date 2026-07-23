#!/usr/bin/env bash
# Build GoClaw Lite (sqliteonly) via Wails on Linux
# CachyOS/Arch: webkit2gtk-4.1 → -tags webkit2_41
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
UPSTREAM="$ROOT/upstream"
DESKTOP="$UPSTREAM/ui/desktop"
FRONTEND="$DESKTOP/frontend"
VERSION="${VERSION:-dev-cachyos}"
LANG_UI="${LANG_UI:-en}"

export PATH="$PATH:$(go env GOPATH 2>/dev/null)/bin"

TAGS="sqliteonly"
if pkg-config --exists webkit2gtk-4.1; then
  TAGS="sqliteonly,webkit2_41"
  echo "==> WebKit: 4.1 (tag webkit2_41)"
elif pkg-config --exists webkit2gtk-4.0; then
  TAGS="sqliteonly"
  echo "==> WebKit: 4.0"
else
  if [[ "$LANG_UI" == "ru" ]]; then
    echo "==> ERROR: нет webkit2gtk-4.1 и webkit2gtk-4.0"
    echo "    sudo pacman -S --needed webkit2gtk-4.1 gtk3"
  else
    echo "==> ERROR: neither webkit2gtk-4.1 nor webkit2gtk-4.0 found"
    echo "    sudo pacman -S --needed webkit2gtk-4.1 gtk3"
  fi
  exit 1
fi

if [[ "$LANG_UI" == "ru" ]]; then
  echo "==> Сборка GoClaw Lite"
  NO_DESKTOP="==> Нет upstream/ui/desktop. Сначала: bash scripts/clone-upstream.sh"
  NO_WAILS="==> Нет wails в PATH"
  FAIL="==> wails build failed"
  NO_EXE="==> ERROR: executable not found"
  OK="==> Build OK"
else
  echo "==> Building GoClaw Lite"
  NO_DESKTOP="==> Missing upstream/ui/desktop. Run: bash scripts/clone-upstream.sh"
  NO_WAILS="==> wails not in PATH"
  FAIL="==> wails build failed"
  NO_EXE="==> ERROR: executable not found"
  OK="==> Build OK"
fi

echo "==> Version: $VERSION"
echo "==> Tags: $TAGS"
echo "==> Desktop: $DESKTOP"

if [[ ! -d "$DESKTOP" ]]; then
  echo "$NO_DESKTOP"
  exit 1
fi

if ! command -v wails >/dev/null 2>&1; then
  echo "$NO_WAILS"
  exit 1
fi

if [[ -f "$FRONTEND/package.json" ]]; then
  echo "==> Frontend deps"
  if command -v pnpm >/dev/null 2>&1; then
    (cd "$FRONTEND" && pnpm install --frozen-lockfile || pnpm install)
  else
    (cd "$FRONTEND" && npm install)
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
  echo "$FAIL ($status)"
  exit "$status"
fi

echo
echo "==> Artifacts:"
find "$DESKTOP/build" -maxdepth 5 -type f 2>/dev/null | head -n 80 || true

if ! find "$DESKTOP/build" -type f -executable 2>/dev/null | head -n 1 | grep -q .; then
  echo "$NO_EXE"
  exit 1
fi

echo "$OK"
