# Ошибка webkit2gtk-4.0

## Симптом
```text
Package webkit2gtk-4.0 was not found in the pkg-config search path.
ошибка: не найдена цель: webkit2gtk
```

## Причина
На **CachyOS / современном Arch** пакета `webkit2gtk` (ABI 4.0) в официальных репо **уже нет**.  
Есть только `webkit2gtk-4.1`.

Wails по умолчанию ищет 4.0 → нужна сборка с тегом **`webkit2_41`**.

## Исправление (правильное)

1. Убедись, что стоит 4.1:
```bash
sudo pacman -S --needed webkit2gtk-4.1 gtk3
pkg-config --exists webkit2gtk-4.1 && echo OK
```

2. Обнови скрипты репо и собери:
```bash
cd /path/to/goclaw-lite-cachyos
git pull
bash scripts/build-lite.sh
```

В логе должно быть:
```text
==> WebKit: 4.1 (tag webkit2_41)
==> Tags: sqliteonly,webkit2_41
```

## Не делай
```bash
sudo pacman -S webkit2gtk   # пакета нет → ошибка «не найдена цель»
```
