#!/usr/bin/env bash
# Update portable GoClaw Lite AppImage from GitHub Releases
# Default UI language: English. Russian: LANG_UI=ru bash update.sh
set -euo pipefail

cd "$(cd "$(dirname "$0")" && pwd)"

REPO="${UPDATE_REPO:-reclaw17/goclaw-lite-cachyos}"
ASSET_NAME="${ASSET_NAME:-GoClaw-Lite-x86_64.AppImage}"
API="https://api.github.com/repos/${REPO}/releases/latest"
LANG_UI="${LANG_UI:-en}"

if [[ -t 0 && -z "${LANG_UI_SET:-}" && "${SKIP_LANG_PROMPT:-}" != "1" ]]; then
  echo
  echo "======================================"
  echo " Language / Язык"
  echo "======================================"
  echo "  1) English   (default)"
  echo "  2) Русский"
  echo
  read -r -p "Choose / Выбери [1/2] (default 1): " lang_ans
  case "${lang_ans:-1}" in
    2|ru|RU|рус*) LANG_UI="ru" ;;
    *) LANG_UI="en" ;;
  esac
fi
export LANG_UI

if [[ "$LANG_UI" == "ru" ]]; then
  TITLE="Обновление GoClaw Lite (AppImage)"
  CHECK="Проверяю релизы GitHub..."
  CUR="Текущая версия:"
  LAT="Доступная версия:"
  UPTODATE="Уже последняя версия."
  FOUND="Найдено обновление."
  DL="Скачиваю"
  BACKUP="Бэкап старого файла:"
  DONE="Готово."
  RUN="Запуск:"
  ERR_API="Не удалось получить данные релиза."
  ERR_ASSET="В релизе нет файла ${ASSET_NAME}."
  ERR_DL="Ошибка загрузки."
  NO_LOCAL="Локальный AppImage не найден — будет первая установка в dist/."
  PRESS="Нажми Enter..."
else
  TITLE="GoClaw Lite AppImage updater"
  CHECK="Checking GitHub releases..."
  CUR="Current version:"
  LAT="Latest version:"
  UPTODATE="Already up to date."
  FOUND="Update available."
  DL="Downloading"
  BACKUP="Backup of previous file:"
  DONE="Done."
  RUN="Run:"
  ERR_API="Failed to fetch release metadata."
  ERR_ASSET="Release has no asset named ${ASSET_NAME}."
  ERR_DL="Download failed."
  NO_LOCAL="No local AppImage found — will install into dist/."
  PRESS="Press Enter..."
fi

echo
echo "======================================"
echo " $TITLE"
echo "======================================"
echo
echo "==> $CHECK"
echo "==> Repo: $REPO"

TMP_JSON="$(mktemp)"
trap 'rm -f "$TMP_JSON" "$TMP_JSON.asset" 2>/dev/null || true' EXIT

if ! curl -fsSL -H "Accept: application/vnd.github+json" -H "User-Agent: goclaw-lite-updater" \
  "$API" -o "$TMP_JSON"; then
  echo "==> ERROR: $ERR_API"
  exit 1
fi

TAG="$(python3 -c 'import json,sys; print(json.load(open(sys.argv[1])).get("tag_name") or "")' "$TMP_JSON")"
URL="$(python3 -c '
import json,sys
r=json.load(open(sys.argv[1]))
name=sys.argv[2]
for a in r.get("assets") or []:
  if a.get("name")==name:
    print(a.get("browser_download_url") or "")
    break
' "$TMP_JSON" "$ASSET_NAME")"

if [[ -z "$TAG" ]]; then
  echo "==> ERROR: $ERR_API"
  exit 1
fi
if [[ -z "$URL" ]]; then
  echo "==> ERROR: $ERR_ASSET"
  exit 1
fi

# Prefer existing AppImage next to cwd / dist / common paths
LOCAL=""
for c in \
  "./dist/${ASSET_NAME}" \
  "./${ASSET_NAME}" \
  "$HOME/Загрузки/${ASSET_NAME}" \
  "$HOME/Downloads/${ASSET_NAME}"; do
  if [[ -f "$c" ]]; then
    LOCAL="$c"
    break
  fi
done

VERSION_FILE=""
if [[ -n "$LOCAL" ]]; then
  VERSION_FILE="$(dirname "$LOCAL")/.goclaw-lite-version"
else
  mkdir -p dist
  LOCAL="./dist/${ASSET_NAME}"
  VERSION_FILE="./dist/.goclaw-lite-version"
  echo "==> $NO_LOCAL"
fi

CURRENT="unknown"
if [[ -f "$VERSION_FILE" ]]; then
  CURRENT="$(tr -d '\r\n' < "$VERSION_FILE" || true)"
fi

echo "==> $CUR $CURRENT"
echo "==> $LAT $TAG"

if [[ "$CURRENT" == "$TAG" && -f "$LOCAL" ]]; then
  echo "==> $UPTODATE"
  echo "    $LOCAL"
  if [[ -t 0 ]]; then read -r -p "$PRESS" _; fi
  exit 0
fi

echo "==> $FOUND"
echo "==> $DL $ASSET_NAME ..."

TMP_BIN="$(mktemp)"
if ! curl -fL --progress-bar -o "$TMP_BIN" "$URL"; then
  rm -f "$TMP_BIN"
  echo "==> ERROR: $ERR_DL"
  exit 1
fi

if [[ -f "$LOCAL" ]]; then
  BAK="${LOCAL}.bak-$(date +%Y%m%d-%H%M%S)"
  cp -f "$LOCAL" "$BAK"
  echo "==> $BACKUP $BAK"
fi

mkdir -p "$(dirname "$LOCAL")"
mv -f "$TMP_BIN" "$LOCAL"
chmod +x "$LOCAL"
echo "$TAG" > "$VERSION_FILE"

echo
echo "==> $DONE"
echo "    $LOCAL"
echo "    tag: $TAG"
echo
echo "==> $RUN"
echo "    \"$LOCAL\""
echo
if [[ -t 0 ]]; then read -r -p "$PRESS" _; fi
