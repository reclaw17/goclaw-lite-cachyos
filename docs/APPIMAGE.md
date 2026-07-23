# AppImage — запуск с флешки

## Зачем

Чтобы **не ставить** Go/Wails/WebKit через pacman на каждом ПК.

Сборка один раз → на флешку кладётся AppImage → запуск.

## Команды

```bash
bash scripts/install-deps-cachyos.sh   # только на машине сборки
bash scripts/clone-upstream.sh
bash scripts/build-lite.sh
bash scripts/package-appimage.sh
```

Файл:
```text
dist/GoClaw-Lite-x86_64.AppImage
```

## На флешке

```bash
chmod +x GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage
```

## Ограничения

1. AppImage тяжёлый (GUI-стек)
2. На очень старых glibc-хостах может не завестись
3. Это экспериментальная Linux-сборка Lite, не официальный upstream-релиз
4. FUSE: на некоторых системах нужен `fuse2` / `fuse3` или extract-and-run:
   ```bash
   ./GoClaw-Lite-x86_64.AppImage --appimage-extract-and-run
   ```

## Связь с goclaw-setup-my-pc

Позже AppImage можно класть рядом с USB-агентом как GUI-runtime.  
CLI/harness остаётся запасным путём.
