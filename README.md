<p align="center">
  <img src="https://raw.githubusercontent.com/nextlevelbuilder/goclaw/dev/_statics/logo.png" alt="GoClaw" width="96" onerror="this.style.display='none'">
</p>

<h1 align="center">goclaw-lite-cachyos</h1>

<p align="center">
  <strong>Portable GoClaw Lite for Arch Linux and CachyOS</strong><br/>
  Unofficial AppImage · SQLite · no PostgreSQL · USB-friendly · auto-update
</p>

<p align="center">
  <a href="https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.1.0-cachyos"><img alt="Release" src="https://img.shields.io/badge/release-v0.1.0--cachyos-blue?style=flat-square"></a>
  <img alt="Portable" src="https://img.shields.io/badge/portable-AppImage-success?style=flat-square">
  <img alt="Update" src="https://img.shields.io/badge/update---update-purple?style=flat-square">
  <img alt="Arch" src="https://img.shields.io/badge/Arch%20%7C%20CachyOS-supported-green?style=flat-square">
  <a href="https://github.com/nextlevelbuilder/goclaw"><img alt="Upstream" src="https://img.shields.io/badge/upstream-GoClaw%20Lite-orange?style=flat-square"></a>
</p>

---

## English

### What is this?

**Portable GoClaw Lite** for **Arch Linux** and **CachyOS**:

- one **AppImage** (USB-friendly)
- **SQLite** — no PostgreSQL
- auto-update (`--update` / `update.sh`)
- upstream app: [nextlevelbuilder/goclaw](https://github.com/nextlevelbuilder/goclaw) (Lite)
- this repo: community packaging (not affiliated)

### How to use correctly (recommended)

| Method | Who it is for |
|--------|----------------|
| **Actions → Build AppImage → Run workflow** | Normal path — no compiling on your PC |
| `./GoClaw-Lite-x86_64.AppImage --update` | Update the file on a USB stick / folder |
| `bash setup-all.sh` on your machine | If CI is red, or you want a native CachyOS build |

CI guide: [docs/CI.md](docs/CI.md) · Actions: https://github.com/reclaw17/goclaw-lite-cachyos/actions

### Quick start

**Download:** [Releases](https://github.com/reclaw17/goclaw-lite-cachyos/releases) (or the artifact from Actions)

```bash
chmod +x GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage
```

### Auto-update

```bash
./GoClaw-Lite-x86_64.AppImage --update
# or from this repo:
bash update.sh
```

Details: [docs/UPDATE.md](docs/UPDATE.md)

### Build on Arch / CachyOS (fallback)

```bash
git clone https://github.com/reclaw17/goclaw-lite-cachyos.git
cd goclaw-lite-cachyos
bash setup-all.sh
```

Language at startup defaults to **English**. See [START-HERE.md](START-HERE.md), [BUILD.md](BUILD.md).

### FAQ

**Official?** No — portable packaging of official Lite.  
**PostgreSQL?** Not required.  
**USB?** Copy the AppImage.  
**Update?** `./AppImage --update` or `bash update.sh`

### License

Scripts: MIT · GoClaw app: upstream license

---

## Russian

**Портативный GoClaw Lite** для **Arch** и **CachyOS**.

### Как правильно пользоваться сейчас

| Способ | Для кого |
|--------|----------|
| **Actions → Build AppImage → Run workflow** | Обычный путь, без возни с компиляцией |
| `./GoClaw-Lite-x86_64.AppImage --update` | Обновить файл на флешке |
| `bash setup-all.sh` у себя | Если CI красный или нужна «родная» сборка под CachyOS |

Инструкция по CI: [docs/CI.md](docs/CI.md) · https://github.com/reclaw17/goclaw-lite-cachyos/actions

```bash
# запуск
chmod +x GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage

# обновление файла
./GoClaw-Lite-x86_64.AppImage --update
bash update.sh
LANG_UI=ru bash update.sh
```

Запасной путь (сборка дома): `bash setup-all.sh` · [START-HERE.md](START-HERE.md), [docs/UPDATE.md](docs/UPDATE.md).
