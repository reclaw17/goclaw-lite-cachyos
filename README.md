# goclaw-lite-cachyos

Сборка **GoClaw Lite** для CachyOS/Arch и упаковка в **AppImage** (запуск с флешки).

**Опыт программиста не обязателен.**

---

## Ссылка

https://github.com/reclaw17/goclaw-lite-cachyos

---

## Для новичка

Открой файл **[НАЧНИ-ЗДЕСЬ.txt](НАЧНИ-ЗДЕСЬ.txt)**

Коротко:

1. Скачай ZIP с GitHub (**Code → Download ZIP**) или сделай `git clone`
2. Открой терминал в папке проекта
3. Выполни по очереди:

```bash
bash scripts/install-deps-cachyos.sh
bash scripts/clone-upstream.sh
bash scripts/build-lite.sh
bash scripts/package-appimage.sh
```

4. Возьми файл:

```text
dist/GoClaw-Lite-x86_64.AppImage
```

5. На флешке:

```bash
chmod +x GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage
```

---

## Зачем это

- GoClaw Lite = без PostgreSQL (SQLite)
- AppImage = “всё с собой”, как portable на Windows
- Зависимости ставятся только на ПК сборки

---

## Если что-то сломалось

Пришли текст ошибки из терминала. Не нужно всё удалять.

---

## Запасной путь

CLI / тонкий harness — см. `docs/CLI-FALLBACK.md`

Основной USB-агент: https://github.com/reclaw17/goclaw-setup-my-pc

---

## License

Скрипты — MIT. GoClaw — лицензия upstream.
