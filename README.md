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
  <img alt="Update" src="https://img.shields.io/badge/update-update.sh-purple?style=flat-square">
  <img alt="Arch" src="https://img.shields.io/badge/Arch%20%7C%20CachyOS-supported-green?style=flat-square">
  <a href="https://github.com/nextlevelbuilder/goclaw"><img alt="Upstream" src="https://img.shields.io/badge/upstream-GoClaw%20Lite-orange?style=flat-square"></a>
</p>

---

## English

### What is this?

**Portable GoClaw Lite** for **Arch Linux** and **CachyOS**:

- one **AppImage** (USB-friendly)
- **SQLite** — no PostgreSQL
- **auto-update** from GitHub Releases (`update.sh`)
- upstream app: [nextlevelbuilder/goclaw](https://github.com/nextlevelbuilder/goclaw) (Lite)
- this repo: community packaging (not affiliated)

### Quick start

**Download:** [v0.1.0-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.1.0-cachyos)

```bash
chmod +x GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage
```

### Auto-update

```bash
bash update.sh
```

- Checks latest GitHub Release
- Downloads a newer `GoClaw-Lite-x86_64.AppImage` if needed
- Keeps a `.bak-...` backup
- Default UI language: **English** (`LANG_UI=ru` for Russian)

Details: [docs/UPDATE.md](docs/UPDATE.md)

### Build on Arch / CachyOS

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
**Update?** `bash update.sh`

### License

Scripts: MIT · GoClaw app: upstream license

---

## Russian

**Портативный GoClaw Lite** для **Arch** и **CachyOS** (AppImage + автообновление).

```bash
# скачать релиз, затем обновлять так:
bash update.sh
LANG_UI=ru bash update.sh
```

Сборка: `bash setup-all.sh` · доки: [START-HERE.md](START-HERE.md), [docs/UPDATE.md](docs/UPDATE.md).
