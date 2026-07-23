# Start here

Portable **GoClaw Lite** for **Arch Linux** and **CachyOS**.

## English

### A) Download ready AppImage

1. [Releases](https://github.com/reclaw17/goclaw-lite-cachyos/releases)
2. Download `GoClaw-Lite-x86_64.AppImage`
3. Run:

```bash
chmod +x GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage
```

Update later:

```bash
./GoClaw-Lite-x86_64.AppImage --update
```

### B) Build on your CachyOS / Arch PC

```bash
git clone https://github.com/reclaw17/goclaw-lite-cachyos.git
cd goclaw-lite-cachyos
bash setup-all.sh
```

### C) Build in the cloud (CI) — no local tools

See **[docs/CI.md](docs/CI.md)**:

1. Open **Actions** on GitHub  
2. **Build AppImage** → **Run workflow**  
3. Download the artifact / Release  

---

## Русский

### A) Скачать готовый файл

[Releases](https://github.com/reclaw17/goclaw-lite-cachyos/releases) → `GoClaw-Lite-x86_64.AppImage`

```bash
chmod +x GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage
./GoClaw-Lite-x86_64.AppImage --update   # позже
```

### B) Собрать у себя (CachyOS/Arch)

```bash
bash setup-all.sh
```

### C) Собрать в интернете (CI)

Не нужно ставить Go и Wails. Инструкция простыми словами: **[docs/CI.md](docs/CI.md)**.
