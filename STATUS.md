# Status

**Latest public AppImage:** [v0.2.0-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.2.0-cachyos)

**Track:** finalized for public **community** use (packaging only).

## Honest positioning

| Topic | Statement |
|-------|-----------|
| Official? | **No** — not a nextlevelbuilder product |
| Target | Arch Linux, CachyOS, Linux x86_64 AppImage |
| Secrets in release? | **No** — keys only on user machine |
| Support | Best effort; app bugs → [upstream GoClaw](https://github.com/nextlevelbuilder/goclaw) |
| Log noise (`list_tenants_failed`, SQLite settings scan) | Upstream Lite/SQLite behavior, not packaging corruption |
| License (scripts) | [MIT](LICENSE) |
| Repo | Public · Issues enabled |

## Working

- Native CachyOS build (`sqliteonly`, `webkit2_41`)
- CI Build AppImage on Ubuntu 24.04
- `update.sh` + AppImage `--update`
- EN default script UI, optional RU
