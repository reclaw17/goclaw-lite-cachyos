#!/usr/bin/env bash
# Wrapper: run repo-root update.sh
exec bash "$(cd "$(dirname "$0")/.." && pwd)/update.sh" "$@"
