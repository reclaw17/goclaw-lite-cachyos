# Start here

## English

### Option A — Download AppImage

1. Open [Releases → v0.1.0-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.1.0-cachyos)
2. Download **GoClaw-Lite-x86_64.AppImage**
3. Run:

```bash
chmod +x GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage
```

This is **GoClaw Lite** from upstream [nextlevelbuilder/goclaw](https://github.com/nextlevelbuilder/goclaw) (SQLite desktop edition), packaged for Linux.

### Option B — Build on CachyOS / Arch

```bash
git clone https://github.com/reclaw17/goclaw-lite-cachyos.git
cd goclaw-lite-cachyos
bash setup-all.sh
```

Result: `dist/GoClaw-Lite-x86_64.AppImage`

Interactive build (optional AppImage step):

```bash
bash build.sh
```

---

## Русский

### Вариант A — скачать AppImage

1. [Releases → v0.1.0-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.1.0-cachyos)
2. Скачай **GoClaw-Lite-x86_64.AppImage**
3. Запусти:

```bash
chmod +x GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage
```

### Вариант B — собрать на CachyOS

```bash
git clone https://github.com/reclaw17/goclaw-lite-cachyos.git
cd goclaw-lite-cachyos
bash setup-all.sh
```

Результат: `dist/GoClaw-Lite-x86_64.AppImage`
