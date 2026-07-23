#!/usr/bin/env bash
# Build GoClaw Lite (sqliteonly) via Wails on Linux
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
UPSTREAM="$ROOT/upstream"
DESKTOP="$UPSTREAM/ui/desktop"
VERSION="${VERSION:-dev-cachyos}"

export PATH="$PATH:$(go env GOPATH 2>/dev/null)/bin"

echo "==> Сборка GoClaw Lite (sqliteonly)"
echo "==> Version: $VERSION"

if [[ ! -d "$DESKTOP" ]]; then
  echo "==> Нет upstream. Сначала: bash scripts/clone-upstream.sh"
  exit 1
fi

if ! command -v wails >/dev/null 2>&1; then
  echo "==> Нет wails. Сначала: bash scripts/install-deps-cachyos.sh"
  exit 1
fi

cd "$DESKTOP"

if [[ -f package.json ]]; then
  echo "==> Frontend deps (pnpm/npm)"
  if command -v pnpm >/dev/null 2>&1; then
    pnpm install || npm install
  else
    npm install
  fi
fi

echo "==> wails build -tags sqliteonly"
# Prefer make target if present, else direct wails
if grep -q 'desktop-build:' "$UPSTREAM/Makefile" 2>/dev/null; then
  (cd "$UPSTREAM" && make desktop-build VERSION="$VERSION")
else
  wails build -tags sqliteonly -ldflags="-s -w -X github.com/nextlevelbuilder/goclaw/cmd.Version=$VERSION"
fi

echo
echo "==> Ищем результат сборки..."
find "$DESKTOP/build" -maxdepth 4 -type f 2>/dev/null | head -n 50 || true

echo
echo "==> Готово (если ошибок не было)."
echo "    Проверь: upstream/ui/desktop/build/bin/"
