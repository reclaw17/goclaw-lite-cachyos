# goclaw-lite-cachyos

Сборка **GoClaw Lite** для CachyOS/Arch и упаковка в **AppImage** (запуск с флешки).

---

## Для новичка

1. Открой файл **`НАЧНИ-ЗДЕСЬ.txt`**
2. В терминале в папке проекта запусти:

```bash
bash собрать.sh
```

Скрипт сам проведёт по шагам и спросит про AppImage.

---

## Что получится

```text
dist/GoClaw-Lite-x86_64.AppImage
```

На флешке:

```bash
chmod +x GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage
```

---

## Запасной путь

CLI / тонкий harness — см. `docs/CLI-FALLBACK.md`

Основной USB-проект: https://github.com/reclaw17/goclaw-setup-my-pc

Upstream GoClaw: https://github.com/nextlevelbuilder/goclaw
