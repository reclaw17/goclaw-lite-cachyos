#!/usr/bin/env bash
# Одна кнопка для новичка: deps → clone → build → AppImage
set -euo pipefail

cd "$(cd "$(dirname "$0")" && pwd)"

echo
echo "======================================"
echo " GoClaw Lite — сборка под CachyOS"
echo "======================================"
echo
echo "Сейчас всё сделаю по шагам."
echo "Нужен интернет и время (может быть долго)."
echo

if [[ -t 0 ]]; then
  read -r -p "Продолжить? [да/нет]: " ans
  case "${ans,,}" in
    да|д|yes|y|"") ;;
    *) echo "Отменено."; exit 0 ;;
  esac
fi

chmod +x scripts/*.sh 2>/dev/null || true

step() { echo; echo "==> $1"; echo; }

step "1/4 Зависимости для сборки"
bash scripts/install-deps-cachyos.sh

step "2/4 Исходники GoClaw"
bash scripts/clone-upstream.sh

step "3/4 Сборка Lite"
bash scripts/build-lite.sh

step "4/4 Упаковка AppImage"
bash scripts/package-appimage.sh

echo
echo "======================================"
echo " Готово"
echo "======================================"
echo
if ls dist/*.AppImage >/dev/null 2>&1; then
  echo "Файл:"
  ls -lh dist/*.AppImage
  echo
  echo "Скопируй AppImage на флешку и запускай:"
  echo "  chmod +x GoClaw-Lite-x86_64.AppImage"
  echo "  ./GoClaw-Lite-x86_64.AppImage"
else
  echo "AppImage не найден. Пришли лог ошибок выше."
  exit 1
fi
echo
if [[ -t 0 ]]; then
  read -r -p "Нажми Enter, чтобы выйти..." _
fi
