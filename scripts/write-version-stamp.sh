#!/usr/bin/env bash
# Write version metadata next to AppImage / dist
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TAG="${1:-}"
UPSTREAM_SHA="${2:-}"
UPSTREAM_BRANCH="${3:-dev}"

if [[ -z "$TAG" ]]; then
  echo "Usage: $0 <packaging-tag> [upstream-sha] [upstream-branch]"
  exit 1
fi

mkdir -p "$ROOT/dist"
STAMP_DIR="$ROOT/dist"

if [[ -z "$UPSTREAM_SHA" && -d "$ROOT/upstream/.git" ]]; then
  UPSTREAM_SHA="$(git -C "$ROOT/upstream" rev-parse HEAD 2>/dev/null || true)"
  UPSTREAM_BRANCH="$(git -C "$ROOT/upstream" rev-parse --abbrev-ref HEAD 2>/dev/null || echo dev)"
fi

DATE_UTC="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

echo "$TAG" > "$STAMP_DIR/.goclaw-lite-version"

cat > "$STAMP_DIR/VERSION.json" <<EOF
{
  "packaging_tag": "$TAG",
  "upstream_repo": "https://github.com/nextlevelbuilder/goclaw",
  "upstream_branch": "$UPSTREAM_BRANCH",
  "upstream_sha": "$UPSTREAM_SHA",
  "built_at_utc": "$DATE_UTC",
  "asset": "GoClaw-Lite-x86_64.AppImage"
}
EOF

echo "==> Stamp written:"
echo "    $STAMP_DIR/.goclaw-lite-version  ($TAG)"
echo "    $STAMP_DIR/VERSION.json"
if [[ -n "$UPSTREAM_SHA" ]]; then
  echo "    upstream: $UPSTREAM_SHA ($UPSTREAM_BRANCH)"
fi
