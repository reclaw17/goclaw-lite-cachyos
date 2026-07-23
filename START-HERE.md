# Start here

Portable **GoClaw Lite** for **Arch Linux** and **CachyOS** (AppImage, SQLite).

## English

### Option A — Portable download

1. [Releases → v0.1.0-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.1.0-cachyos)
2. Download **GoClaw-Lite-x86_64.AppImage**
3. Run:

```bash
chmod +x GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage
```

### Update later

```bash
cd goclaw-lite-cachyos   # or the folder where update.sh lives
bash update.sh
```

See [docs/UPDATE.md](docs/UPDATE.md).

### Option B — Build on Arch / CachyOS

```bash
git clone https://github.com/reclaw17/goclaw-lite-cachyos.git
cd goclaw-lite-cachyos
bash setup-all.sh
```

Language menu default: **English**. Russian: choose `2` or `LANG_UI=ru`.

---

## Русский

### Скачать

[Релиз](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.1.0-cachyos) → `GoClaw-Lite-x86_64.AppImage`

### Обновить

```bash
bash update.sh
LANG_UI=ru bash update.sh
```

### Собрать

```bash
bash setup-all.sh
```
