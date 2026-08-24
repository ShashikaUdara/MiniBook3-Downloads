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
| Linux stable | `linux/latest/stable/latest.txt` | **1.0.2** (do not flip until v1.0.4 Linux URLs HTTP 200) |

**Next ship:** **v1.0.4** (same tag — Linux rebuild replaced 2026-08-24 evening). Staged in `linux/v1.0.4/`, `github-release-assets/v1.0.4/`, `staging/v1.0.4/`. Windows still pending. Auto-update pointers **not** flipped yet.

---

## Docs map

| Path | What it is |
|------|------------|
| [`docs/releases/`](./docs/releases/) | Release notes + publish checklists (all waves) |
| [`docs/releases/RELEASE_NOTES_v1.0.4.md`](./docs/releases/RELEASE_NOTES_v1.0.4.md) | **v1.0.4** notes — Linux + Windows + one-line install |
| [`docs/releases/PUBLISH_v1.0.4.md`](./docs/releases/PUBLISH_v1.0.4.md) | Upload order for this wave |
| [`linux/v1.0.4/`](./linux/v1.0.4/) | Linux pointer files for this version (commit-safe) |
| [`github-release-assets/v1.0.4/`](./github-release-assets/v1.0.4/) | Small Linux files ready to drag onto GitHub Release |
| [`staging/v1.0.4/`](./staging/v1.0.4/) | Binary tray (gitignored) — upload from here |
| [`docs/guide.md`](./docs/guide.md) | How GitHub Releases hosting works |
| [`docs/layout.md`](./docs/layout.md) | What may move vs what must stay |
| `test-data/` | Sample CSVs for demos |

Canonical product playbook: `MiniBook3/docs/release.md`.
