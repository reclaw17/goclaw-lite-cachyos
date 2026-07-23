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

- **Upstream project:** [nextlevelbuilder/goclaw](https://github.com/nextlevelbuilder/goclaw)
- **Edition:** Lite (`sqliteonly`) — local SQLite, no PostgreSQL
- **Target:** CachyOS / Arch Linux (and similar x86_64 Linux)
- **Not affiliated** with upstream authors — build scripts + community AppImage only

| | GoClaw Standard | GoClaw Lite (this build) |
|--|-----------------|---------------------------|
| Database | PostgreSQL | **SQLite** |
| Form factor | Server / gateway | **Desktop (Wails)** |
| Typical setup | Docker / infra | AppImage / local binary |

### Quick start (download)

1. Open **[v0.1.0-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.1.0-cachyos)**
2. Download `GoClaw-Lite-x86_64.AppImage`
3. Run:

```bash
chmod +x GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage
```

FUSE issues:

```bash
./GoClaw-Lite-x86_64.AppImage --appimage-extract-and-run
```

```bash
curl -L --fail -o GoClaw-Lite-x86_64.AppImage \
  https://github.com/reclaw17/goclaw-lite-cachyos/releases/download/v0.1.0-cachyos/GoClaw-Lite-x86_64.AppImage
chmod +x GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage
```

### Build from source (CachyOS / Arch)

Beginner guide: **[START-HERE.md](START-HERE.md)**

```bash
git clone https://github.com/reclaw17/goclaw-lite-cachyos.git
cd goclaw-lite-cachyos
bash setup-all.sh
```

Interactive variant:

```bash
bash build.sh
```

Step by step:

```bash
bash scripts/install-deps-cachyos.sh
bash scripts/clone-upstream.sh
bash scripts/build-lite.sh
bash scripts/package-appimage.sh
```

Output: `dist/GoClaw-Lite-x86_64.AppImage`

**WebKit:** use `webkit2gtk-4.1` + `-tags sqliteonly,webkit2_41` (scripts detect this).  
See [docs/FIX-WEBKIT.md](docs/FIX-WEBKIT.md).

### FAQ

**Official GoClaw?** No — community packaging of official **Lite** sources. Upstream: [nextlevelbuilder/goclaw](https://github.com/nextlevelbuilder/goclaw).

**Lite or Standard?** **Lite** (SQLite desktop). Not the PostgreSQL server edition.

**Need PostgreSQL / Docker?** **No.**

**USB portable?** Copy the AppImage. Host may still need WebKit/GTK libs.

**`webkit2gtk` package missing?** Normal on modern Arch/CachyOS. Install `webkit2gtk-4.1`, use `webkit2_41` tag.

**FUSE error?** `./GoClaw-Lite-x86_64.AppImage --appimage-extract-and-run`

**Local models?** Point the wizard to an OpenAI-compatible URL (e.g. Fabric `http://127.0.0.1:8080/v1`).

### Credits

- **GoClaw** — [nextlevelbuilder/goclaw](https://github.com/nextlevelbuilder/goclaw)
- Packaging — this repository

### License

- Scripts: MIT
- GoClaw app: upstream license

---

## Russian

### Что это?

Неофициальная сборка **[GoClaw Lite](https://github.com/nextlevelbuilder/goclaw)** (desktop / SQLite) в **AppImage**.

### Быстрый запуск

1. [Релиз v0.1.0-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.1.0-cachyos)
2. Скачай `GoClaw-Lite-x86_64.AppImage`
3. `chmod +x GoClaw-Lite-x86_64.AppImage && ./GoClaw-Lite-x86_64.AppImage`

### Сборка

```bash
git clone https://github.com/reclaw17/goclaw-lite-cachyos.git
cd goclaw-lite-cachyos
bash setup-all.sh
```

Гайд: [START-HERE.md](START-HERE.md)

Нужен `webkit2gtk-4.1` (пакета `webkit2gtk` 4.0 нет). Скрипты сами ставят тег `webkit2_41`.

### FAQ (кратко)

- Официальный? **Нет** — community-сборка Lite
- PostgreSQL? **Не нужен**
- Флешка? **Да**, копируй AppImage
- Ошибка WebKit? [docs/FIX-WEBKIT.md](docs/FIX-WEBKIT.md)
