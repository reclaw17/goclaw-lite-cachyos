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
  <a href="#-%D1%80%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9"><img alt="RU" src="https://img.shields.io/badge/lang-EN%20%7C%20RU-lightgrey?style=flat-square"></a>
  <img alt="Platform" src="https://img.shields.io/badge/platform-Linux%20x86__64-green?style=flat-square">
</p>

---

## English

### What is this?

This repository packages **[GoClaw Lite](https://github.com/nextlevelbuilder/goclaw)** (the official desktop / SQLite edition) as a **portable Linux AppImage**.

- **Upstream project:** [nextlevelbuilder/goclaw](https://github.com/nextlevelbuilder/goclaw)
- **Edition:** Lite (`sqliteonly`) — local SQLite, no PostgreSQL, no Docker required for the DB
- **Target:** CachyOS / Arch Linux (and other modern x86_64 Linux with compatible libs)
- **This repo is not affiliated** with the upstream authors; it only provides build scripts and a community AppImage

| | GoClaw Standard | GoClaw Lite (this build) |
|--|-----------------|---------------------------|
| Database | PostgreSQL | **SQLite** |
| Form factor | Server / gateway | **Desktop (Wails)** |
| Typical setup | Docker / infra | AppImage / local binary |

### Quick start (download)

1. Open the release: **[v0.1.0-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.1.0-cachyos)**
2. Download `GoClaw-Lite-x86_64.AppImage`
3. Run:

```bash
chmod +x GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage
```

If your system complains about FUSE:

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

### Build from source (CachyOS / Arch)

```bash
git clone https://github.com/reclaw17/goclaw-lite-cachyos.git
cd goclaw-lite-cachyos
bash всё-сразу.sh
# or step by step:
# bash scripts/install-deps-cachyos.sh
# bash scripts/clone-upstream.sh
# bash scripts/build-lite.sh
# bash scripts/package-appimage.sh
```

Output:

```text
dist/GoClaw-Lite-x86_64.AppImage
```

**WebKit note:** modern Arch/CachyOS ships `webkit2gtk-4.1` only.  
Build scripts automatically use `-tags sqliteonly,webkit2_41`.  
See [docs/FIX-WEBKIT.md](docs/FIX-WEBKIT.md).

### FAQ

**Is this the official GoClaw?**  
No. This is an **unofficial community packaging** of the official **GoClaw Lite** sources. Support upstream first: [nextlevelbuilder/goclaw](https://github.com/nextlevelbuilder/goclaw).

**Lite or Standard — which one is this?**  
**Lite.** SQLite desktop app (Wails). Not the server edition that needs PostgreSQL.

**Do I need PostgreSQL / Docker?**  
**No** for this AppImage.

**Does it work offline?**  
The app starts offline. Chat still needs a configured provider (cloud API or a local OpenAI-compatible endpoint you point it to).

**USB / portable?**  
Yes for the **AppImage file** itself. Copy one file to a USB stick and run it on compatible Linux x86_64 machines. System libraries (WebKit/GTK) may still need to exist on the host.

**Why was `webkit2gtk` package missing?**  
On modern CachyOS/Arch the old `webkit2gtk` (4.0) package is gone. Use `webkit2gtk-4.1` and build with tag `webkit2_41`.

**Build fails with `webkit2gtk-4.0 not found`**  
Update scripts (`git pull`) and rebuild. Tags must include `webkit2_41`. Details: [docs/FIX-WEBKIT.md](docs/FIX-WEBKIT.md).

**AppImage says FUSE error**  
Run: `./GoClaw-Lite-x86_64.AppImage --appimage-extract-and-run`

**Windows / macOS?**  
This repo targets **Linux AppImage**. Official Lite install scripts for macOS/Windows live upstream.

**Can I use local models (Fabric / llama.cpp)?**  
Point an OpenAI-compatible provider URL in the setup wizard to your local server (for example Fabric on `http://127.0.0.1:8080/v1`).

**Where is the binary after build?**  
`upstream/ui/desktop/build/bin/goclaw-lite` and packaged as `dist/GoClaw-Lite-x86_64.AppImage`.

**Is data stored on the USB stick?**  
Depends on GoClaw Lite paths. Expect local config/DB under the user profile unless you configure otherwise. Treat USB as the app carrier first.

### Credits

- **GoClaw** by [nextlevelbuilder](https://github.com/nextlevelbuilder/goclaw) — original agent platform
- Packaging / CachyOS scripts — this repository

Please star and support **upstream** if you use GoClaw:  
https://github.com/nextlevelbuilder/goclaw

### License

- Scripts in this repo: MIT
- GoClaw application code: upstream license

---

## Русский

### Что это?

Неофициальная сборка **[GoClaw Lite](https://github.com/nextlevelbuilder/goclaw)** (desktop / SQLite) в формате **AppImage** для Linux.

- **Оригинал:** [nextlevelbuilder/goclaw](https://github.com/nextlevelbuilder/goclaw)
- **Редакция:** Lite (`sqliteonly`) — локальный SQLite, **без PostgreSQL**
- **Для кого:** CachyOS / Arch и близкие x86_64 Linux
- Репозиторий **не связан** с авторами upstream — только скрипты сборки и community AppImage

### Быстрый запуск

1. Релиз: **[v0.1.0-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.1.0-cachyos)**
2. Скачай `GoClaw-Lite-x86_64.AppImage`
3. Запусти:

```bash
chmod +x GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage
```

Если ругается на FUSE:

```bash
./GoClaw-Lite-x86_64.AppImage --appimage-extract-and-run
```

### Сборка на CachyOS

```bash
git clone https://github.com/reclaw17/goclaw-lite-cachyos.git
cd goclaw-lite-cachyos
bash всё-сразу.sh
```

Готовый файл: `dist/GoClaw-Lite-x86_64.AppImage`

На CachyOS нужен `webkit2gtk-4.1` (пакета `webkit2gtk` 4.0 в репо нет).  
Скрипт сам включает тег `webkit2_41`.

### Частые вопросы (FAQ)

**Это официальный GoClaw?**  
Нет. Это **неофициальная community-сборка** официального **GoClaw Lite**. Поддержите upstream: [nextlevelbuilder/goclaw](https://github.com/nextlevelbuilder/goclaw).

**Lite или Standard?**  
**Lite.** Desktop на SQLite. Не серверная версия с PostgreSQL.

**Нужны PostgreSQL и Docker?**  
**Нет** для этого AppImage.

**Работает ли офлайн?**  
Приложение запускается без сети. Для чата нужен настроенный провайдер (облако или локальный OpenAI-compatible endpoint).

**Можно с флешки?**  
Да: копируешь один AppImage. На другом Linux x86_64 могут понадобиться системные библиотеки (WebKit/GTK).

**Почему нет пакета `webkit2gtk`?**  
В современном CachyOS/Arch старый 4.0 убрали. Нужен `webkit2gtk-4.1` и тег сборки `webkit2_41`.

**Ошибка `webkit2gtk-4.0 not found`**  
Обнови скрипты (`git pull`) и пересобери. Подробности: [docs/FIX-WEBKIT.md](docs/FIX-WEBKIT.md).

**AppImage ругается на FUSE**  
Запуск: `./GoClaw-Lite-x86_64.AppImage --appimage-extract-and-run`

**Windows / macOS?**  
Этот репозиторий — **Linux AppImage**. Официальные Lite-скрипты для macOS/Windows — у upstream.

**Локальные модели (Fabric / llama.cpp)?**  
В мастере настройки укажи OpenAI-compatible URL локального сервера (например Fabric `http://127.0.0.1:8080/v1`).

**Где бинарник после сборки?**  
`upstream/ui/desktop/build/bin/goclaw-lite` и `dist/GoClaw-Lite-x86_64.AppImage`.

**Данные хранятся на флешке?**  
Обычно конфиг/БД Lite живут в профиле пользователя. Флешка в первую очередь носитель приложения.

### Благодарности

- **GoClaw** — [nextlevelbuilder/goclaw](https://github.com/nextlevelbuilder/goclaw)
- Упаковка под CachyOS — этот репозиторий

Поддержите upstream: https://github.com/nextlevelbuilder/goclaw
