#!/usr/bin/env bash
# Build GoClaw Lite (sqliteonly) via Wails on Linux
# CachyOS/Arch modern: webkit2gtk-4.1 → need tag webkit2_41
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
UPSTREAM="$ROOT/upstream"
DESKTOP="$UPSTREAM/ui/desktop"
FRONTEND="$DESKTOP/frontend"
VERSION="${VERSION:-dev-cachyos}"

export PATH="$PATH:$(go env GOPATH 2>/dev/null)/bin"

# Detect WebKit ABI
TAGS="sqliteonly"
if pkg-config --exists webkit2gtk-4.1; then
  TAGS="sqliteonly,webkit2_41"
  echo "==> WebKit: 4.1 (tag webkit2_41)"
elif pkg-config --exists webkit2gtk-4.0; then
  TAGS="sqliteonly"
  echo "==> WebKit: 4.0"
else
  echo "==> ERROR: нет webkit2gtk-4.1 и webkit2gtk-4.0"
  echo "    sudo pacman -S --needed webkit2gtk-4.1 gtk3"
  exit 1
fi

echo "==> Сборка GoClaw Lite"
echo "==> Version: $VERSION"
echo "==> Tags: $TAGS"
echo "==> Desktop: $DESKTOP"

if [[ ! -d "$DESKTOP" ]]; then
  echo "==> Нет upstream/ui/desktop. Сначала: bash scripts/clone-upstream.sh"
  exit 1
fi

if ! command -v wails >/dev/null 2>&1; then
  echo "==> Нет wails в PATH"
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
  echo "==> wails build failed ($status)"
  exit "$status"
fi

echo
echo "==> Artifacts:"
find "$DESKTOP/build" -maxdepth 5 -type f 2>/dev/null | head -n 80 || true

if ! find "$DESKTOP/build" -type f -executable 2>/dev/null | head -n 1 | grep -q .; then
  echo "==> ERROR: executable not found"
  exit 1
fi

echo "==> Build OK"
