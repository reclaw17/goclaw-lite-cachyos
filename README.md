<p align="center">
  <img src="https://raw.githubusercontent.com/nextlevelbuilder/goclaw/dev/_statics/logo.png" alt="GoClaw" width="96" onerror="this.style.display='none'">
</p>

<h1 align="center">goclaw-lite-cachyos</h1>

<p align="center">
  <strong>Portable GoClaw Lite for <em>Arch Linux</em> & <em>CachyOS</em></strong><br/>
  Unofficial AppImage of <a href="https://github.com/nextlevelbuilder/goclaw">GoClaw Lite</a> · SQLite · no PostgreSQL · USB-friendly
</p>

<p align="center">
  <a href="https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.1.0-cachyos"><img alt="Release" src="https://img.shields.io/badge/release-v0.1.0--cachyos-blue?style=flat-square"></a>
  <a href="https://github.com/nextlevelbuilder/goclaw"><img alt="Upstream" src="https://img.shields.io/badge/upstream-nextlevelbuilder%2Fgoclaw-orange?style=flat-square"></a>
  <img alt="Portable" src="https://img.shields.io/badge/portable-AppImage-brightgreen?style=flat-square">
  <img alt="Arch" src="https://img.shields.io/badge/Arch-supported-1793D1?style=flat-square&logo=archlinux&logoColor=white">
  <img alt="CachyOS" src="https://img.shields.io/badge/CachyOS-supported-green?style=flat-square">
  <a href="#russian"><img alt="RU" src="https://img.shields.io/badge/lang-EN%20%7C%20RU-lightgrey?style=flat-square"></a>
</p>

---

## English

### What is this?

A **portable** build of **[GoClaw Lite](https://github.com/nextlevelbuilder/goclaw)** made for **Arch Linux** and **CachyOS**.

One AppImage file → copy to a USB stick or any folder → run. No PostgreSQL, no Docker, no system-wide install required for the app itself.

| | Upstream Standard | **This project (portable Lite)** |
|--|-------------------|----------------------------------|
| Target OS | multi-platform server | **Arch / CachyOS** (Linux x86_64) |
| Database | PostgreSQL | **SQLite** |
| Form | Server / gateway | **Desktop AppImage** |
| Portability | needs infra | **single file, USB-ready** |

- **Upstream:** [nextlevelbuilder/goclaw](https://github.com/nextlevelbuilder/goclaw) (Lite / `sqliteonly`)
- **This repo:** community packaging + build scripts for Arch & CachyOS
- **Not affiliated** with upstream authors

### Why Arch & CachyOS?

Official GoClaw Lite focuses on macOS / Windows desktop builds.  
This project fills the gap for **Arch-based systems**:

- builds with `webkit2gtk-4.1` + tag `webkit2_41`
- scripts tuned for `pacman` / CachyOS
- ships a ready **AppImage** for portable use

### Quick start (portable)

1. Download from **[Releases · v0.1.0-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.1.0-cachyos)**
2. Get `GoClaw-Lite-x86_64.AppImage`
3. Run (or put on a USB stick first):

```bash
chmod +x GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage
```

If FUSE is missing:

```bash
./GoClaw-Lite-x86_64.AppImage --appimage-extract-and-run
```

Direct download:

```bash
curl -L --fail -o GoClaw-Lite-x86_64.AppImage \
  https://github.com/reclaw17/goclaw-lite-cachyos/releases/download/v0.1.0-cachyos/GoClaw-Lite-x86_64.AppImage
chmod +x GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage
```

### Build on Arch / CachyOS

Guide: **[START-HERE.md](START-HERE.md)** · details: **[BUILD.md](BUILD.md)**

```bash
git clone https://github.com/reclaw17/goclaw-lite-cachyos.git
cd goclaw-lite-cachyos
bash setup-all.sh
```

**Language at startup** (default **English**):

```text
  1) English   (default)
  2) Русский
```

```bash
LANG_UI=en bash setup-all.sh   # English (default)
LANG_UI=ru bash setup-all.sh   # Russian script messages
```

Result:

```text
dist/GoClaw-Lite-x86_64.AppImage   ← portable binary for Arch / CachyOS
```

WebKit note: use `webkit2gtk-4.1` + `webkit2_41` — [docs/FIX-WEBKIT.md](docs/FIX-WEBKIT.md).

### Portability notes

- **Yes:** one AppImage, no install step, works from USB/folder
- **Host still needs:** common GTK/WebKit libraries (present on normal Arch/CachyOS installs)
- **Best tested on:** CachyOS and Arch Linux x86_64
- **Not:** a Windows/macOS portable (use upstream Lite there)

### FAQ

**Is this official GoClaw?** No — community portable packaging of official **Lite** sources.  
**PostgreSQL?** Not required.  
**Only Arch/CachyOS?** Built and tested for them; other Linux x86_64 may work if libraries match.  
**USB?** Copy the single AppImage.  
**FUSE error?** `--appimage-extract-and-run`.  
**Local models?** Point the wizard to an OpenAI-compatible URL (e.g. Fabric).

### Credits

- **GoClaw** — [nextlevelbuilder/goclaw](https://github.com/nextlevelbuilder/goclaw)
- **Portable Arch/CachyOS packaging** — this repository

Please support upstream: https://github.com/nextlevelbuilder/goclaw

### License

Scripts: MIT · GoClaw application: upstream license

---

<a id="russian"></a>
## Russian

### Что это?

**Портативная** сборка **[GoClaw Lite](https://github.com/nextlevelbuilder/goclaw)** для **Arch Linux** и **CachyOS**.

Один файл AppImage → на флешку или в папку → запуск. Без PostgreSQL, без Docker, без установки в систему.

| | Standard (upstream) | **Эта версия (portable Lite)** |
|--|---------------------|--------------------------------|
| Система | сервер / multi-platform | **Arch / CachyOS** |
| База | PostgreSQL | **SQLite** |
| Формат | сервер | **Desktop AppImage** |
| Портативность | нужна инфраструктура | **один файл, с флешки** |

### Быстрый запуск

1. Релиз: **[v0.1.0-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.1.0-cachyos)**
2. Скачай `GoClaw-Lite-x86_64.AppImage`
3. Запусти (можно с флешки):

```bash
chmod +x GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage
```

### Сборка на Arch / CachyOS

```bash
git clone https://github.com/reclaw17/goclaw-lite-cachyos.git
cd goclaw-lite-cachyos
bash setup-all.sh
```

Язык сообщений скриптов по умолчанию — **английский**:

```bash
LANG_UI=ru bash setup-all.sh   # русский
```

Итог: `dist/GoClaw-Lite-x86_64.AppImage` — портативный файл под Arch и CachyOS.

Подробнее: [START-HERE.md](START-HERE.md), [BUILD.md](BUILD.md).
