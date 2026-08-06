# MiniBook3 downloads on GitHub — step-by-step guide

> **Goal:** Host installers on **GitHub Releases** (free) instead of GCS.  
> **Repo (local):** `Versions-MiniBook3-Downloads`  
> **Repo (GitHub):** `https://github.com/ShashikaUdara/MiniBook3-Downloads`  
> **Rule:** Big installers go on a **Release**. Git only holds tiny docs / pointers.  
> **See also:** [`feasibility.md`](./feasibility.md) · Zolestio free-era host plan [`zolestio.v2/docs/host.md`](../../zolestio.v2/docs/host.md) (SQLite control-plane DB; MiniBook3/WMB3 POS DBs unchanged)

---

## Flow (big picture)

```text
1. Build MiniBook3 release artifacts
2. Clean Versions-MiniBook3-Downloads (no huge git commits)
3. Commit & push tiny files only (README, docs, .gitignore)
4. Create GitHub Release tag (e.g. v1.0.2)
5. Upload installer files as Release assets
6. Paste asset URLs into Zolestio Admin → Downloads
7. Smoke-test download links
```

---

## 0. One-time setup

### 0.1 Tools you need
- Git
- GitHub account (logged in)
- Optional: [GitHub CLI](https://cli.github.com/) `gh` (easier uploads)
- Built MiniBook3 packages under `MiniBook3/release/`

### 0.2 Fix `.gitignore` (do this first)

Replace `.gitignore` so binaries never get committed:

```gitignore
# Never commit installers or unpacked builds
*.tar.gz
*.AppImage
*.deb
*.exe
*.dmg
*.zip

# Unpacked PyInstaller / install trees
**/minibook3-*-linux/
**/MiniBook3/
**/_internal/

# Local scratch
linux/**/linux/
*.log
.DS_Store
```

### 0.3 Confirm remote

```bash
cd "/home/udara/Documents/zolestio/r&d/100_tools_challenge/Versions-MiniBook3-Downloads"
git remote -v
# expect: origin → https://github.com/ShashikaUdara/MiniBook3-Downloads.git
```

---

## 1. Build the MiniBook3 packages

Work in the **MiniBook3** app repo (not the downloads repo).

```bash
cd "/home/udara/Documents/zolestio/r&d/100_tools_challenge/MiniBook3"

# 1) Set version in src/minibook3/version.py  (example: 1.0.2)
make sync-packaging-versions

# 2) Build (Linux example)
make release-linux
# optional:
# make release-appimage
# make release-deb
make verify-checksums
```

### Files you care about (after build)

Usually under `MiniBook3/release/`:

| File | Copy to Release? |
|------|------------------|
| `minibook3-<VER>-linux-x86_64.tar.gz` | **Yes** (main Linux package) |
| `minibook3-<VER>-linux-x86_64.AppImage` | Optional |
| `minibook3_<VER>_amd64.deb` | Optional |
| `SHA256SUMS.txt` | **Yes** |
| `linux/latest/install.sh` (if present) | **Yes** (nice for one-line install) |
| `linux/latest/download-manifest.json` | Optional |
| Unpacked folder `minibook3-<VER>-linux/` | **No** |
| Windows `*-win64-setup.exe` (when built) | **Yes** |

Replace `<VER>` with your version, e.g. `1.0.2`.

---

## 2. Clean the downloads repo working tree

You may already have a huge `linux/v1.0.2/` folder. That is for **local staging / Release upload**, not for `git commit`.

```bash
cd "/home/udara/Documents/zolestio/r&d/100_tools_challenge/Versions-MiniBook3-Downloads"

# Optional: keep a staging folder ignored by git
mkdir -p staging/v1.0.2
```

### What to delete from git’s view (safe to remove if you still have `MiniBook3/release/`)

```bash
# Remove unpacked / duplicate junk if present (keeps disk free)
rm -rf linux/v1.0.2/minibook3-1.0.2-linux
rm -rf linux/v1.0.2/linux
```

Leave compressed files only if you want them locally for upload — they must stay **ignored** by git.

---

## 3. Copy only what you need for uploading

### Option A — upload straight from MiniBook3/release (simplest)

No copy required. In step 5, point `gh release upload` at:

```text
MiniBook3/release/minibook3-1.0.2-linux-x86_64.tar.gz
MiniBook3/release/SHA256SUMS.txt
…
```

### Option B — stage inside Versions repo (ignored by git)

```bash
VER=1.0.2
SRC="/home/udara/Documents/zolestio/r&d/100_tools_challenge/MiniBook3/release"
DST="/home/udara/Documents/zolestio/r&d/100_tools_challenge/Versions-MiniBook3-Downloads/staging/v${VER}"

mkdir -p "$DST"
cp -v "$SRC/minibook3-${VER}-linux-x86_64.tar.gz" "$DST/"
cp -v "$SRC/SHA256SUMS.txt" "$DST/"

# optional extras if they exist:
# cp -v "$SRC/minibook3-${VER}-linux-x86_64.AppImage" "$DST/"
# cp -v "$SRC/minibook3_${VER}_amd64.deb" "$DST/"
# cp -v "$SRC/linux/latest/install.sh" "$DST/"
```

Add to `.gitignore`:

```gitignore
staging/
```

---

## 4. Commit tiny repo files only (git)

### 4.1 What to commit

| Path | Commit? |
|------|---------|
| `README.md` | Yes |
| `docs/feasibility.md` | Yes |
| `docs/guide.md` | Yes |
| `.gitignore` | Yes |
| `*.tar.gz` / `.deb` / AppImage / unpacked trees | **Never** |

### 4.2 Commands

```bash
cd "/home/udara/Documents/zolestio/r&d/100_tools_challenge/Versions-MiniBook3-Downloads"

git status
git add .gitignore README.md docs/
git status   # confirm NO .tar.gz / .deb / AppImage

git commit -m "$(cat <<'EOF'
Add downloads docs and ignore release binaries.

EOF
)"

git push -u origin HEAD
```

If GitHub asks you to authenticate, complete login, then push again.

---

## 5. Create the GitHub Release and upload assets

### 5.A Using GitHub website (no CLI)

1. Open: `https://github.com/ShashikaUdara/MiniBook3-Downloads/releases`
2. Click **Draft a new release**
3. **Tag:** `v1.0.2` (create new tag on publish)
4. **Title:** `MiniBook3 1.0.2`
5. Description: short release notes (optional)
6. Drag & drop these files into **Attach binaries**:
   - `minibook3-1.0.2-linux-x86_64.tar.gz`
   - `SHA256SUMS.txt`
   - optional AppImage / deb / Windows setup / `install.sh`
7. Click **Publish release**
8. On the release page, right-click each asset → **Copy link address**  
   Links look like:
   ```text
   https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.2/minibook3-1.0.2-linux-x86_64.tar.gz
   ```

### 5.B Using GitHub CLI (faster)

```bash
cd "/home/udara/Documents/zolestio/r&d/100_tools_challenge/Versions-MiniBook3-Downloads"
gh auth login   # once

VER=1.0.2
# If staging:
ASSET_DIR="staging/v${VER}"
# Or use MiniBook3 release folder:
# ASSET_DIR="/home/udara/Documents/zolestio/r&d/100_tools_challenge/MiniBook3/release"

gh release create "v${VER}" \
  --title "MiniBook3 ${VER}" \
  --notes "MiniBook3 ${VER} Linux packages." \
  "${ASSET_DIR}/minibook3-${VER}-linux-x86_64.tar.gz" \
  "${ASSET_DIR}/SHA256SUMS.txt"

# Add more assets later if needed:
# gh release upload "v${VER}" path/to/AppImage path/to/deb --clobber
```

List asset URLs:

```bash
gh release view "v1.0.2" --json assets --jq '.assets[].url'
# browser download URLs:
gh release view "v1.0.2" --json assets --jq '.assets[].browserDownloadUrl'
```

---

## 6. Wire Zolestio downloads page

1. Open Zolestio **Admin → Releases**
2. Create / edit the MiniBook3 release entry for this version
3. Paste GitHub asset URLs into each platform’s **Download URL** fields  
   Example Linux tarball:
   ```text
   https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.2/minibook3-1.0.2-linux-x86_64.tar.gz
   ```
4. Save / publish
5. Open `https://zolestio.com/downloads` and click each button — file must download

---

## 7. Smoke checks (must pass)

```bash
# Replace with your real asset URL
URL="https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.2/minibook3-1.0.2-linux-x86_64.tar.gz"

curl -fsSI "$URL" | head
# expect: HTTP/2 200  (or 302 then 200)
```

Also:
- [ ] Release is **Published** (not draft)
- [ ] Repo is **Public** (private blocks anonymous downloads)
- [ ] Checksums file downloads
- [ ] Site download button hits the same URL

---

## 8. Next version checklist (repeatable)

When shipping e.g. `1.0.3`:

1. Bump `MiniBook3/src/minibook3/version.py` → build (`make release-linux` …)
2. `gh release create v1.0.3 …` with new assets  
   **or** website: new Release + upload
3. Update Zolestio Admin URLs to the new `…/download/v1.0.3/…` links
4. Do **not** delete old Releases (old links keep working)

---

## 9. Do / Don’t

| Do | Don’t |
|----|--------|
| Upload `.tar.gz` / `.exe` as **Release assets** | `git add` large installers |
| Commit only docs + `.gitignore` | Commit unpacked `minibook3-*-linux/` |
| Keep repo **public** for free downloads | Use Git LFS for public PoS traffic |
| Copy asset URLs into Zolestio Admin | Expect GCS folder paths on Releases |

---

## 10. Auto-update feed (thin git + Release binaries)

MiniBook3 Settings → Updates uses:

| Role | Where |
|------|--------|
| Default update base | `https://raw.githubusercontent.com/ShashikaUdara/MiniBook3-Downloads/Udara` (active branch; apps may also accept Release flat assets) |
| Channel pointer | `{linux\|windows}/latest/stable/latest.txt` (contents: `1.0.2`) |
| Manifest | `{linux\|windows}/latest/stable/channel-manifest.json` with **absolute** `…/releases/download/v…/…` URLs |
| Binary payload | GitHub Release assets only (never raw.githubusercontent for tarballs / exes) |

Also supported as flat Release assets (fallback): `stable-latest.txt`, `linux-stable-latest.txt`, `SHA256SUMS.txt`, and platform install scripts.

Commit the tiny feed tree from this repo (`linux/latest/…`, `windows/latest/…`) after each GA promote.  
Upload the matching `.tar.gz` / `.exe` / `.zip` on the Release **before** treating the channel as live.

---

## 11. Windows v1.0.2 (parity with Linux — large upload deferred)

Linux packages for `v1.0.2` are already on the Release. Windows follows the **same thin-git pattern**; the heavy upload is a separate operator step.

### 11.1 Built artifacts (already on disk)

| File | Role |
|------|------|
| `minibook3-1.0.2-win64-setup.exe` | Fresh install (Inno) |
| `minibook3-1.0.2-win64-portable.zip` | Auto-update + portable run |
| `install.ps1` | One-line bootstrap (`irm … \| iex`) |
| Merged `SHA256SUMS.txt` | Linux lines **plus** Windows setup/portable hashes |

### 11.2 Thin files committed in this repo

```text
windows/latest/stable/latest.txt
windows/latest/stable/channel-manifest.json
windows/latest/download-manifest.json
windows/latest/install.ps1
windows/latest/SHA256SUMS.txt          # Windows artifact hashes only (tiny)
windows/install.ps1
windows/SHA256SUMS.txt
RELEASE_NOTES_v1.0.2.md                # Linux + Windows download tables
```

### 11.3 Local staging (gitignored — for upload later)

```text
staging/v1.0.2/
  minibook3-1.0.2-win64-setup.exe
  minibook3-1.0.2-win64-portable.zip
  install.ps1
  SHA256SUMS.txt                       # merged Linux + Windows (upload this)
```

### 11.4 Upload command (operator — not part of thin-feed commit)

```powershell
$VER = "1.0.2"
$STAGING = "staging/v$VER"

gh release upload "v$VER" `
  "$STAGING/minibook3-$VER-win64-setup.exe" `
  "$STAGING/minibook3-$VER-win64-portable.zip" `
  "$STAGING/install.ps1" `
  "$STAGING/SHA256SUMS.txt" `
  --clobber
```

**Do not** replace `SHA256SUMS.txt` with a Windows-only file — keep every Linux line from the published Release and append the two Windows hashes (the staged file already does this).

### 11.5 After upload — smoke

```powershell
$VER = "1.0.2"
$base = "https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v$VER"
foreach ($f in @(
  "minibook3-$VER-win64-setup.exe",
  "minibook3-$VER-win64-portable.zip",
  "install.ps1",
  "SHA256SUMS.txt"
)) {
  curl.exe -fsSI "$base/$f" | Select-Object -First 1
}
```

Then paste the same URLs into Zolestio **Admin → Releases** for the Windows fields.

### 11.6 Edge cases

| Risk | Mitigation |
|------|------------|
| Thin feed points at missing assets | Treat Windows channel as **prepared, not live** until smoke returns HTTP 200 |
| Checksums wipe Linux entries | Always upload the **merged** `SHA256SUMS.txt` from staging |
| Portable extracted over install dir | Release notes + INSTALL warn: own empty folder only |
| Accidental binary commit | `.gitignore` covers `*.exe`, `*.zip`, `staging/`, `windows/v*/` |

---

## Quick command card

```bash
# --- thin git push ---
cd Versions-MiniBook3-Downloads
git add .gitignore README.md docs/ RELEASE_NOTES_v1.0.2.md linux/ windows/
git status   # confirm NO .exe / .zip / .tar.gz
git commit -m "Windows v1.0.2 thin feed (manifests, install.ps1, checksums)."
git push

# --- create release + upload Linux (from MiniBook3/release) ---
VER=1.0.2
SRC="/home/udara/Documents/zolestio/r&d/100_tools_challenge/MiniBook3/release"
gh release create "v${VER}" \
  --title "MiniBook3 ${VER}" \
  --notes "MiniBook3 ${VER}" \
  "$SRC/minibook3-${VER}-linux-x86_64.tar.gz" \
  "$SRC/SHA256SUMS.txt"

# --- add Windows assets later (from staging) ---
# gh release upload "v${VER}" staging/v${VER}/* --clobber

# --- show download URLs ---
gh release view "v${VER}" --json assets --jq '.assets[].browserDownloadUrl'
```

---

*Guide for Versions-MiniBook3-Downloads · updated 2026-08-06 (Windows v1.0.2 thin feed)*
