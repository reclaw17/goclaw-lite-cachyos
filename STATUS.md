# STATUS

**Date:** 2026-07-23

## Fixed
- CachyOS/Arch: build uses `-tags sqliteonly,webkit2_41` when `webkit2gtk-4.1` is present
- Do **not** require package `webkit2gtk` (4.0) — removed from official repos
- `install-deps-cachyos.sh` installs only `webkit2gtk-4.1`

## User next step
```bash
cd goclaw-lite-cachyos
git pull
bash scripts/build-lite.sh
bash scripts/package-appimage.sh
```
