# goclaw-lite-cachyos

Сборка **GoClaw Lite** (SQLite, без PostgreSQL) для **CachyOS / Arch Linux**  
и упаковка в **AppImage** для запуска с флешки.

Связанный USB-агент: [goclaw-setup-my-pc](https://github.com/reclaw17/goclaw-setup-my-pc)

---

## Цель

```text
Сборка на CachyOS  →  AppImage  →  флешка  →  запуск на Linux без pacman
```

Как portable-программы на Windows: **максимум “всё с собой”**.

---

## Путь пользователя

### A) Основной: GUI Lite через AppImage

```bash
# один раз на машине сборки (CachyOS/Arch)
bash scripts/install-deps-cachyos.sh
bash scripts/clone-upstream.sh
bash scripts/build-lite.sh
bash scripts/package-appimage.sh
```

Результат:
```text
dist/GoClaw-Lite-x86_64.AppImage
```

На флешку копируешь **этот файл** (и при желании `models/`, `.env`).

Запуск:
```bash
chmod +x GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage
```

### B) Запасной: CLI

Если GUI/AppImage не зайдёт — CLI-путь (тонкий harness / готовые console coding agents).  
См. `docs/CLI-FALLBACK.md`.

---

## Что такое Lite

| | Standard | Lite |
|--|----------|------|
| База | PostgreSQL | **SQLite** |
| Docker | часто нужен | не нужен |
| UI | web/server | Wails desktop |

Upstream: https://github.com/nextlevelbuilder/goclaw  
Сборка: `wails build -tags sqliteonly`

---

## Структура

```text
scripts/
  install-deps-cachyos.sh   # только для СБОРКИ
  clone-upstream.sh
  build-lite.sh
  package-appimage.sh       # упаковка для флешки
docs/
  BUILD-CACHYOS.md
  APPIMAGE.md
  CLI-FALLBACK.md
dist/                       # артефакты (не в git)
```

---

## Важно

1. `install-deps` нужен **только на ПК, где собираешь**
2. На целевых машинах зависимости через pacman ставить **не нужно** (цель AppImage)
3. Linux Lite — экспериментальный путь, upstream официально Linux desktop не отдаёт
4. AppImage может быть большим (WebKit/GTK внутри)

---

## License

Скрипты репо — MIT. Код GoClaw — лицензия upstream.
