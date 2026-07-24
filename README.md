<p align="center">
  <img src="https://raw.githubusercontent.com/nextlevelbuilder/goclaw/dev/_statics/logo.png" alt="GoClaw" width="96" onerror="this.style.display='none'">
</p>

<h1 align="center">goclaw-lite-cachyos</h1>

<p align="center">
  <strong>Portable GoClaw Lite for Arch Linux and CachyOS</strong><br/>
  Unofficial AppImage · SQLite · USB-friendly · auto-update<br/>
  <em>Packaging track: finalized for personal use</em>
</p>

<p align="center">
  <a href="https://github.com/reclaw17/goclaw-lite-cachyos/releases"><img alt="Release" src="https://img.shields.io/badge/releases-AppImage-blue?style=flat-square"></a>
  <img alt="Portable" src="https://img.shields.io/badge/portable-AppImage-success?style=flat-square">
  <img alt="Arch" src="https://img.shields.io/badge/Arch%20%7C%20CachyOS-supported-green?style=flat-square">
  <a href="https://github.com/nextlevelbuilder/goclaw"><img alt="Upstream" src="https://img.shields.io/badge/upstream-GoClaw%20Lite-orange?style=flat-square"></a>
</p>

---

## English

### What is this?

Community **portable AppImage** of official **[GoClaw Lite](https://github.com/nextlevelbuilder/goclaw)** for **Arch Linux** and **CachyOS** (SQLite, no PostgreSQL).

This repository is **only packaging** (build scripts + AppImage + update).  
It is **not** the full USB-agent product (skills, Fabric, OpenWrt, Windows stack).

### How to use correctly

| Method | Who it is for |
|--------|----------------|
| **Actions → Build AppImage → Run workflow** | Normal path — no local compile |
| [Releases](https://github.com/reclaw17/goclaw-lite-cachyos/releases) download | Fastest if a Release already exists |
| `./GoClaw-Lite-x86_64.AppImage --update` | Update the file on USB/disk |
| `bash setup-all.sh` on your PC | If CI is red, or native CachyOS build |

### Quick start

```bash
chmod +x GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage
```

### How to update

Prefer the **newest** Release (not only `v0.1.0-cachyos`).

```bash
# A) embedded (newer AppImages)
./GoClaw-Lite-x86_64.AppImage --check-update
./GoClaw-Lite-x86_64.AppImage --update

# B) repo script
bash update.sh

# C) manual download from Releases
```

Details: [docs/UPDATE.md](docs/UPDATE.md) · CI: [docs/CI.md](docs/CI.md) · Tails closed: [docs/TAILS.md](docs/TAILS.md) · [STATUS.md](STATUS.md)

### License

Scripts: MIT · GoClaw app: upstream license

---

## Russian

**Портативный GoClaw Lite** для **Arch / CachyOS**.  
Ветка **упаковки финализирована** для личного использования.

### Как пользоваться

| Способ | Для кого |
|--------|----------|
| **Actions → Build AppImage → Run workflow** | Обычный путь без компиляции |
| [Releases](https://github.com/reclaw17/goclaw-lite-cachyos/releases) | Скачать готовый файл |
| `./GoClaw-Lite-x86_64.AppImage --update` | Обновить на флешке |
| `bash setup-all.sh` | Запасной путь / родная сборка CachyOS |

### Обновление

Бери **последний** Release (например `lite-linux-14` или новее).

```bash
./GoClaw-Lite-x86_64.AppImage --update
bash update.sh
```

Хвосты закрыты: [docs/TAILS.md](docs/TAILS.md) · [STATUS.md](STATUS.md)
