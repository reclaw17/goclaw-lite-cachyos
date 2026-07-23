#!/usr/bin/env bash
set -euo pipefail

LANG_UI="${LANG_UI:-en}"

if [[ "$LANG_UI" == "ru" ]]; then
  echo "==> Установка зависимостей для GoClaw Lite (CachyOS/Arch)"
  NEED_PACMAN="==> Нужен pacman"
  SYS="==> Системные пакеты"
  DONE="==> Готово"
  NO41="  webkit2gtk-4.1: НЕТ"
  NO40="  webkit2gtk-4.0: нет (это нормально на CachyOS)"
else
  echo "==> Installing build dependencies for GoClaw Lite (CachyOS/Arch)"
  NEED_PACMAN="==> pacman is required"
  SYS="==> System packages"
  DONE="==> Done"
  NO41="  webkit2gtk-4.1: MISSING"
  NO40="  webkit2gtk-4.0: not found (normal on CachyOS)"
fi

if ! command -v pacman >/dev/null 2>&1; then
  echo "$NEED_PACMAN"
  exit 1
fi

echo "$SYS"
# Modern Arch/CachyOS: webkit2gtk (4.0) is gone — use webkit2gtk-4.1 + build tag webkit2_41
sudo pacman -Syu --needed --noconfirm \
  base-devel git go nodejs npm \
  gtk3 webkit2gtk-4.1 pkgconf gcc curl unzip

echo "==> pnpm"
if ! command -v pnpm >/dev/null 2>&1; then
  sudo npm install -g pnpm
fi

echo "==> Wails CLI"
export PATH="$PATH:$(go env GOPATH)/bin"
if ! command -v wails >/dev/null 2>&1; then
  go install github.com/wailsapp/wails/v2/cmd/wails@latest
fi
export PATH="$PATH:$(go env GOPATH)/bin"

echo
echo "==> pkg-config"
pkg-config --exists webkit2gtk-4.1 && echo "  webkit2gtk-4.1: OK" || echo "$NO41"
pkg-config --exists webkit2gtk-4.0 && echo "  webkit2gtk-4.0: OK" || echo "$NO40"

echo
go version || true
node -v || true
pnpm -v || true
wails version || true

echo
echo "$DONE"
