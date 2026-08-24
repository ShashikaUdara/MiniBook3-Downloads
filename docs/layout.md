# Warehouse layout — what may move

This repo has two jobs:

1. **Auto-update feeds** for installed MiniBook3 tills (tiny text/JSON under `windows/` and `linux/`).
2. **Operator docs** for humans shipping a version (notes, publish sheets, guides).

Only (2) should be rearranged. Touching (1) without a coordinated POS + CDN plan breaks shops.

---

## Frozen paths (do not rename / relocate)

POS code resolves updates from:

`https://raw.githubusercontent.com/ShashikaUdara/MiniBook3-Downloads/main/…`

Canonical helpers: `Linux-MiniBook3` / `Windows-MiniBook3` → `minibook3.infrastructure.updates.cdn_paths`.

| Must stay | Why |
|-----------|-----|
| `windows/latest/stable/latest.txt` | Windows in-app update version line |
| `windows/latest/stable/channel-manifest.json` | Channel metadata |
| `windows/latest/download-manifest.json` | Manifest fallback |
| `windows/latest/install.ps1` | Optional raw bootstrap mirror |
| `windows/v{version}/…` | Versioned Windows pointers |
| `linux/latest/stable/latest.txt` | Linux in-app update version line |
| `linux/latest/…` · `linux/v{version}/…` | Linux equivalents |
| `github-release-assets/v{version}/` | Optional upload tray for small Release assets |

**Rule:** upload binaries to GitHub Releases **first** (HTTP 200). Only then push a new value into `*/latest/stable/latest.txt`.

---

## Safe to organize

| Path | Contents |
|------|----------|
| `docs/releases/` | `RELEASE_NOTES_v*.md`, `PUBLISH_v*.md` |
| `docs/guide.md` · `docs/feasibility.md` · `docs/layout.md` | Human runbooks |
| `README.md` | Repo map |
| `test-data/` | Demo CSVs |
| `staging/` | Local binaries (gitignored) |

---

## GitHub Release assets vs git tree

| Lives on GitHub Release tag | Lives in this git repo |
|-----------------------------|-------------------------|
| `.exe` · `.zip` · `.tar.gz` · `.deb` · `.AppImage` | Never (see `.gitignore`) |
| `install.sh` · `install.ps1` · `SHA256SUMS.txt` · notes | Also mirrored under `windows/` / `linux/` / `github-release-assets/` / `docs/releases/` |

Paste **versioned** Release URLs into Admin → Downloads (`/download/v1.0.4/…`), not `/latest/download/…`.
