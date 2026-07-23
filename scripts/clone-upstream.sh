#!/usr/bin/env bash
# Clone official GoClaw upstream for Lite build
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
UPSTREAM_DIR="$ROOT/upstream"
REPO_URL="https://github.com/nextlevelbuilder/goclaw.git"
BRANCH="${GOCLAW_BRANCH:-dev}"

echo "==> Upstream: $REPO_URL"
echo "==> Branch:   $BRANCH"
echo "==> Dir:      $UPSTREAM_DIR"

if [[ -d "$UPSTREAM_DIR/.git" ]]; then
  echo "==> Уже склонировано, обновляю..."
  git -C "$UPSTREAM_DIR" fetch --all --tags
  git -C "$UPSTREAM_DIR" checkout "$BRANCH"
  git -C "$UPSTREAM_DIR" pull --ff-only origin "$BRANCH" || true
else
  git clone --branch "$BRANCH" --single-branch "$REPO_URL" "$UPSTREAM_DIR"
fi

echo "==> Commit: $(git -C "$UPSTREAM_DIR" rev-parse --short HEAD)"
echo "==> Готово. Дальше:"
echo "    bash scripts/build-lite.sh"
