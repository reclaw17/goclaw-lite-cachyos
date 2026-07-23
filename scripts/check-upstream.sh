#!/usr/bin/env bash
# Compare last-built upstream SHA with remote nextlevelbuilder/goclaw
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
UPSTREAM_REPO="${UPSTREAM_REPO:-nextlevelbuilder/goclaw}"
BRANCH="${GOCLAW_BRANCH:-dev}"
LANG_UI="${LANG_UI:-en}"

API="https://api.github.com/repos/${UPSTREAM_REPO}/commits/${BRANCH}"
LOCAL_JSON="$ROOT/dist/VERSION.json"
LOCAL_SHA=""

if [[ -f "$LOCAL_JSON" ]]; then
  LOCAL_SHA="$(python3 -c 'import json,sys; print(json.load(open(sys.argv[1])).get("upstream_sha") or "")' "$LOCAL_JSON" 2>/dev/null || true)"
fi
if [[ -z "$LOCAL_SHA" && -d "$ROOT/upstream/.git" ]]; then
  LOCAL_SHA="$(git -C "$ROOT/upstream" rev-parse HEAD 2>/dev/null || true)"
fi

TMP="$(mktemp)"
trap 'rm -f "$TMP"' EXIT

if ! curl -fsSL -H "Accept: application/vnd.github+json" -H "User-Agent: goclaw-lite-upstream-check" \
  "$API" -o "$TMP"; then
  echo "ERROR: cannot fetch upstream $UPSTREAM_REPO@$BRANCH"
  exit 1
fi

REMOTE_SHA="$(python3 -c 'import json,sys; print(json.load(open(sys.argv[1])).get("sha") or "")' "$TMP")"
REMOTE_DATE="$(python3 -c 'import json,sys; c=json.load(open(sys.argv[1])); print((c.get("commit") or {}).get("committer",{}).get("date") or "")' "$TMP")"

if [[ -z "$REMOTE_SHA" ]]; then
  echo "ERROR: empty upstream SHA"
  exit 1
fi

if [[ "$LANG_UI" == "ru" ]]; then
  echo "==> Upstream: $UPSTREAM_REPO ($BRANCH)"
  echo "==> Удалённый commit:  $REMOTE_SHA"
  echo "==> Дата:              $REMOTE_DATE"
  echo "==> Локальный build:   ${LOCAL_SHA:-нет}"
else
  echo "==> Upstream: $UPSTREAM_REPO ($BRANCH)"
  echo "==> Remote commit:  $REMOTE_SHA"
  echo "==> Date:           $REMOTE_DATE"
  echo "==> Local build:    ${LOCAL_SHA:-none}"
fi

# Write status for CI / tooling
mkdir -p "$ROOT/dist"
cat > "$ROOT/dist/upstream-status.json" <<EOF
{
  "upstream_repo": "$UPSTREAM_REPO",
  "branch": "$BRANCH",
  "remote_sha": "$REMOTE_SHA",
  "remote_date": "$REMOTE_DATE",
  "local_sha": "$LOCAL_SHA",
  "update_available": $([[ -n "$LOCAL_SHA" && "$LOCAL_SHA" != "$REMOTE_SHA" ]] && echo true || echo true)
}
EOF

# Fix update_available logic properly
python3 - <<'PY' "$ROOT/dist/upstream-status.json" "$LOCAL_SHA" "$REMOTE_SHA"
import json,sys
path, local, remote = sys.argv[1], sys.argv[2], sys.argv[3]
with open(path) as f:
    d=json.load(f)
if not local:
    d["update_available"] = True
    d["reason"] = "no_local_build_stamp"
elif local != remote:
    d["update_available"] = True
    d["reason"] = "upstream_ahead"
else:
    d["update_available"] = False
    d["reason"] = "up_to_date"
with open(path,"w") as f:
    json.dump(d,f,indent=2)
    f.write("\n")
print("==> Status:", d["reason"])
print("==> update_available:", d["update_available"])
PY

if [[ -n "$LOCAL_SHA" && "$LOCAL_SHA" == "$REMOTE_SHA" ]]; then
  exit 0   # up to date
fi
exit 2     # update available or no local stamp
