#!/usr/bin/env bash
# Один скрипт для новичка: deps → clone → build → optional AppImage
set -euo pipefail

cd "$(cd "$(dirname "$0")" && pwd)"

echo
echo "======================================"
echo " Сборка GoClaw Lite (CachyOS/Arch)"
echo "======================================"
echo
echo "Сейчас будет 3–4 шага."
echo "На установке зависимостей может спросить пароль."
echo "Сборка может занять много времени."
echo

ask() {
  local q="$1" a
  while true; do
    read -r -p "==> $q [да/нет]: " a
    case "${a,,}" in
      да|д|yes|y|"") return 0 ;;
      нет|н|no|n) return 1 ;;
      *) echo "    Напиши: да или нет" ;;
    esac
  done
}

if ! ask "Начать подготовку и сборку?"; then
  echo "==> Отменено"
  exit 0
fi

chmod +x scripts/*.sh 2>/dev/null || true

echo
echo "==> Шаг 1/4: зависимости"
bash scripts/install-deps-cachyos.sh

echo
echo "==> Шаг 2/4: исходники GoClaw"
bash scripts/clone-upstream.sh

echo
echo "==> Шаг 3/4: сборка Lite"
bash scripts/build-lite.sh

echo
if ask "Собрать AppImage для флешки?"; then
  echo "==> Шаг 4/4: AppImage"
  bash scripts/package-appimage.sh
  echo
  echo "==> Готово"
  echo "    Ищи файл в папке dist/"
  echo "    Пример: dist/GoClaw-Lite-x86_64.AppImage"
else
  echo "==> AppImage пропущен"
  echo "    Бинарник смотри в upstream/ui/desktop/build/bin/"
fi

echo
echo "==> Нажмите Enter для выхода"
read -r _
