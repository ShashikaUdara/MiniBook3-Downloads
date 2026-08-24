# MiniBook3-Downloads (Versions warehouse)

Local checkout of **[MiniBook3-Downloads](https://github.com/ShashikaUdara/MiniBook3-Downloads)** — installer **pointers**, channel feeds, and operator docs.

**Big binaries** live on [GitHub Releases](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases). They are never committed here.

---

## Do not move (auto-update)

POS tills read these paths on `main` via raw.githubusercontent.com. **Changing or renaming them breaks Check for Updates.**

| Path | Role |
|------|------|
| `windows/latest/stable/latest.txt` | Windows stable channel version (one line) |
| `windows/latest/stable/channel-manifest.json` | Windows channel metadata |
| `windows/latest/…` | Windows manifests / install.ps1 mirrors |
| `windows/vX.Y.Z/…` | Versioned Windows pointer tree |
| `linux/latest/stable/latest.txt` | Linux stable channel version |
| `linux/latest/…` · `linux/vX.Y.Z/…` | Linux equivalents |

See [`docs/layout.md`](./docs/layout.md).

---

## Live channels (today)

| Channel | Pointer file | Current |
|---------|----------------|---------|
| Windows stable | `windows/latest/stable/latest.txt` | **1.0.3** (keep until v1.0.4 assets HTTP 200) |
| Linux stable | `linux/latest/stable/latest.txt` | **1.0.2** (promote with matching Linux assets) |

**Next ship:** **v1.0.4** — production licence harden + admin password reset.

---

## Docs map

| Path | What it is |
|------|------------|
| [`docs/releases/`](./docs/releases/) | Release notes + publish checklists (all waves) |
| [`docs/releases/RELEASE_NOTES_v1.0.4.md`](./docs/releases/RELEASE_NOTES_v1.0.4.md) | **v1.0.4** notes — Linux + Windows + one-line install |
| [`docs/releases/PUBLISH_v1.0.4.md`](./docs/releases/PUBLISH_v1.0.4.md) | Upload order for this wave |
| [`docs/guide.md`](./docs/guide.md) | How GitHub Releases hosting works |
| [`docs/layout.md`](./docs/layout.md) | What may move vs what must stay |
| `github-release-assets/` | Small files ready to drag onto a GitHub Release |
| `staging/` | Local binary tray (gitignored) — never push |
| `test-data/` | Sample CSVs for demos |

Canonical product playbook: `MiniBook3/docs/release.md`.
