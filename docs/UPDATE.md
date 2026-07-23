# Update system

Quality design has **three layers**.

## Layer 1 — End users (portable USB / AppImage)

```bash
bash update.sh
# Russian messages:
LANG_UI=ru bash update.sh
```

| Does | Does **not** |
|------|----------------|
| Checks **this repo** GitHub Releases | Watch upstream GoClaw git by itself |
| Downloads newer `GoClaw-Lite-x86_64.AppImage` | Rebuild from source |
| Backs up previous file as `.bak-TIMESTAMP` | Need pacman / Go / Wails |

Stamp file: `dist/.goclaw-lite-version` (+ optional `dist/VERSION.json`).

---

## Layer 2 — Maintainers on CachyOS / Arch (rebuild from upstream)

When **official** [nextlevelbuilder/goclaw](https://github.com/nextlevelbuilder/goclaw) moves ahead:

```bash
# only check
bash scripts/check-upstream.sh
echo $?
# 0 = up to date, 2 = rebuild recommended

# rebuild AppImage from latest upstream dev
bash scripts/rebuild-from-upstream.sh

# force rebuild even if SHA matches
FORCE=1 bash scripts/rebuild-from-upstream.sh
```

Flow:

1. `check-upstream.sh` compares `dist/VERSION.json` → remote `dev` commit
2. `clone-upstream.sh` refreshes sources
3. `build-lite.sh` + `package-appimage.sh`
4. `write-version-stamp.sh` writes packaging tag + upstream SHA

Then **publish** a GitHub Release so Layer 1 users receive it:

```bash
gh release create lite-<sha>-<date> dist/GoClaw-Lite-x86_64.AppImage \
  --title "GoClaw Lite <tag>" \
  --notes "Rebuilt from upstream commit <sha>"
```

---

## Layer 3 — CI watch (notification)

Workflow `.github/workflows/watch-upstream.yml`:

- runs on a schedule + manual dispatch
- fetches latest upstream commit
- uploads `upstream-status.json` artifact
- does **not** promise a full AppImage on Ubuntu (WebKit/Wails is fragile in CI)
- real portable builds stay on **CachyOS/Arch** (`rebuild-from-upstream.sh`) or a successful local package job

---

## Recommended maintainer loop

```text
weekly / when needed
  → bash scripts/check-upstream.sh
  → if exit 2: bash scripts/rebuild-from-upstream.sh
  → gh release create ...
  → users run: bash update.sh
```

---

## Русский (кратко)

- **Пользователь флешки:** `bash update.sh` — качает готовый AppImage из **наших** Releases.
- **Новая версия в официальном GoClaw:** на CachyOS `bash scripts/rebuild-from-upstream.sh`, потом выложить Release.
- **CI** только **проверяет** upstream; полноценная сборка AppImage — на Arch/CachyOS.
