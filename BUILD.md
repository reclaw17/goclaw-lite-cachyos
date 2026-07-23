# Build + AppImage

## На машине сборки (CachyOS / Arch)

```bash
git clone https://github.com/reclaw17/goclaw-lite-cachyos.git
cd goclaw-lite-cachyos

bash scripts/install-deps-cachyos.sh
bash scripts/clone-upstream.sh
bash scripts/build-lite.sh
bash scripts/package-appimage.sh
```

Артефакт:
```text
dist/GoClaw-Lite-x86_64.AppImage
```

## На флешке / другом ПК

```bash
chmod +x GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage
```

Если FUSE ругается:
```bash
./GoClaw-Lite-x86_64.AppImage --appimage-extract-and-run
```
