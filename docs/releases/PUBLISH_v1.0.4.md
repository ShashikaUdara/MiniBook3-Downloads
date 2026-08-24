# Publish MiniBook3 v1.0.4

This sheet is the warehouse checklist. Eng has bumped `version.py` to **1.0.4** and written multi-OS notes. You build installers, upload heavy binaries by hand, then flip pointers.

**Do not** commit `*.exe`, `*.zip`, or large tarballs. **Do not** push a platform’s `latest.txt` until that platform’s public assets return **HTTP 200**.

**Git default branch must be `main`** (D127). POS Check now reads `raw.githubusercontent.com/…/MiniBook3-Downloads/main/…`. Pushing only to another branch leaves shops on HTTP 404.

**Notes file (GitHub Release body):** [`RELEASE_NOTES_v1.0.4.md`](./RELEASE_NOTES_v1.0.4.md)  
**Layout rules:** [`../layout.md`](../layout.md)

---

## HTTP 200 smoke (2026-08-24 18:30 +0530 · **U9 re-probe 21:40 +0530**)

Probed against live GitHub Release tag [`v1.0.4`](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/tag/v1.0.4). Remote `SHA256SUMS.txt` matches the rebuilt Linux tray.

**U9 command:** `make smoke-u9-windows-parity` → exit **2** (Blocked) until Windows binaries are uploaded; then `REQUIRE_LIVE=1` must exit **0** before flipping `windows/latest`.

### Linux — **green** (ready to promote channel)

| Asset | HTTP | Notes |
|-------|-----:|-------|
| Release tag page | **200** | Published (not draft) |
| `minibook3-1.0.4-linux-x86_64.tar.gz` | **200** | `Content-Length: 384296328` |
| `minibook3-1.0.4-linux-x86_64.AppImage` | **200** | `Content-Length: 239244480` |
| `minibook3_1.0.4_amd64.deb` | **200** | `Content-Length: 186007164` |
| `SHA256SUMS.txt` | **200** | Matches staged slim sums |
| `install.sh` | **200** | Dry-run resolves v1.0.4 tarball + sums |
| `RELEASE_NOTES_v1.0.4.md` | **200** | Release body asset |
| `/releases/latest/download/install.sh` | **200** | GitHub “latest” = this tag (Linux OK) |

```bash
curl -fsSI https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/minibook3-1.0.4-linux-x86_64.tar.gz
curl -fsSI https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/install.sh
curl -fsSL https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/install.sh | bash -s -- --dry-run --version 1.0.4
```

### Windows — **not ready** (keep aisle on **1.0.3**)

| Asset | HTTP |
|-------|-----:|
| `minibook3-1.0.4-win64-setup.exe` | **404** |
| `minibook3-1.0.4-win64-portable.zip` | **404** |
| `install.ps1` | **404** |

**Do not** flip `windows/latest/stable/latest.txt` and **do not** paste Windows 1.0.4 Admin download rows until those three return **200**.

### Optional assets (not blocking Linux)

| Asset | HTTP | Note |
|-------|-----:|------|
| `download-manifest.json` | 404 | Nice-to-have; install uses `SHA256SUMS` |
| `stable-latest.txt` | 404 | Channel pointer lives in git raw, not required on the Release |

### Raw channel (before warehouse git push)

| Path on `main` | Live today | Local tree after this sheet |
|----------------|------------|-------------------------------|
| `linux/latest/stable/latest.txt` | **1.0.2** | **1.0.4** (ready to commit + push) |
| `windows/latest/stable/latest.txt` | **1.0.3** | **1.0.3** (unchanged) |
| `linux/v1.0.4/*` | 404 until push | Present locally |

---

## Staged locally — Linux from `Linux-MiniBook3/release`

**Rebuilt same day (evening):** Linux **1.0.4** (not 1.0.5) after POS till changes. Checksums below are the live GitHub values.

| Location | Contents |
|----------|----------|
| `linux/v1.0.4/` | `install.sh`, versioned `download-manifest.json`, slim `SHA256SUMS.txt` |
| `linux/latest/` | Channel flipped locally to **1.0.4** (manifests + slim sums + `install.sh`) |
| `github-release-assets/v1.0.4/` | Small upload pack |
| `staging/v1.0.4/` | Binaries — **gitignored**; already uploaded |

**Current Linux SHA-256 (basename form — live):**

```
97c972e22d5d5b44f90f82710272f89cff0652da46e139a3e473a306e1a9be05  minibook3-1.0.4-linux-x86_64.tar.gz
9babbea8c6abb4c08a1a265bab8b169a39d98b3b57b667b4149ec62dadaa5049  minibook3-1.0.4-linux-x86_64.AppImage
6c206792f5cafd4faada9bd243df6632908454e5361d2a9ffe7a9e05407133c0  minibook3_1.0.4_amd64.deb
92ca95f8a3c44a105a4e3780753fe9ccb055aba0b2d908e527942a91b6ca4559  install.sh
```

---

## Order (safety rule)

1. Confirm production API has admin-password routes (`POST /api/minibook3/admin-password/request-token`).
2. Build → upload → **HTTP 200 per platform**.
3. **Linux now:** commit + push `linux/v1.0.4/` + `linux/latest/**` so raw `latest.txt` becomes **1.0.4**.
4. Admin → Releases → slug `minibook3-v1-0-4` with **Linux** versioned URLs; keep Windows rows on **1.0.3** until Windows 200.
5. Upload Windows assets → re-smoke → then flip `windows/latest/stable/latest.txt` to `1.0.4` and add Windows Admin rows.
6. Only then update MiniBook3 website seed / fallback (`releases.ts` / `releases_data.py` / `init.sql`).

Existing shops read:

`https://raw.githubusercontent.com/ShashikaUdara/MiniBook3-Downloads/main/windows/latest/stable/latest.txt`  
`https://raw.githubusercontent.com/ShashikaUdara/MiniBook3-Downloads/main/linux/latest/stable/latest.txt`

If `latest.txt` says `1.0.4` before the zip/tarball is on GitHub, **Check for Updates** 404s. Upload first, push git second. **Linux upload is done; Linux pointer push is next.**

---

## GitHub “latest” flag

`v1.0.4` is currently GitHub’s latest release (Linux assets attached). That is OK for Linux one-line `/releases/latest/download/install.sh`.

Windows one-line `/latest/download/install.ps1` will **404** until Windows assets are attached — keep documenting **versioned** Windows URLs and leave Admin Windows buttons on **1.0.3**.

---

## 1. Attach these files to GitHub Release `v1.0.4`

### Binaries

| File | Role | Status |
|------|------|--------|
| `minibook3-1.0.4-linux-x86_64.tar.gz` | Linux main payload | **Live 200** |
| `minibook3_1.0.4_amd64.deb` | Optional | **Live 200** |
| `minibook3-1.0.4-linux-x86_64.AppImage` | Optional | **Live 200** |
| `minibook3-1.0.4-win64-setup.exe` | Windows shop install | **404 — pending** |
| `minibook3-1.0.4-win64-portable.zip` | Windows portable | **404 — pending** |

### Small files

| GitHub asset name | Status |
|-------------------|--------|
| `SHA256SUMS.txt` | **Live 200** (Linux entries; append Windows when built) |
| `install.sh` | **Live 200** |
| `RELEASE_NOTES_v1.0.4.md` | **Live 200** |
| `install.ps1` | **404 — pending** |
| `download-manifest.json` | Optional / not blocking |

---

## 2. Public URLs — Linux checklist (verified)

```
https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/minibook3-1.0.4-linux-x86_64.tar.gz
https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/minibook3_1.0.4_amd64.deb
https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/minibook3-1.0.4-linux-x86_64.AppImage
https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/SHA256SUMS.txt
https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/install.sh
https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/RELEASE_NOTES_v1.0.4.md
```

Windows (still expect 404):

```
https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/minibook3-1.0.4-win64-setup.exe
https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/minibook3-1.0.4-win64-portable.zip
https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/install.ps1
```

---

## 3. After Linux 200s — Admin + auto-update (this step)

1. Push warehouse git so raw `linux/latest/stable/latest.txt` = `1.0.4`.
2. Admin → Releases → create / update **MiniBook3 v1.0.4** / slug `minibook3-v1-0-4` / version `1.0.4`.
3. Paste **versioned** Linux `/download/v1.0.4/…` URLs (never rely only on `/latest/download/…` in Admin).
4. Keep Windows Admin packages on **1.0.3** until Windows 200.
5. Mark Linux row published when smoke passes; do not claim Windows 1.0.4 yet.
6. Website seed / fallback stays on previous until you intentionally cut the storefront.

Rollback Linux: set `linux/latest/stable/latest.txt` back to `1.0.2` (or prior live). Keep old binaries ≥ 30 days.

---

## 4. Smoke (fresh VM)

### Linux (ready)

- [x] Public Linux assets HTTP **200** + checksum match
- [x] `install.sh --dry-run --version 1.0.4` resolves tarball + `SHA256SUMS`
- [ ] Warehouse `main` push so raw `latest.txt` = **1.0.4**
- [ ] Fresh Linux VM: install → About **1.0.4** · cloud host production
- [ ] Admin password reset reaches `api-minibook3.zolestio.com`

### Windows (blocked on upload)

- [ ] Setup `.exe` + portable zip + `install.ps1` HTTP **200**
- [ ] Flip `windows/latest/stable/latest.txt` to `1.0.4`
- [ ] Fresh Windows VM: About **1.0.4**
- [ ] `/downloads` shows Windows 1.0.4 in a private window

Canonical playbook: `MiniBook3/docs/release.md` · Windows hand-off: `MiniBook3/docs/team-notes.md` · plan: `MiniBook3/docs/adhocs.md` **W57** / **D125**.
