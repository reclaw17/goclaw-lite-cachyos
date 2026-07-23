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

On start the script asks for **language** (default **1 = English**):

```text
  1) English   (default)
  2) Русский
```

Non-interactive:

```bash
LANG_UI=en bash setup-all.sh   # English (default)
LANG_UI=ru bash setup-all.sh   # Russian
```

Interactive build (optional AppImage step):

```bash
bash build.sh
```

Result: `dist/GoClaw-Lite-x86_64.AppImage`

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

При запуске будет выбор языка (**по умолчанию English**). Для русского:

```bash
LANG_UI=ru bash setup-all.sh
# или выбери пункт 2 в меню
```

Результат: `dist/GoClaw-Lite-x86_64.AppImage`
