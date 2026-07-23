# WebKit on CachyOS / Arch

## English

**Symptom**

```text
Package webkit2gtk-4.0 was not found
error: target not found: webkit2gtk
```

**Cause**

Modern Arch/CachyOS no longer ship `webkit2gtk` (ABI 4.0) in the main repos.  
They ship **`webkit2gtk-4.1`** only.

Wails defaults to 4.0 unless you pass **`-tags webkit2_41`**.

**Fix**

```bash
sudo pacman -S --needed webkit2gtk-4.1 gtk3
pkg-config --exists webkit2gtk-4.1 && echo OK

# then rebuild with updated scripts (auto-detects 4.1)
bash scripts/build-lite.sh
```

Expected log line:

```text
==> WebKit: 4.1 (tag webkit2_41)
==> Tags: sqliteonly,webkit2_41
```

Do **not** install a non-existent `webkit2gtk` package from official repos.

---

## Русский

На CachyOS пакета `webkit2gtk` (4.0) нет. Нужен `webkit2gtk-4.1` и тег сборки `webkit2_41`.  
Скрипт `build-lite.sh` добавляет его сам.
