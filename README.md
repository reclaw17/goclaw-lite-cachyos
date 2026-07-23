# goclaw-lite-cachyos

**GoClaw Lite** для CachyOS / Arch — в формате, удобном новичку.

Сначала открой:

**[НАЧНИ-ЗДЕСЬ.md](НАЧНИ-ЗДЕСЬ.md)**

---

## Самый простой путь

1. https://github.com/reclaw17/goclaw-lite-cachyos/releases  
2. Скачать `GoClaw-Lite-x86_64.AppImage`  
3. Запустить:

```bash
chmod +x GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage
```

---

## Если релиза ещё нет — одна команда сборки

```bash
git clone https://github.com/reclaw17/goclaw-lite-cachyos.git
cd goclaw-lite-cachyos
bash всё-сразу.sh
```

Или: **Code → Download ZIP** на GitHub, распаковать, затем `bash всё-сразу.sh`.

---

## Что это

- GoClaw **Lite** = SQLite, без PostgreSQL
- Цель = AppImage на флешку
- CLI-вариант = запасной (см. `docs/CLI-FALLBACK.md`)

Связанный проект агента: https://github.com/reclaw17/goclaw-setup-my-pc

---

## Для продвинутых

Отдельные шаги: `scripts/install-deps-cachyos.sh`, `clone-upstream.sh`, `build-lite.sh`, `package-appimage.sh`  
Подробности: `BUILD.md`, `docs/APPIMAGE.md`
