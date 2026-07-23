# Status — goclaw-lite-cachyos

**Created:** 2026-07-23  
**Goal:** Build GoClaw Lite (sqliteonly) for CachyOS / Arch Linux

## Current

| Item | Status |
|------|--------|
| Repo created | Done |
| Build docs | Done |
| Deps install script | Done |
| Upstream clone script | Done |
| Build script | Done |
| First successful Linux Lite binary | Pending |
| Portable USB packaging | Pending |
| Link into goclaw-setup-my-pc | Pending |

## Upstream notes

- Lite = `-tags sqliteonly`
- Desktop UI: Wails (`ui/desktop`)
- Official desktop CI: macOS + Windows
- Linux: build manually via Wails

## Next action

On a CachyOS machine run:

```bash
bash scripts/install-deps-cachyos.sh
bash scripts/clone-upstream.sh
bash scripts/build-lite.sh
```

Then report the build log.
