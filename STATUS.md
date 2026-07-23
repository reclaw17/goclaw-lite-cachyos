# STATUS

**Date:** 2026-07-23

## Decision

Primary path: **build GoClaw Lite on CachyOS → package AppImage → run from USB**

CLI harness / console coding agents = fallback.

## Done

- Repo scaffold
- install-deps / clone-upstream / build-lite scripts
- `scripts/package-appimage.sh`
- docs: APPIMAGE, CLI-FALLBACK

## Next

1. User runs build on CachyOS
2. Fix build errors if any
3. Produce first AppImage
4. Test AppImage on clean Linux host / USB
