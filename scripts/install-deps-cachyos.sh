#!/usr/bin/env bash
# Install build dependencies for GoClaw Lite on CachyOS / Arch
set -euo pipefail

echo "==> Установка зависимостей для GoClaw Lite (CachyOS/Arch)"

if ! command -v pacman >/dev/null 2>&1; then
  echo "==> Ошибка: нужен pacman (CachyOS/Arch)"
  exit 1
fi

echo "==> Системные пакеты"
# Важно:
# - webkit2gtk     → даёт webkit2gtk-4.0.pc (нужен Wails)
# - webkit2gtk-4.1 → новая ветка, одной её недостаточно
sudo pacman -Syu --needed --noconfirm \
  base-devel \
  git \
  go \
  nodejs \
  npm \
  gtk3 \
  webkit2gtk \
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
export PATH="$PATH:$(go env GOPATH)/bin"
if ! command -v wails >/dev/null 2>&1; then
  go install github.com/wailsapp/wails/v2/cmd/wails@latest
fi

# ensure PATH for current shell
export PATH="$PATH:$(go env GOPATH)/bin"
if ! grep -q 'go env GOPATH' "$HOME/.bashrc" 2>/dev/null; then
  echo 'export PATH="$PATH:$(go env GOPATH)/bin"' >> "$HOME/.bashrc"
fi

echo
echo "==> Проверка pkg-config webkit"
pkg-config --exists webkit2gtk-4.0 && echo "  webkit2gtk-4.0: OK" || echo "  webkit2gtk-4.0: НЕТ"
pkg-config --exists webkit2gtk-4.1 && echo "  webkit2gtk-4.1: OK" || echo "  webkit2gtk-4.1: НЕТ"

echo
echo "==> Проверка инструментов"
go version || true
node -v || true
pnpm -v || true
wails version || true

echo
echo "==> Готово. Дальше:"
echo "    bash scripts/clone-upstream.sh"
