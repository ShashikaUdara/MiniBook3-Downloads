> **Location:** `docs/releases/` (moved for organization; auto-update paths under `windows/` / `linux/` unchanged).

# Publish MiniBook3 v1.0.3 (Windows)

This sheet is the warehouse checklist. The till files are already built. You upload the heavy installers by hand. Git only holds the small pointer files.

**Do not** commit `*.exe` or `*.zip`. **Do not** upload `Windows-MiniBook3/release/SHA256SUMS.txt` — that file hashes the unpacked build tree (~400 KB). Use the two-line checksums in this repo.

Linux stays on **1.0.2** until a Linux 1.0.3 package exists.

---

## Order (this is the safety rule)

1. Create GitHub Release tag **`v1.0.3`** and attach the binaries + small assets below.
2. Confirm every public URL returns **HTTP 200**.
3. Then commit and push this repo (that flips auto-update via `windows/latest/stable/latest.txt`).
4. Then paste versioned URLs into Admin → Releases (slug `minibook3-v1-0-3`).
5. Only then update the MiniBook3 website seed / fallback.

Existing shops read:

`https://raw.githubusercontent.com/ShashikaUdara/MiniBook3-Downloads/main/windows/latest/stable/latest.txt`

If that file says `1.0.3` before the zip is on GitHub, **Check for Updates** 404s. Upload first, push git second.

---

## GitHub “latest” flag

Leave **v1.0.2 as GitHub’s latest release** until Linux 1.0.3 is attached.

Linux one-line install uses `/releases/latest/download/install.sh`. If v1.0.3 becomes GitHub “latest” without Linux files, that Linux bootstrap breaks.

Windows auto-update does **not** need the GitHub latest flag. It uses the git `latest.txt` pointer, then the versioned zip URL.

When creating the v1.0.3 release in the GitHub UI: **uncheck “Set as the latest release”**.

---

## 1. Attach these files to GitHub Release `v1.0.3`

### Binaries (from the Windows build — do not git-commit)

| File | Size | SHA-256 |
|------|------|---------|
| `H:\Projects\Windows-MiniBook3\release\minibook3-1.0.3-win64-setup.exe` | 148,542,960 bytes (~142 MB) | `31322da8bfc5cffb601d86defce5dd9fb74774b27d565851c8dc13b177e7ee33` |
| `H:\Projects\Windows-MiniBook3\release\minibook3-1.0.3-win64-portable.zip` | 222,194,388 bytes (~212 MB) | `dc288f4e4c723d76a422a289c5a2f020a468b99417e7bc9c269160ca3cab6bda` |

GitHub asset names must match **exactly** (no rename).

### Small files (from this repo — drag onto the same Release)

Upload from `github-release-assets/v1.0.3/` **or** the matching path in `windows/`:

| GitHub asset name | Local file |
|-------------------|------------|
| `SHA256SUMS.txt` | `github-release-assets/v1.0.3/SHA256SUMS.txt` |
| `install.ps1` | `windows/v1.0.3/install.ps1` |
| `RELEASE_NOTES_v1.0.3.md` | `RELEASE_NOTES_v1.0.3.md` |
| `download-manifest.json` | `github-release-assets/v1.0.3/download-manifest.json` |
| `windows-download-manifest.json` | `github-release-assets/v1.0.3/windows-download-manifest.json` |
| `stable-latest.txt` | `github-release-assets/v1.0.3/stable-latest.txt` |
| `windows-stable-latest.txt` | `github-release-assets/v1.0.3/windows-stable-latest.txt` |
| `windows-stable-channel-manifest.json` | `github-release-assets/v1.0.3/windows-stable-channel-manifest.json` |

Release body: paste `RELEASE_NOTES_v1.0.3.md`.

---

## 2. Public URLs to prove with HTTP 200

```
https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.3/minibook3-1.0.3-win64-setup.exe
https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.3/minibook3-1.0.3-win64-portable.zip
https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.3/SHA256SUMS.txt
https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.3/install.ps1
```

PowerShell:

```powershell
$urls = @(
  "https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.3/minibook3-1.0.3-win64-setup.exe",
  "https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.3/minibook3-1.0.3-win64-portable.zip",
  "https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.3/SHA256SUMS.txt",
  "https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.3/install.ps1"
)
foreach ($u in $urls) {
  $r = Invoke-WebRequest -Uri $u -Method Head -UseBasicParsing
  "{0}  {1}" -f $r.StatusCode, $u
}
```

---

## 3. After 200s — push this git repo

That publishes the auto-update aisle sign (`windows/latest/stable/latest.txt` = `1.0.3`) and the manifests that point at the versioned zip.

Do not push `latest.txt` before step 2.

---

## 4. Admin catalog (after warehouse 200s)

| Field | Value |
|-------|--------|
| Title | `MiniBook3 PoS · v1.0.3` |
| Slug | `minibook3-v1-0-3` (immutable after create) |
| Version label | `v1.0.3` |
| Windows setup URL | `https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.3/minibook3-1.0.3-win64-setup.exe` |
| Windows portable URL | `https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.3/minibook3-1.0.3-win64-portable.zip` |

Keep v1.0.2 published until v1.0.3 is smoked. Prefer `/download/v1.0.3/` URLs, never `/latest/download/` in Admin.

Leave MiniBook3 website seed (`releases.ts` / `init.sql`) on **1.0.2** until those 200s are real.

---

## 5. What existing Windows tills will do

Settings → Updates → Check now reads `latest.txt`, then downloads `minibook3-1.0.3-win64-portable.zip` from the versioned GitHub URL, verifies SHA-256, and stages the bundle. Schema **v49** migrates on first launch after restart. Backup the shop database before upgrading a live till.

---

## Do not upload

- `Windows-MiniBook3\release\minibook3-1.0.3-windows\` (unpacked PyInstaller tree)
- `Windows-MiniBook3\release\SHA256SUMS.txt` (hashes that whole tree)
- Any Linux 1.0.2 installer onto tag v1.0.3 (wrong version on the tag)
