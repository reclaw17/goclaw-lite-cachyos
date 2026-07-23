# Start here

## English

### Portable GoClaw Lite for Arch & CachyOS

This project gives you a **portable AppImage** of **GoClaw Lite** (official SQLite desktop edition) aimed at **Arch Linux** and **CachyOS**.

Upstream app: [nextlevelbuilder/goclaw](https://github.com/nextlevelbuilder/goclaw)  
This repo: packaging only (not an official release).

### Option A — Download portable AppImage

1. Open [Releases → v0.1.0-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.1.0-cachyos)
2. Download **GoClaw-Lite-x86_64.AppImage**
3. Run:

```bash
chmod +x GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage
```

Copy the same file to a **USB stick** and run it on another Arch/CachyOS PC.

If FUSE fails:

```bash
./GoClaw-Lite-x86_64.AppImage --appimage-extract-and-run
```

### Option B — Build on Arch / CachyOS

```bash
git clone https://github.com/reclaw17/goclaw-lite-cachyos.git
cd goclaw-lite-cachyos
bash setup-all.sh
```

Language prompt (**default = English**):

```text
  1) English   (default)
  2) Русский
```

```bash
LANG_UI=en bash setup-all.sh   # English (default)
LANG_UI=ru bash setup-all.sh   # Russian messages
bash build.sh                  # interactive (optional AppImage step)
```

Result: `dist/GoClaw-Lite-x86_64.AppImage` — portable for Arch/CachyOS.

---

## Русский

### Портативный GoClaw Lite для Arch и CachyOS

Один **AppImage** официального **GoClaw Lite** (SQLite), заточенный под **Arch Linux** и **CachyOS**.

### Вариант A — скачать

1. [Releases → v0.1.0-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.1.0-cachyos)
2. **GoClaw-Lite-x86_64.AppImage**
3. Запуск:

```bash
chmod +x GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage
```

Можно положить на **флешку** и запускать на других Arch/CachyOS.

### Вариант B — собрать

```bash
git clone https://github.com/reclaw17/goclaw-lite-cachyos.git
cd goclaw-lite-cachyos
bash setup-all.sh
```

Язык скриптов **по умолчанию English**. Русский:

```bash
LANG_UI=ru bash setup-all.sh
```

Результат: `dist/GoClaw-Lite-x86_64.AppImage`.
