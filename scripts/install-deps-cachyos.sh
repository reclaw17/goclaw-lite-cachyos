#!/usr/bin/env bash
set -euo pipefail

echo "==> Установка зависимостей для GoClaw Lite (CachyOS/Arch)"

if ! command -v pacman >/dev/null 2>&1; then
  echo "==> Нужен pacman"
  exit 1
fi

echo "==> Системные пакеты"
# На современном Arch/CachyOS пакет webkit2gtk (4.0) убран из репо.
# Нужен webkit2gtk-4.1 + сборка с -tags webkit2_41
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
pkg-config --exists webkit2gtk-4.1 && echo "  webkit2gtk-4.1: OK" || echo "  webkit2gtk-4.1: НЕТ"
pkg-config --exists webkit2gtk-4.0 && echo "  webkit2gtk-4.0: OK" || echo "  webkit2gtk-4.0: нет (это нормально на CachyOS)"

echo
go version || true
node -v || true
pnpm -v || true
wails version || true

echo
echo "==> Готово"
