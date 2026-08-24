# MiniBook3 v1.0.4 — Release Notes

**MiniBook3 — MiniBook-Shop** · *Portable · Recorded · Reliable*

Release date: 2026-08-24  
Hosted on: [MiniBook3-Downloads · v1.0.4](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/tag/v1.0.4)

Trust wave for the buyable aisle: released tills stay on the **production** MiniBook3 licence plane, and **admin password reset** works against that same cloud.

---

## What’s New

Production cloud harden for shipped registers (Windows and Linux), plus the control-plane routes merchants need when they forget the admin password.

### Highlights

- **Released tills → production only** — Frozen builds ignore lab `MINIBOOK3_USE_LOCAL_CLOUD` and reject loopback licence/payment URL overrides (unless an undocumented eng escape hatch). Shops talk to `https://api-minibook3.zolestio.com` and `https://minibook3.zolestio.com`
- **Admin password reset on MiniBook3 API** — Token request / redeem on the production licence plane (Brevo email), so reset no longer depends on a missing route or a leftover localhost target
- **Clearer cloud errors** — Humanized copy when the licence host is unreachable or a control-plane path is missing
- **Still from 1.0.3** — Buyable Windows aisle, register chrome polish, Free · Solo · Enterprise ladder, schema **v49**
- **Packages you can buy** — Public ladder remains **Free · Solo · Enterprise** (USD; PayHere). Credits and Multi stay capabilities, not extra SKUs
- **Ledger** — schema **v49** (no new migration in this wave). Backup before upgrading a live shop. Linux ≡ Windows
- **Not claimed** — this release does **not** stamp “20M ready”. Large-catalog / long-history work stays inside the existing soak envelope

---

## Downloads

All installers for this version are published as GitHub Release assets:

https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/tag/v1.0.4

| Artifact | Link |
|----------|------|
| Windows setup | [minibook3-1.0.4-win64-setup.exe](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/minibook3-1.0.4-win64-setup.exe) |
| Windows portable | [minibook3-1.0.4-win64-portable.zip](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/minibook3-1.0.4-win64-portable.zip) |
| Checksums | [SHA256SUMS.txt](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/SHA256SUMS.txt) |
| One-line installer | [install.ps1](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/install.ps1) |

Also listed on https://minibook3.zolestio.com/downloads (and https://zolestio.com/downloads until cutover) when Admin Releases point at these URLs.

Operator playbook: `MiniBook3/docs/release.md`.

---

## Install

See [packaging/INSTALL.md](packaging/INSTALL.md).

### Windows — setup

Run `minibook3-1.0.4-win64-setup.exe` — Next → Install → Finish.

### Windows — one-line install

```powershell
irm https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/install.ps1 | iex
```

### Windows — portable

Extract `minibook3-1.0.4-win64-portable.zip` into its **own empty folder**, then run the app from that folder.

---

## Upgrade

Existing installs: Settings → Updates → **Check now**, then restart when the update is ready.

User data is preserved. Database migrations (schema **v49**) run automatically on first launch if needed. Take a backup before upgrading a live shop.

**Before upgrading shops:** confirm `https://api-minibook3.zolestio.com` serves admin-password token routes (deployed with this wave’s control plane).

---

## Integrity

```powershell
# Verify after download (PowerShell)
Get-FileHash .\minibook3-1.0.4-win64-setup.exe -Algorithm SHA256
# Compare to the matching line in SHA256SUMS.txt from the same Release
```

When a GPG signature is published, verify `SHA256SUMS.txt.asc` before trusting the hashes.

---

## Support

- Website: https://minibook3.zolestio.com  
- Operations: operations@zolestio.com  
- Release warehouse: https://github.com/ShashikaUdara/MiniBook3-Downloads/releases  
