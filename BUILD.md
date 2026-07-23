# Build guide

## English

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

Upstream GoClaw is cloned into `upstream/` at build time (not vendored in git).

WebKit on CachyOS/Arch: [docs/FIX-WEBKIT.md](docs/FIX-WEBKIT.md)

---

## Русский

```bash
bash setup-all.sh
# или
bash build.sh
```
