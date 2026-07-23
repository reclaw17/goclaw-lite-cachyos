# CLI fallback (запасной путь)

Если GUI GoClaw Lite / AppImage не подойдёт:

## 1. Наш тонкий USB-harness

Репо: https://github.com/reclaw17/goclaw-setup-my-pc

- Fabric offline
- cloud online
- skills / docs / safety
- без PostgreSQL

## 2. Готовые console coding agents (кандидаты)

Можно рассмотреть позже как CLI-мозг для кодинга:

- **Aider** — terminal coding agent
- **OpenCode / похожие TUI-агенты**
- **Continue (CLI-режим)** — если понадобится IDE-ориентированный путь

Критерии выбора:
- запуск без серверной БД
- возможность OpenAI-compatible endpoint (Fabric)
- адекватная работа из терминала
- минимальные system deps

## Приоритет

1. AppImage GUI Lite  
2. CLI harness / console agent — запасной
