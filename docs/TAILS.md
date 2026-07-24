# Tails (honest backlog) — closed for Lite track

Step-by-step closure of items called out during development.

## 1. Old AppImage without `--update`

**Was:** First `v0.1.0-cachyos` packaged before AppRun self-update existed.  
**Now:** Rebuild pipeline embeds `--update` / `--check-update`.  
**You:** install from the **latest** Release (e.g. `lite-linux-14` or newer), not only `v0.1.0`.

```bash
./GoClaw-Lite-x86_64.AppImage --check-update
./GoClaw-Lite-x86_64.AppImage --update
```

## 2. CI red on “Publish release”

**Was:** `Resource not accessible by integration`.  
**Now:** Repo **Settings → Actions → General → Workflow permissions → Read and write** (no need for “create PR” checkbox).  
**Proof:** later **Build AppImage** runs concluded **success** and published `lite-linux-14`.

## 3. Broader “agent from USB” product

**Was:** Confused with this packaging repo.  
**Now:** Explicit boundary — this repo is **GoClaw Lite AppImage for Arch/CachyOS only**.

## 4. Windows

**Decision:** not in this repository. Use upstream GoClaw desktop for Windows if needed.

## 5. AppImageUpdate / zsync

**Decision:** deferred. Full-file `--update` is enough for current release cadence.

## 6. CI vs CachyOS native

**Decision:** accept both paths.

| Path | Role |
|------|------|
| Actions / Releases | Default for beginners |
| `bash setup-all.sh` on CachyOS | Fallback / highest trust on your OS |

---

When all rows above are Closed / Out of scope / Deferred / Accepted, the **Lite packaging track is finalizable**.
