#!/usr/bin/env bash
# Compare local upstream pin vs remote nextlevelbuilder/goclaw
# Exit 0 = up to date, 2 = update available, 1 = error
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
UPSTREAM_DIR="${UPSTREAM_DIR:-$ROOT/upstream}"
REPO_URL="${GOCLAW_REPO_URL:-https://github.com/nextlevelbuilder/goclaw.git}"
BRANCH="${GOCLAW_BRANCH:-dev}"
PIN_FILE="$ROOT/dist/.upstream-commit"
LANG_UI="${LANG_UI:-en}"

REMOTE_SHA="$(git ls-remote --heads "$REPO_URL" "refs/heads/$BRANCH" 2>/dev/null | awk '{print $1}')"
if [[ -z "$REMOTE_SHA" ]]; then
  echo "==> ERROR: cannot resolve remote $REPO_URL branch $BRANCH"
  exit 1
fi
REMOTE_SHORT="${REMOTE_SHA:0:8}"

LOCAL_SHA=""
if [[ -d "$UPSTREAM_DIR/.git" ]]; then
  LOCAL_SHA="$(git -C "$UPSTREAM_DIR" rev-parse HEAD 2>/dev/null || true)"
elif [[ -f "$PIN_FILE" ]]; then
  LOCAL_SHA="$(tr -d ' \r\n' < "$PIN_FILE" || true)"
fi
LOCAL_SHORT="${LOCAL_SHA:0:8}"

if [[ "$LANG_UI" == "ru" ]]; then
  echo "==> Upstream: $REPO_URL ($BRANCH)"
  echo "==> Удалённый commit: $REMOTE_SHORT"
  echo "==> Локальный commit:  ${LOCAL_SHORT:-нет}"
else
  echo "==> Upstream: $REPO_URL ($BRANCH)"
  echo "==> Remote commit: $REMOTE_SHORT"
  echo "==> Local commit:  ${LOCAL_SHORT:-none}"
fi

if [[ -n "$LOCAL_SHA" && "$LOCAL_SHA" == "$REMOTE_SHA" ]]; then
  if [[ "$LANG_UI" == "ru" ]]; then
    echo "==> Upstream без изменений"
  else
    echo "==> Upstream is up to date"
  fi
  echo "$REMOTE_SHA"
  exit 0
fi

if [[ "$LANG_UI" == "ru" ]]; then
  echo "==> Доступен новый upstream"
else
  echo "==> Upstream update available"
fi
echo "$REMOTE_SHA"
exit 2
