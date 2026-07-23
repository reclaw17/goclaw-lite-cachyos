#!/usr/bin/env bash
# Interactive: deps → clone → build → optional AppImage
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
  TITLE="Сборка GoClaw Lite (CachyOS / Arch)"
  INTRO="Будет 3–4 шага. Установка зависимостей может спросить пароль sudo."
  ASK_START="Начать сборку?"
  CANCEL="Отменено"
  S1="Шаг 1/4: зависимости"
  S2="Шаг 2/4: исходники upstream"
  S3="Шаг 3/4: сборка Lite"
  ASK_APP="Собрать AppImage для флешки?"
  S4="Шаг 4/4: AppImage"
  DONE="Готово — смотри dist/"
  SKIP="AppImage пропущен"
  BIN_HINT="Бинарник: upstream/ui/desktop/build/bin/"
  YN_HINT="    Напиши: да или нет"
  PRESS="Нажми Enter для выхода"
  PROMPT_YN="[да/нет]"
else
  TITLE="GoClaw Lite build (CachyOS / Arch)"
  INTRO="3–4 steps. Dependency install may ask for sudo password."
  ASK_START="Start build?"
  CANCEL="Cancelled"
  S1="Step 1/4: dependencies"
  S2="Step 2/4: upstream sources"
  S3="Step 3/4: build Lite"
  ASK_APP="Package AppImage for USB?"
  S4="Step 4/4: AppImage"
  DONE="Done — see dist/"
  SKIP="AppImage skipped"
  BIN_HINT="Binary: upstream/ui/desktop/build/bin/"
  YN_HINT="    Type y or n"
  PRESS="Press Enter to exit"
  PROMPT_YN="[y/N]"
fi

echo
echo "======================================"
echo " $TITLE"
echo "======================================"
echo
echo "$INTRO"
echo

ask() {
  local q="$1" a
  while true; do
    read -r -p "==> $q $PROMPT_YN: " a
    case "${a,,}" in
      y|yes|д|да|"") return 0 ;;
      n|no|н|нет) return 1 ;;
      *) echo "$YN_HINT" ;;
    esac
  done
}

if ! ask "$ASK_START"; then
  echo "==> $CANCEL"
  exit 0
fi

chmod +x scripts/*.sh 2>/dev/null || true

echo
echo "==> $S1"
bash scripts/install-deps-cachyos.sh

echo
echo "==> $S2"
bash scripts/clone-upstream.sh

echo
echo "==> $S3"
bash scripts/build-lite.sh

echo
if ask "$ASK_APP"; then
  echo "==> $S4"
  bash scripts/package-appimage.sh
  echo
  echo "==> $DONE"
else
  echo "==> $SKIP"
  echo "    $BIN_HINT"
fi

echo
echo "==> $PRESS"
read -r _
