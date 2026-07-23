# Updates

## Can update live inside the AppImage?

**Yes — after you rebuild/republish an AppImage with the new launcher.**

The AppImage **AppRun** wrapper supports:

```bash
./GoClaw-Lite-x86_64.AppImage --check-update
./GoClaw-Lite-x86_64.AppImage --update
./GoClaw-Lite-x86_64.AppImage --help-update
```

`--update` talks to **this packaging repo’s** GitHub Releases, downloads a newer
`GoClaw-Lite-x86_64.AppImage`, backs up the old file, and replaces the one on disk.

Optional notice on every start (off by default):

```bash
GOCLAW_LITE_AUTO_UPDATE=1 ./GoClaw-Lite-x86_64.AppImage
```

> Note: the AppImage already published as `v0.1.0-cachyos` was built **before**
> this wrapper. Rebuild + publish a new release so users get embedded `--update`.

---

## Three layers

```text
Official GoClaw (nextlevelbuilder/goclaw)
        │  rebuild-from-upstream / CI
        ▼
Our GitHub Releases (AppImage)
        │  AppImage --update   OR   bash update.sh
        ▼
USB / PC
```

| Method | Inside AppImage? | Rebuilds upstream? |
|--------|------------------|--------------------|
| `./AppImage --update` | **Yes** | No — downloads our Release |
| `bash update.sh` | No (repo script) | No |
| `bash rebuild-from-upstream.sh` | No | **Yes** (needs build PC) |
| CI `watch-upstream.yml` | No | **Yes** (publishes Release) |

Upstream source changes still require a **rebuild + new Release** first.
Embedded update only distributes that Release to the USB copy.

---

## Russian

**Да, можно вшить в AppImage** — через обёртку `AppRun`:

```bash
./GoClaw-Lite-x86_64.AppImage --update
```

Это обновит **файл AppImage** с наших Releases.  
Новую версию **официального** GoClaw по-прежнему нужно сначала **пересобрать** (`rebuild-from-upstream` / CI) и выложить в Release.

Старый релиз `v0.1.0-cachyos` ещё без этой обёртки — нужна одна пересборка и новый релиз.
