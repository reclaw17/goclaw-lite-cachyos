#!/usr/bin/env bash
# One-shot: deps → clone upstream → build Lite → AppImage
set -euo pipefail

cd "$(cd "$(dirname "$0")" && pwd)"

# --- Language selection ---
LANG_UI="en"
if [[ -t 0 ]]; then
  echo
  echo "======================================"
  echo " Language / Язык"
  echo "======================================"
  echo "  1) English"
  echo "  2) Русский"
  echo
  read -r -p "Choose / Выбери [1/2] (default 1): " lang_ans
  case "${lang_ans:-1}" in
    2|ru|RU|рус*) LANG_UI="ru" ;;
    *) LANG_UI="en" ;;
  esac
fi

if [[ "$LANG_UI" == "ru" ]]; then
  TITLE="GoClaw Lite — сборка CachyOS / Arch"
  INTRO="Сейчас выполнятся все шаги (нужен интернет; может занять время)."
  CONT="Продолжить? [да/нет]: "
  CANCEL="Отменено."
  S1="1/4 Зависимости для сборки"
  S2="2/4 Исходники GoClaw"
  S3="3/4 Сборка Lite"
  S4="4/4 Упаковка AppImage"
  DONE="Готово"
  ARTIFACT="Файл:"
  RUN_HINT="Запуск:"
  NOT_FOUND="AppImage не найден. Смотри ошибки выше."
  PRESS="Нажми Enter, чтобы выйти..."
else
  TITLE="GoClaw Lite — CachyOS / Arch build"
  INTRO="This will run all steps (needs network; may take a while)."
  CONT="Continue? [y/N]: "
  CANCEL="Cancelled."
  S1="1/4 Install build dependencies"
  S2="2/4 Clone upstream GoClaw"
  S3="3/4 Build Lite"
  S4="4/4 Package AppImage"
  DONE="Done"
  ARTIFACT="Artifact:"
  RUN_HINT="Run:"
  NOT_FOUND="AppImage not found. Check errors above."
  PRESS="Press Enter to exit..."
fi

echo
echo "======================================"
echo " $TITLE"
echo "======================================"
echo
echo "$INTRO"
echo

if [[ -t 0 ]]; then
  read -r -p "$CONT" ans
  case "${ans,,}" in
    y|yes|д|да|"") ;;
    *) echo "$CANCEL"; exit 0 ;;
  esac
fi

chmod +x scripts/*.sh 2>/dev/null || true

step() { echo; echo "==> $1"; echo; }

step "$S1"
bash scripts/install-deps-cachyos.sh

step "$S2"
bash scripts/clone-upstream.sh

step "$S3"
bash scripts/build-lite.sh

step "$S4"
bash scripts/package-appimage.sh

echo
echo "======================================"
echo " $DONE"
echo "======================================"
echo
if ls dist/*.AppImage >/dev/null 2>&1; then
  echo "$ARTIFACT"
  ls -lh dist/*.AppImage
  echo
  echo "$RUN_HINT"
  echo "  chmod +x dist/GoClaw-Lite-x86_64.AppImage"
  echo "  ./dist/GoClaw-Lite-x86_64.AppImage"
else
  echo "$NOT_FOUND"
  exit 1
fi
echo
if [[ -t 0 ]]; then
  read -r -p "$PRESS" _
fi
