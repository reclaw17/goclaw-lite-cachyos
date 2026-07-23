#!/usr/bin/env bash
# Stamp dist/ with release tag after packaging (used by humans or CI)
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TAG="${1:-${VERSION_TAG:-dev-local}}"
mkdir -p "$ROOT/dist"
echo "$TAG" > "$ROOT/dist/.goclaw-lite-version"
echo "==> Wrote $ROOT/dist/.goclaw-lite-version ($TAG)"
