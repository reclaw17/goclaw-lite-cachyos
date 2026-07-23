<p align="center">
  <img src="https://raw.githubusercontent.com/nextlevelbuilder/goclaw/dev/_statics/logo.png" alt="GoClaw" width="96" onerror="this.style.display='none'">
</p>

<h1 align="center">goclaw-lite-cachyos</h1>

<p align="center">
  <strong>Portable GoClaw Lite for <em>Arch Linux</em> &amp; <em>CachyOS</em></strong><br/>
  Unofficial AppImage · SQLite · no PostgreSQL · USB-friendly
</p>

<p align="center">
  <a href="https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.1.0-cachyos"><img alt="Release" src="https://img.shields.io/badge/release-v0.1.0--cachyos-blue?style=flat-square"></a>
  <a href="https://github.com/nextlevelbuilder/goclaw"><img alt="Upstream" src="https://img.shields.io/badge/upstream-GoClaw%20Lite-orange?style=flat-square"></a>
  <img alt="Portable" src="https://img.shields.io/badge/portable-AppImage-purple?style=flat-square">
  <img alt="Distro" src="https://img.shields.io/badge/distro-Arch%20%7C%20CachyOS-green?style=flat-square">
  <a href="#russian"><img alt="RU" src="https://img.shields.io/badge/lang-EN%20%7C%20RU-lightgrey?style=flat-square"></a>
</p>

---

## English

### What is this?

**Your portable GoClaw Lite** for **Arch Linux** and **CachyOS**.

This project takes the official **[GoClaw Lite](https://github.com/nextlevelbuilder/goclaw)** desktop edition (SQLite, no PostgreSQL) and packages it as a **single portable AppImage** you can:

- download and run
- put on a **USB stick**
- use on Arch / CachyOS (and similar x86_64 Linux)

| | Upstream Standard | **This project (portable Lite)** |
|--|-------------------|----------------------------------|
| Database | PostgreSQL | **SQLite** |
| Form | Server / gateway | **Desktop AppImage** |
| Target | General / infra | **Arch + CachyOS first** |
| Carry on USB | Hard | **One file** |

**Upstream source of truth:** [nextlevelbuilder/goclaw](https://github.com/nextlevelbuilder/goclaw)  
**This repo:** community packaging + build scripts — **not an official release channel**.

### Why Arch & CachyOS?

Official Lite ships mainly for macOS / Windows.  
Here we focus on **Arch-family Linux**:

- correct **WebKit 4.1** build tags (`webkit2_41`)
- pacman-based dependency scripts
- tested path to a **portable AppImage**

### Quick start — portable download

1. Release: **[v0.1.0-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.1.0-cachyos)**
2. Download **`GoClaw-Lite-x86_64.AppImage`**
3. Run:

```bash
chmod +x GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage
```

FUSE issues:

```bash
./GoClaw-Lite-x86_64.AppImage --appimage-extract-and-run
```

**USB:** copy that one AppImage to a flash drive and launch on another Arch/CachyOS machine (host may still need WebKit/GTK libs).

### Build on Arch / CachyOS

Guide: **[START-HERE.md](START-HERE.md)** · details: **[BUILD.md](BUILD.md)**

```bash
git clone https://github.com/reclaw17/goclaw-lite-cachyos.git
cd goclaw-lite-cachyos
bash setup-all.sh
```

Language at startup (**default = English**):

```text
  1) English   (default)
  2) Русский
```

```bash
LANG_UI=en bash setup-all.sh   # English (default)
LANG_UI=ru bash setup-all.sh   # Russian script messages
```

Result: `dist/GoClaw-Lite-x86_64.AppImage`

### FAQ (short)

**Is this official GoClaw?** No — portable packaging of official **Lite** sources.  
**PostgreSQL?** Not needed.  
**Portable / USB?** Yes — one AppImage file.  
**Only Arch/CachyOS?** Optimized for them; other modern Linux x86_64 may work.  
**FUSE error?** Use `--appimage-extract-and-run`.  
**Local models?** Point the setup wizard to an OpenAI-compatible URL (e.g. Fabric).

Full FAQ lives in README history / docs as needed.

### Credits

- App: [nextlevelbuilder/goclaw](https://github.com/nextlevelbuilder/goclaw)
- Portable Arch/CachyOS packaging: this repository

### License

Scripts: MIT · GoClaw application: upstream license

---

<a id="russian"></a>

## Russian

### Что это?

**Портативный GoClaw Lite для Arch Linux и CachyOS.**

Официальный **[GoClaw Lite](https://github.com/nextlevelbuilder/goclaw)** (desktop, SQLite, без PostgreSQL) собран в **один AppImage**, который можно:

- скачать и запустить
- положить на **флешку**
- использовать на Arch / CachyOS

| | Standard | **Эта версия** |
|--|----------|----------------|
| База | PostgreSQL | **SQLite** |
| Форма | Сервер | **Portable AppImage** |
| Фокус | Общий | **Arch + CachyOS** |

Репозиторий **неофициальный** — только упаковка. Оригинал: [nextlevelbuilder/goclaw](https://github.com/nextlevelbuilder/goclaw).

### Скачать портативную версию

**[v0.1.0-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.1.0-cachyos)** → `GoClaw-Lite-x86_64.AppImage`

```bash
chmod +x GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage
```

### Сборка на Arch / CachyOS

```bash
bash setup-all.sh
# язык скриптов по умолчанию — английский
LANG_UI=ru bash setup-all.sh   # русский
```

Подробнее: [START-HERE.md](START-HERE.md), [BUILD.md](BUILD.md).
