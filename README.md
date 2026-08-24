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

| Channel | Pointer file | Public GitHub assets | Local tree | Remote `main` (raw) |
|---------|----------------|----------------------|------------|---------------------|
| Windows stable | `windows/latest/stable/latest.txt` | **v1.0.3** live · **v1.0.4 Windows still 404** | **1.0.3** | **1.0.3** |
| Linux stable | `linux/latest/stable/latest.txt` | **v1.0.4 Linux HTTP 200** | **1.0.4** (ready to push) | Still **1.0.2** until warehouse git push |

**Cutover (2026-08-24 smoke):** Linux tarball / AppImage / `.deb` / `install.sh` / `SHA256SUMS` / notes all **200** on tag [`v1.0.4`](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/tag/v1.0.4). Windows setup / portable / `install.ps1` still **404** — do not flip Windows pointer or Admin Windows 1.0.4 rows yet.

See [`docs/releases/PUBLISH_v1.0.4.md`](./docs/releases/PUBLISH_v1.0.4.md).

---

## Docs map

| Path | What it is |
|------|------------|
| [`docs/releases/`](./docs/releases/) | Release notes + publish checklists (all waves) |
| [`docs/releases/RELEASE_NOTES_v1.0.4.md`](./docs/releases/RELEASE_NOTES_v1.0.4.md) | **v1.0.4** notes — Linux + Windows + one-line install |
| [`docs/releases/PUBLISH_v1.0.4.md`](./docs/releases/PUBLISH_v1.0.4.md) | Upload order + **HTTP 200 smoke log** |
| [`linux/v1.0.4/`](./linux/v1.0.4/) | Linux pointer files for this version (commit-safe) |
| [`github-release-assets/v1.0.4/`](./github-release-assets/v1.0.4/) | Small Linux files for GitHub Release |
| [`staging/v1.0.4/`](./staging/v1.0.4/) | Binary tray (gitignored) |
| [`docs/guide.md`](./docs/guide.md) | How GitHub Releases hosting works |
| [`docs/layout.md`](./docs/layout.md) | What may move vs what must stay |
| `test-data/` | Sample CSVs for demos |

Canonical product playbook: `MiniBook3/docs/release.md`.
