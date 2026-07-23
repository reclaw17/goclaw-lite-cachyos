#!/usr/bin/env bash
# Clone official GoClaw upstream for Lite build
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
UPSTREAM_DIR="$ROOT/upstream"
REPO_URL="https://github.com/nextlevelbuilder/goclaw.git"
BRANCH="${GOCLAW_BRANCH:-dev}"
LANG_UI="${LANG_UI:-en}"

if [[ "$LANG_UI" == "ru" ]]; then
  echo "==> Upstream: $REPO_URL"
  echo "==> Ветка:   $BRANCH"
  echo "==> Папка:   $UPSTREAM_DIR"
  UPD="==> Уже есть, обновляю..."
  READY="==> Готово. Дальше: bash scripts/build-lite.sh"
else
  echo "==> Upstream: $REPO_URL"
  echo "==> Branch:   $BRANCH"
  echo "==> Dir:      $UPSTREAM_DIR"
  UPD="==> Already cloned, updating..."
  READY="==> Done. Next: bash scripts/build-lite.sh"
fi

if [[ -d "$UPSTREAM_DIR/.git" ]]; then
  echo "$UPD"
  git -C "$UPSTREAM_DIR" fetch --all --tags
  git -C "$UPSTREAM_DIR" checkout "$BRANCH"
  git -C "$UPSTREAM_DIR" pull --ff-only origin "$BRANCH" || true
else
  git clone --branch "$BRANCH" --single-branch "$REPO_URL" "$UPSTREAM_DIR"
fi

echo "==> Commit: $(git -C "$UPSTREAM_DIR" rev-parse --short HEAD)"
echo "$READY"
