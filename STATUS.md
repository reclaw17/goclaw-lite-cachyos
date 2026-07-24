# Status — GoClaw Lite packaging track

**Track status: FINALIZED for personal use (v0.1 line)**  
Scope of this repo: **portable Linux AppImage packaging** only — not the full “USB agent / skills / OpenWrt” project.

## Current releases

| Tag | Notes |
|-----|--------|
| [lite-linux-14](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/lite-linux-14) | CI build (prefer this for `--update` path) |
| [v0.1.0-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.1.0-cachyos) | First manual CachyOS build |

Prefer the **newest** Release asset when updating.

## Tails checklist

| # | Tail | Status | Resolution |
|---|------|--------|------------|
| 1 | `v0.1.0` AppImage built **before** embedded `--update` | **Closed** | Newer CI release `lite-linux-14` uses current `package-appimage.sh` (AppRun with `--update`). Use latest Release. |
| 2 | CI not proven | **Closed** | Build AppImage runs **success** on `ubuntu-24.04`. Workflow permissions: **Read and write**. Artifact + Release publish work when permissions are set. |
| 3 | Full USB-agent project (skills, Fabric, OpenWrt, Win11…) | **Out of scope** | Separate product track. This repo = GoClaw Lite shell only. |
| 4 | Windows / macOS AppImage | **Out of scope** | This repo targets **Linux x86_64** (Arch/CachyOS first). Upstream has its own desktop channels. |
| 5 | AppImageUpdate / zsync deltas | **Deferred** | Not needed for v0.1. Current `--update` / `update.sh` is full-file replace. Revisit only if releases become frequent/large. |
| 6 | CI build ≠ native CachyOS binary | **Accepted** | CI is the easy path. Native `bash setup-all.sh` remains the gold standard if something GUI/WebKit-specific breaks on CachyOS. |

## What “finalized” means

Users can:

1. Download AppImage from [Releases](https://github.com/reclaw17/goclaw-lite-cachyos/releases) or Actions Artifacts  
2. Run it on Arch/CachyOS  
3. Update via `./AppImage --update` or `bash update.sh`  
4. Optionally rebuild locally or via **Actions → Build AppImage**  

Maintainers can:

- `bash rebuild-from-upstream.sh` when official GoClaw moves  
- rely on **Watch upstream** workflow / manual CI  

## Not finalized here

Anything beyond packaging: agent skills, offline docs pack, Fabric sidecar, OpenWrt playbooks, Windows portable stack — belongs to the broader setup-my-pc effort, not this repo.
