# goclaw-lite-cachyos

Сборка **GoClaw Lite** (SQLite) для CachyOS/Arch → **AppImage** на флешку.

Сначала: **[НАЧНИ-ЗДЕСЬ.md](НАЧНИ-ЗДЕСЬ.md)**

---

## Сборка на CachyOS

```bash
git clone https://github.com/reclaw17/goclaw-lite-cachyos.git
cd goclaw-lite-cachyos
bash всё-сразу.sh
```

Или по шагам:
```bash
bash scripts/install-deps-cachyos.sh
bash scripts/clone-upstream.sh
bash scripts/build-lite.sh
bash scripts/package-appimage.sh
```

### Важно про WebKit

На CachyOS нужен **`webkit2gtk-4.1`**.  
Пакета `webkit2gtk` (4.0) в репо нет.

Скрипт сам добавляет тег сборки `webkit2_41`.

См. `docs/FIX-WEBKIT.md`.

---

## Результат

```text
dist/GoClaw-Lite-x86_64.AppImage
```

```bash
chmod +x dist/GoClaw-Lite-x86_64.AppImage
./dist/GoClaw-Lite-x86_64.AppImage
```
