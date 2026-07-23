# Auto-update

## English

Portable AppImage updates are fetched from **GitHub Releases** of this repository.

### Update now

```bash
bash update.sh
```

What it does:

1. Reads `https://api.github.com/repos/reclaw17/goclaw-lite-cachyos/releases/latest`
2. Compares tag with local `dist/.goclaw-lite-version` (or next to the AppImage)
3. If newer — downloads `GoClaw-Lite-x86_64.AppImage`
4. Keeps a `.bak-TIMESTAMP` copy of the previous file
5. Marks the new version in `.goclaw-lite-version`

Default UI language: **English**. Russian:

```bash
LANG_UI=ru bash update.sh
```

### After a manual download

If you downloaded the AppImage by hand, create a stamp so the updater knows the version:

```bash
echo 'v0.1.0-cachyos' > dist/.goclaw-lite-version
# or next to the AppImage file
```

After building from source you can stamp with:

```bash
bash scripts/write-version-stamp.sh v0.1.0-cachyos
```

### Limits

- Updates **this packaging repo’s AppImage**, not upstream GoClaw git tags by themselves
- Needs network access to GitHub
- Does not patch a running process — close the app, run `update.sh`, start again

---

## Русский

```bash
bash update.sh
# или
LANG_UI=ru bash update.sh
```

Скрипт сверяет тег latest-релиза с `.goclaw-lite-version` и при необходимости скачивает новый AppImage (со старым `.bak-...`).
