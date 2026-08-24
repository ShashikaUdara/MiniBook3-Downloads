# MiniBook3 v1.0.3 — Release Notes

**MiniBook3 — MiniBook-Shop** · *Portable · Recorded · Reliable*

Release date: 2026-08-18  
Hosted on: [MiniBook3-Downloads · v1.0.3](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/tag/v1.0.3)

This is the first MiniBook3 version listed so shops can **buy** the product and install a **Windows** till from the public downloads aisle.

---

## What’s New

Buyable Windows register: the same shop floor as Linux, with a polished till (checkout, catalog, shifts, history, settings) and the MiniBook3 licence plane.

### Highlights

- **Windows is a product row** — Inno setup + portable ZIP + `install.ps1` on GitHub Release `v1.0.3`; listed on [minibook3.zolestio.com/downloads](https://minibook3.zolestio.com/downloads) when Admin points at live URLs
- **Register chrome (D93–D107)** — checkout cart order and icons; Products catalog and filter strip; Shifts (including Analytics under load); transaction history; Store Settings identity, receipt, and desk chrome; checkout shift-gate scroll lock; tender-drawer keyset paging
- **Licence plane** — production activation uses `https://api-minibook3.zolestio.com` (local lab still `MINIBOOK3_USE_LOCAL_CLOUD=1`)
- **Packages you can buy** — public ladder remains **Free · Solo · Enterprise** (USD; PayHere). Credits and Multi stay capabilities, not extra SKUs
- **Ledger** — schema **v49** migrations run automatically on first launch (backup first). Linux ≡ Windows
- **Still from 1.0.2** — lean checkout catalog, hybrid search, Credits workspace, FEFO batches, Select payment polish
- **Not claimed** — this release does **not** stamp “20M ready”. Large-catalog / long-history work stays inside the existing soak envelope

---

## Downloads

All installers for this version are published as GitHub Release assets:

https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/tag/v1.0.3

| Artifact | Link |
|----------|------|
| Windows setup | [minibook3-1.0.3-win64-setup.exe](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.3/minibook3-1.0.3-win64-setup.exe) |
| Windows portable | [minibook3-1.0.3-win64-portable.zip](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.3/minibook3-1.0.3-win64-portable.zip) |
| Checksums | [SHA256SUMS.txt](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.3/SHA256SUMS.txt) |
| One-line installer | [install.ps1](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.3/install.ps1) |

Also listed on https://minibook3.zolestio.com/downloads (and https://zolestio.com/downloads until cutover) when Admin Releases point at these URLs.

Operator playbook: `MiniBook3/docs/release.md`.

---

## Install

See [packaging/INSTALL.md](packaging/INSTALL.md).

### Windows — setup (recommended)

1. Download `minibook3-1.0.3-win64-setup.exe` from the Release page  
2. Double-click → **Next** → **Install** → **Finish**

### Windows — one-line install

```powershell
irm https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.3/install.ps1 | iex
```

Latest rolling bootstrap (only after this tag is the GitHub “latest”):

```powershell
irm https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/latest/download/install.ps1 | iex
```

### Windows — portable

Extract `minibook3-1.0.3-win64-portable.zip` into its **own empty folder**, then run `minibook3.exe` from that folder. Do not unpack into a shared directory (auto-update only replaces files inside a dedicated MiniBook3 install).

---

## Upgrade

Existing installs: Settings → Updates → **Check now**, then restart when the update is ready.

Database migrations (including schema **v49**) run automatically on first launch. Take a backup before upgrading a live shop.

---

## Integrity

Verify downloads against `SHA256SUMS.txt` on the same GitHub Release.

---

## Support

- Website: https://minibook3.zolestio.com  
- Operations: operations@zolestio.com  
- Release warehouse: https://github.com/ShashikaUdara/MiniBook3-Downloads/releases  
