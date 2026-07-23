# Build — portable GoClaw Lite (Arch / CachyOS)

## Goal

Produce a **portable AppImage** of **GoClaw Lite** optimized for **Arch Linux** and **CachyOS**.

```text
dist/GoClaw-Lite-x86_64.AppImage
```

## One command

```bash
bash setup-all.sh
```

Language (**default English**):

```bash
LANG_UI=en bash setup-all.sh
LANG_UI=ru bash setup-all.sh
```

## Steps

1. `scripts/install-deps-cachyos.sh` — pacman deps (`webkit2gtk-4.1`, gtk3, go, pnpm, wails…)
2. `scripts/clone-upstream.sh` — official [goclaw](https://github.com/nextlevelbuilder/goclaw) sources
3. `scripts/build-lite.sh` — `wails build -tags sqliteonly,webkit2_41`
4. `scripts/package-appimage.sh` — portable AppImage

## Notes

- No PostgreSQL
- WebKit 4.1 only on modern Arch/CachyOS → tag `webkit2_41` (see [docs/FIX-WEBKIT.md](docs/FIX-WEBKIT.md))
- AppImage is the portable artifact for USB / other machines
