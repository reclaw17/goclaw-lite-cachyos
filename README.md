<p align="center">
  <img src="https://raw.githubusercontent.com/nextlevelbuilder/goclaw/dev/_statics/logo.png" alt="GoClaw" width="96" onerror="this.style.display='none'">
</p>

<h1 align="center">goclaw-lite-cachyos</h1>

<p align="center">
  <strong>Portable GoClaw Lite for Arch Linux and CachyOS</strong><br/>
  Unofficial community AppImage · SQLite · USB-friendly · auto-update
</p>

<p align="center">
  <a href="https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.2.0-cachyos"><img alt="Latest" src="https://img.shields.io/badge/Latest-v0.2.0--cachyos-blue?style=for-the-badge"></a>
</p>

<p align="center">
  <a href="https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.2.0-cachyos"><img alt="Release" src="https://img.shields.io/badge/release-v0.2.0--cachyos-blue?style=flat-square"></a>
  <img alt="Portable" src="https://img.shields.io/badge/portable-AppImage-success?style=flat-square">
  <img alt="Arch" src="https://img.shields.io/badge/Arch%20%7C%20CachyOS-supported-green?style=flat-square">
  <img alt="License" src="https://img.shields.io/badge/license-MIT%20(scripts)-lightgrey?style=flat-square">
  <a href="https://github.com/nextlevelbuilder/goclaw"><img alt="Upstream" src="https://img.shields.io/badge/upstream-GoClaw%20Lite-orange?style=flat-square"></a>
</p>

---

## Important (read this)

- **Unofficial.** Community packaging only — **not** a product of [nextlevelbuilder](https://github.com/nextlevelbuilder) / official GoClaw.
- **Target:** **Arch Linux** and **CachyOS**, Linux **x86_64** AppImage.
- **Secrets:** API keys stay on **your** machine. Releases contain **no** keys.
- **Support:** best effort. App bugs (for example log spam like `list_tenants_failed` / SQLite `settings` scan) belong to **upstream GoClaw Lite**, not “broken USB packaging”. Report serious app issues upstream: https://github.com/nextlevelbuilder/goclaw
- **This repo** = build scripts + AppImage + update helpers. Not the full USB-agent product (skills, Fabric, OpenWrt, Windows stack).

---

## English

### Latest download

**[v0.2.0-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.2.0-cachyos)** → `GoClaw-Lite-x86_64.AppImage`

```bash
chmod +x GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage
```

### How to use

| Method | Who it is for |
|--------|----------------|
| [Releases](https://github.com/reclaw17/goclaw-lite-cachyos/releases) | Fastest — download ready file |
| **Actions → Build AppImage → Run workflow** | Cloud build, no local compile |
| `./GoClaw-Lite-x86_64.AppImage --update` | Update file on USB/disk |
| `bash setup-all.sh` on CachyOS/Arch | Native rebuild |

### Update

```bash
./GoClaw-Lite-x86_64.AppImage --check-update
./GoClaw-Lite-x86_64.AppImage --update
# or
bash update.sh
```

Docs: [docs/UPDATE.md](docs/UPDATE.md) · [docs/CI.md](docs/CI.md) · [START-HERE.md](START-HERE.md) · [STATUS.md](STATUS.md)

### License

- **Scripts & docs in this repo:** [MIT](LICENSE)
- **GoClaw application:** upstream license

---

## Russian

### Важно

- **Неофициально.** Community-сборка, **не** продукт nextlevelbuilder.
- **Цель:** **Arch / CachyOS**, Linux x86_64 AppImage.
- **Секреты:** API-ключи только у вас; в релизе их нет.
- **Поддержка:** best effort. Ошибки вроде `list_tenants_failed` в логе — сторона **upstream Lite + SQLite**, не «сломанная флешка». Серьёзные баги приложения — в https://github.com/nextlevelbuilder/goclaw

### Скачать

**[v0.2.0-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.2.0-cachyos)**

```bash
chmod +x GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage --update
```
