#!/usr/bin/env bash
# Build GoClaw Lite (sqliteonly) via Wails on Linux
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
UPSTREAM="$ROOT/upstream"
DESKTOP="$UPSTREAM/ui/desktop"
FRONTEND="$DESKTOP/frontend"
VERSION="${VERSION:-dev-cachyos}"

export PATH="$PATH:$(go env GOPATH 2>/dev/null)/bin"

echo "==> Сборка GoClaw Lite (sqliteonly)"
echo "==> Version: $VERSION"
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

# Frontend deps live under ui/desktop/frontend
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
echo "==> wails build -tags sqliteonly"
set +e
wails build -tags sqliteonly \
  -ldflags "-s -w -X github.com/nextlevelbuilder/goclaw/cmd.Version=${VERSION}"
status=$?
set -e

if [[ "$status" -ne 0 ]]; then
  echo "==> wails build failed ($status). Retry via make desktop-build..."
  if grep -q 'desktop-build:' "$UPSTREAM/Makefile" 2>/dev/null; then
    (cd "$UPSTREAM" && make desktop-build VERSION="$VERSION")
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
