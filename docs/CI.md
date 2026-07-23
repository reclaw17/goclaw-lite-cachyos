# CI — automatic build (simple guide)

## What is CI?

**CI** = a robot on GitHub’s computers.

You click a button (or wait for a schedule). The robot:

1. Downloads official GoClaw source code  
2. Builds **GoClaw Lite**  
3. Packs **AppImage**  
4. (optional) puts it into **Releases** for download / `--update`

You do **not** need to install Go/Wails on your PC for that path.

---

## How to start a build (beginner)

1. Open: https://github.com/reclaw17/goclaw-lite-cachyos/actions  
2. Left: **Build AppImage**  
3. Button **Run workflow**  
4. Leave “publish release” checked if you want a new Release  
5. Wait until the job is green  
6. Download:
   - from the job **Artifacts**, or  
   - from **Releases** if publishing was enabled  

---

## Two workflows

| Name | When | What |
|------|------|------|
| **Build AppImage** | Manual button (and sometimes on script changes) | Build + optional Release |
| **Watch upstream GoClaw** | Mon/Thu morning + manual | If official GoClaw `dev` has a new commit → build + Release `upstream-XXXX` |

---

## After CI published a Release

On your PC / USB:

```bash
./GoClaw-Lite-x86_64.AppImage --update
# or
bash update.sh
```

---

## If the job is red (failed)

1. Open the failed job → expand the red step  
2. Copy the error text  
3. Common fixes already in scripts:
   - Ubuntu uses **webkit2gtk 4.1** → tag `webkit2_41`
   - AppImage tool uses `APPIMAGE_EXTRACT_AND_RUN=1` (no FUSE)  

Local quality build on CachyOS is still the gold standard:

```bash
bash rebuild-from-upstream.sh
```

---

## Русский

**CI** — это автосборка на серверах GitHub.

1. Зайди в **Actions**  
2. **Build AppImage** → **Run workflow**  
3. Дождись зелёной галочки  
4. Скачай AppImage из Artifacts или Releases  

Обновление на флешке потом: `./GoClaw-Lite-x86_64.AppImage --update`
