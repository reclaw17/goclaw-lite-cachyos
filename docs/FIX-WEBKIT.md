# Ошибка webkit2gtk-4.0

## Симптом
```text
Package webkit2gtk-4.0 was not found in the pkg-config search path.
```

## Причина
На CachyOS/Arch часто стоит только `webkit2gtk-4.1`.  
Wails по умолчанию ищет **webkit2gtk-4.0**.

## Исправление
```bash
sudo pacman -S --needed webkit2gtk
pkg-config --exists webkit2gtk-4.0 && echo OK
```

Потом снова:
```bash
bash scripts/build-lite.sh
# или
bash всё-сразу.sh
```
