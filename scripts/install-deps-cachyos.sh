#!/usr/bin/env bash
# Install build dependencies for GoClaw Lite on CachyOS / Arch
set -euo pipefail

echo "==> Установка зависимостей для GoClaw Lite (CachyOS/Arch)"

if ! command -v pacman >/dev/null 2>&1; then
  echo "==> Ошибка: нужен pacman (CachyOS/Arch)"
  exit 1
fi

echo "==> Системные пакеты"
sudo pacman -Syu --needed --noconfirm \
  base-devel \
  git \
  go \
  nodejs \
  npm \
  gtk3 \
  webkit2gtk-4.1 \
  pkgconf \
  gcc \
  curl \
  unzip

echo "==> pnpm"
if ! command -v pnpm >/dev/null 2>&1; then
  sudo npm install -g pnpm
fi

echo "==> Wails CLI"
if ! command -v wails >/dev/null 2>&1; then
  go install github.com/wailsapp/wails/v2/cmd/wails@latest
  export PATH="$PATH:$(go env GOPATH)/bin"
  echo "export PATH=\"\$PATH:$(go env GOPATH)/bin\"" >> "$HOME/.bashrc"
fi

echo
echo "==> Проверка"
go version || true
node -v || true
pnpm -v || true
wails version || true

echo
echo "==> Готово. Дальше:"
echo "    bash scripts/clone-upstream.sh"
