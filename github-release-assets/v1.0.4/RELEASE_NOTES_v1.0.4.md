# MiniBook3 v1.0.4 — Release Notes

**MiniBook3 — MiniBook-Shop** · *Portable · Recorded · Reliable*

Release date: 2026-08-24  
Hosted on: [MiniBook3-Downloads · v1.0.4](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/tag/v1.0.4)

Trust wave for the buyable aisle: released tills stay on the **production** MiniBook3 licence plane, and **admin password reset** works against that same cloud. **Linux** and **Windows** both ship on tag `v1.0.4` (setup / portable / tarball / AppImage / `.deb` as attached).

---

## What’s New

Production cloud harden for shipped registers (Linux and Windows), plus the control-plane routes merchants need when they forget the admin password.

### Highlights

- **Released tills → production only** — Frozen builds ignore lab `MINIBOOK3_USE_LOCAL_CLOUD` and reject loopback licence/payment URL overrides (unless an undocumented eng escape hatch). Shops talk to `https://api-minibook3.zolestio.com` and `https://minibook3.zolestio.com`
- **Admin password reset on MiniBook3 API** — Token request / redeem on the production licence plane (Brevo email), so reset no longer depends on a missing route or a leftover localhost target
- **Clearer cloud errors** — Humanized copy when the licence host is unreachable or a control-plane path is missing
- **Faster store-credit customer search** — Select payment looks up active customers by **name/phone prefix** (lean API path) so typing on the till feels instant; Credits directory still supports contains search
- **Still from 1.0.3** — Buyable Windows + Linux aisle, register chrome polish, Free · Solo · Enterprise ladder
- **Packages you can buy** — Public ladder remains **Free · Solo · Enterprise** (USD; PayHere). Credits and Multi stay capabilities, not extra SKUs
- **Ledger** — schema **v50** (phone prefix index for credit search). Backup before upgrading a live shop. Linux ≡ Windows
- **Not claimed** — this release does **not** stamp “20M ready”. Large-catalog / long-history work stays inside the existing soak envelope

---

## Choose your OS

| OS | Who it’s for | Recommended package |
|----|----------------|---------------------|
| **Windows 10/11 (64-bit)** | Shop PCs, most merchants | **Setup** `.exe` (Start Menu) |
| **Windows (USB / trial)** | Temporary desk, no installer rights | **Portable** `.zip` |
| **Linux x86_64** | Ubuntu / Debian-class desks, labs | **Tarball** + `./install.sh` |
| **Debian / Ubuntu** | Prefer system packages | **`.deb`** (optional) |
| **Linux AppImage** | Single-file trial (optional) | **AppImage** |
| **macOS** | Not in this wave unless a DMG is attached to the same tag | — |

Also listed on https://minibook3.zolestio.com/downloads (and https://zolestio.com/downloads until cutover) when Admin Releases point at these URLs.

Operator playbook: `MiniBook3/docs/release.md`.

---

## Downloads (all packages on one tag)

Release page:

https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/tag/v1.0.4

### Windows

| Package | File | Role |
|---------|------|------|
| Setup (recommended) | [minibook3-1.0.4-win64-setup.exe](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/minibook3-1.0.4-win64-setup.exe) | Installer → Start Menu |
| Portable | [minibook3-1.0.4-win64-portable.zip](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/minibook3-1.0.4-win64-portable.zip) | Extract to an **empty** folder |
| One-line bootstrap | [install.ps1](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/install.ps1) | Downloads + runs setup |

### Linux (x86_64)

| Package | File | Role |
|---------|------|------|
| Tarball (recommended) | [minibook3-1.0.4-linux-x86_64.tar.gz](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/minibook3-1.0.4-linux-x86_64.tar.gz) | Offline install / updates |
| Debian / Ubuntu | [minibook3_1.0.4_amd64.deb](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/minibook3_1.0.4_amd64.deb) | Optional `.deb` |
| AppImage | [minibook3-1.0.4-linux-x86_64.AppImage](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/minibook3-1.0.4-linux-x86_64.AppImage) | Optional single file |
| One-line bootstrap | [install.sh](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/install.sh) | Fetches tarball, verifies, installs |

### Shared

| File | Role |
|------|------|
| [SHA256SUMS.txt](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/SHA256SUMS.txt) | Integrity for **all** platforms on this tag |
| This notes file | GitHub Release body / asset |

---

## One-line install (preferred for a fresh desk)

Prefer **versioned** URLs (`/download/v1.0.4/…`). They never silently swap if GitHub’s “latest” flag moves.

### Windows (PowerShell 5.1+)

```powershell
irm https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/install.ps1 | iex
```

Pin explicitly (same result when the script is already baked to 1.0.4):

```powershell
irm https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/install.ps1 | iex -Version 1.0.4
```

Dry-run (print URLs only):

```powershell
irm https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/install.ps1 | iex -DryRun
```

Requires **64-bit Windows**. Run PowerShell as a user who may install software (or use portable ZIP if you cannot).

### Linux (bash)

```bash
curl -fsSL https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/install.sh | bash
```

Pin explicitly:

```bash
curl -fsSL https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/install.sh | bash -s -- --version 1.0.4
```

Dry-run:

```bash
curl -fsSL https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/install.sh | bash -s -- --dry-run
```

Requires **x86_64 / amd64**. Needs `curl`, `tar`, and a normal user install under `~/.local` by default.

### About `/releases/latest/download/…`

`…/releases/latest/download/install.sh` (or `install.ps1`) only works when this tag is GitHub’s **latest** release **and** that OS’s bootstrap file is attached. During a staged ship, prefer the **v1.0.4** URLs above so Linux and Windows do not pull different versions.

---

## Manual install

### Windows — setup

1. Download `minibook3-1.0.4-win64-setup.exe`.
2. Run it → Next → Install → Finish.
3. Launch from the Start Menu. Data lives under `%LOCALAPPDATA%\MiniBook3\`.

### Windows — portable

1. Download `minibook3-1.0.4-win64-portable.zip`.
2. Extract into its **own empty folder** (do not unpack over an older portable tree).
3. Run the app from that folder.

### Linux — offline tarball

```bash
tar -xzf minibook3-1.0.4-linux-x86_64.tar.gz
cd minibook3-1.0.4-linux
./install.sh
```

### Linux — Debian / Ubuntu (optional)

```bash
sudo dpkg -i minibook3_1.0.4_amd64.deb
# if needed:
sudo apt-get install -f
```

### Linux — AppImage (optional)

```bash
chmod +x minibook3-1.0.4-linux-x86_64.AppImage
./minibook3-1.0.4-linux-x86_64.AppImage
```

---

## Upgrade

Existing installs: **Settings → Updates → Check now**, then restart when the update is ready.

In-app auto-update reads channel pointers on this warehouse repo (`windows/latest/stable/latest.txt` and the Linux equivalent) — operators promote those **only after** every public asset returns HTTP 200.

User data is preserved. Schema **v50** migrations run on first launch if needed. Take a backup before upgrading a live shop.

**Before upgrading shops:** confirm `https://api-minibook3.zolestio.com` serves admin-password token routes.

---

## Integrity

Download `SHA256SUMS.txt` from the same Release, then verify the file you installed.

### Linux

```bash
curl -fsSLO https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/SHA256SUMS.txt
curl -fsSLO https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/minibook3-1.0.4-linux-x86_64.tar.gz
sha256sum -c SHA256SUMS.txt --ignore-missing
```

### Windows (PowerShell)

```powershell
Get-FileHash .\minibook3-1.0.4-win64-setup.exe -Algorithm SHA256
# Compare to the matching line in SHA256SUMS.txt from the same Release
```

When a GPG signature is published:

```bash
gpg --verify SHA256SUMS.txt.asc SHA256SUMS.txt
sha256sum -c SHA256SUMS.txt
```

---

## Support

- Website: https://minibook3.zolestio.com  
- Operations: operations@zolestio.com  
- Release warehouse: https://github.com/ShashikaUdara/MiniBook3-Downloads/releases  
- Canonical notes in this repo: `docs/releases/RELEASE_NOTES_v1.0.4.md`
