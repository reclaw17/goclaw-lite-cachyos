#!/usr/bin/env bash
# Compatibility wrapper → setup-all.sh
echo "Note: use setup-all.sh (English-first name)."
exec bash "$(cd "$(dirname "$0")" && pwd)/setup-all.sh" "$@"
