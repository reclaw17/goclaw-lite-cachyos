# goclaw-lite-cachyos

Сборка **GoClaw Lite** (sqliteonly, без PostgreSQL) под **CachyOS / Arch Linux**.

Отдельный репозиторий специально для portable/desktop-варианта GoClaw.

---

## Зачем этот репо

Официальный GoClaw Lite сейчас собирается в CI в основном под **macOS и Windows**.  
Linux desktop/lite официально не отдают готовым билдом.

Этот репозиторий:
1. фиксирует, **как собрать Lite на CachyOS/Arch**
2. готовит скрипты зависимостей и сборки
3. позже — упаковку под флешку / локальный запуск

Связанный проект агента: https://github.com/reclaw17/goclaw-setup-my-pc

---

## Что такое GoClaw Lite

| | Standard | Lite |
|--|----------|------|
| База | PostgreSQL | **SQLite** |
| Docker | часто нужен | **не нужен** |
| Цель | сервер | desktop / local |
| UI | web dashboard | native (Wails) |

Источник upstream: https://github.com/nextlevelbuilder/goclaw

Сборка Lite идёт с тегом:
```bash
-tags sqliteonly
```

---

## Быстрый путь (CachyOS / Arch)

### 1. Поставить зависимости
```bash
bash scripts/install-deps-cachyos.sh
```

### 2. Склонировать upstream GoClaw
```bash
bash scripts/clone-upstream.sh
```

### 3. Собрать Lite
```bash
bash scripts/build-lite.sh
```

Готовый бинарник/приложение появится в:
```text
upstream/ui/desktop/build/bin/
```

---

## Структура репо

```text
goclaw-lite-cachyos/
├── README.md
├── BUILD.md
├── STATUS.md
├── scripts/
│   ├── install-deps-cachyos.sh
│   ├── clone-upstream.sh
│   └── build-lite.sh
└── packaging/          # позже: portable layout для USB
```

---

## Статус

См. `STATUS.md`

---

## Важно

- Это **не** серверный GoClaw с PostgreSQL
- Это путь к **Lite / sqliteonly** под Linux
- Переносимость «одной флешки на любой ПК» после сборки нужно проверять отдельно
- Пользователь без опыта разработки: шаги максимально скриптованы

---

## Лицензия

Скрипты этого репо — MIT.  
GoClaw upstream — своя лицензия upstream-проекта.
