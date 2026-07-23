# Сборка GoClaw Lite на CachyOS / Arch

## Требования

- CachyOS или Arch Linux
- интернет
- ~5–10 ГБ свободного места на время сборки
- обычные права пользователя + `sudo` для пакетов

## Зависимости (ключевые)

- `go`
- `nodejs` + `pnpm`
- `wails` (CLI)
- WebKit/GTK для Wails на Linux:
  - `webkit2gtk-4.1` (или актуальный пакет в репо)
  - `gtk3`
  - `gcc` / base-devel

Точный список ставит:
```bash
bash scripts/install-deps-cachyos.sh
```

## Upstream

Клонируем официальный репозиторий:
```bash
bash scripts/clone-upstream.sh
```

По умолчанию ветка: `dev` (активная разработка upstream).

## Команда сборки Lite

В upstream Makefile:
```make
desktop-build:
	cd ui/desktop && wails build -tags sqliteonly ...
```

Наш скрипт:
```bash
bash scripts/build-lite.sh
```

## Что должно получиться

Каталог:
```text
upstream/ui/desktop/build/bin/
```

Там desktop-приложение GoClaw Lite (sqliteonly).

## Известные риски

1. Upstream CI для Lite сейчас ориентирован на macOS/Windows
2. Linux desktop может потребовать ручных правок
3. Portable USB ≠ просто скопировать GUI-бинарник (нужны libs / проверка)
4. Версии webkit2gtk на Arch иногда ломают Wails — фиксим по факту ошибки

## После успешной сборки

1. Зафиксировать версию upstream commit в `STATUS.md`
2. Проверить запуск на той же машине
3. Проверить копирование на флешку и запуск на другой Arch/CachyOS машине
4. Связать с `goclaw-setup-my-pc` как optional runtime
