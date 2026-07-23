<p align="center">
  <img src="https://raw.githubusercontent.com/nextlevelbuilder/goclaw/dev/_statics/logo.png" alt="GoClaw" width="96" onerror="this.style.display='none'">
</p>

<h1 align="center">goclaw-lite-cachyos</h1>

<p align="center">
  <strong>Unofficial Linux AppImage build of <a href="https://github.com/nextlevelbuilder/goclaw">GoClaw Lite</a></strong><br/>
  SQLite desktop edition · no PostgreSQL · built for CachyOS / Arch
</p>

<p align="center">
  <a href="https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.1.0-cachyos"><img alt="Release" src="https://img.shields.io/badge/release-v0.1.0--cachyos-blue?style=flat-square"></a>
  <a href="https://github.com/nextlevelbuilder/goclaw"><img alt="Upstream" src="https://img.shields.io/badge/upstream-nextlevelbuilder%2Fgoclaw-orange?style=flat-square"></a>
  <a href="START-HERE.md"><img alt="Start" src="https://img.shields.io/badge/guide-START--HERE-success?style=flat-square"></a>
  <a href="#russian"><img alt="RU" src="https://img.shields.io/badge/lang-EN%20%7C%20RU-lightgrey?style=flat-square"></a>
  <img alt="Platform" src="https://img.shields.io/badge/platform-Linux%20x86__64-green?style=flat-square">
</p>

---

## English

### What is this?

This repository packages **[GoClaw Lite](https://github.com/nextlevelbuilder/goclaw)** (the official desktop / SQLite edition) as a **portable Linux AppImage**.

- **Upstream:** [nextlevelbuilder/goclaw](https://github.com/nextlevelbuilder/goclaw)
- **Edition:** Lite (`sqliteonly`) — SQLite, no PostgreSQL
- **Target:** CachyOS / Arch (and similar x86_64 Linux)
- **Not affiliated** with upstream — community packaging only

| | Standard | Lite (this build) |
|--|----------|-------------------|
| Database | PostgreSQL | **SQLite** |
| Form | Server | **Desktop (Wails)** |

### Quick start (download)

1. **[v0.1.0-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.1.0-cachyos)**
2. Download `GoClaw-Lite-x86_64.AppImage`
3. Run:

```bash
chmod +x GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage
```

FUSE: `./GoClaw-Lite-x86_64.AppImage --appimage-extract-and-run`

### Build (CachyOS / Arch)

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
LANG_UI=ru bash setup-all.sh   # Russian UI messages
bash build.sh                  # interactive (optional AppImage step)
```

Output: `dist/GoClaw-Lite-x86_64.AppImage`

WebKit on CachyOS: `webkit2gtk-4.1` + tag `webkit2_41` — see [docs/FIX-WEBKIT.md](docs/FIX-WEBKIT.md).

### FAQ

**Official?** No — community packaging of official Lite sources.  
**PostgreSQL?** Not required.  
**USB?** Copy the AppImage.  
**FUSE error?** Use `--appimage-extract-and-run`.  
**Local models?** Point the wizard to an OpenAI-compatible URL (e.g. Fabric).

### Credits

[nextlevelbuilder/goclaw](https://github.com/nextlevelbuilder/goclaw) · packaging: this repo

### License

Scripts: MIT · GoClaw app: upstream license

---

## Russian

Неофициальная сборка **GoClaw Lite** (SQLite) в AppImage для CachyOS/Arch.

**Скачать:** [v0.1.0-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.1.0-cachyos)

**Сборка** (язык UI по умолчанию — **английский**):

```bash
bash setup-all.sh
# русский интерфейс скриптов:
LANG_UI=ru bash setup-all.sh
```

Подробнее: [START-HERE.md](START-HERE.md), [BUILD.md](BUILD.md).
