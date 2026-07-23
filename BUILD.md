# Build guide

## English

### Language

`setup-all.sh` and `build.sh` ask for UI language at start.

- **Default: English (1)**
- Russian: choose `2` or set `LANG_UI=ru`

```bash
LANG_UI=en bash setup-all.sh   # default
LANG_UI=ru bash setup-all.sh
```

`LANG_UI` is exported to `scripts/*` so dependency/build messages match.

### One-shot

```bash
bash setup-all.sh
```

### Interactive

```bash
bash build.sh
```

### Steps

```bash
bash scripts/install-deps-cachyos.sh
bash scripts/clone-upstream.sh
bash scripts/build-lite.sh
bash scripts/package-appimage.sh
```

Upstream GoClaw is cloned into `upstream/` at build time.

WebKit on CachyOS/Arch: [docs/FIX-WEBKIT.md](docs/FIX-WEBKIT.md)

---

## Русский

Язык по умолчанию — **английский**. Русский:

```bash
LANG_UI=ru bash setup-all.sh
```

Или пункт **2** в меню при запуске.
