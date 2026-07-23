#!/usr/bin/env bash
# Compatibility wrapper → build.sh
echo "Note: use build.sh (English-first name)."
exec bash "$(cd "$(dirname "$0")" && pwd)/build.sh" "$@"
