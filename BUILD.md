# Build guide

## English

### Requirements (CachyOS / Arch)

- `go`, `nodejs`, `npm` / `pnpm`
- `gtk3`, `webkit2gtk-4.1`, `pkgconf`, `gcc`
- Wails CLI: `go install github.com/wailsapp/wails/v2/cmd/wails@latest`

Or:

```bash
bash scripts/install-deps-cachyos.sh
```

### Steps

```bash
bash scripts/clone-upstream.sh   # clones nextlevelbuilder/goclaw (dev)
bash scripts/build-lite.sh       # wails build -tags sqliteonly,webkit2_41
bash scripts/package-appimage.sh # → dist/GoClaw-Lite-x86_64.AppImage
```

One-shot:

```bash
bash всё-сразу.sh
```

Upstream source is not vendored in git; it is cloned into `upstream/` at build time.

---

## Русский

```bash
bash scripts/install-deps-cachyos.sh
bash scripts/clone-upstream.sh
bash scripts/build-lite.sh
bash scripts/package-appimage.sh
```

Или: `bash всё-сразу.sh`

Исходники GoClaw качаются в `upstream/` при сборке (официальный репозиторий).
