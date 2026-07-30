# MiniBook3 v1.0.2 — Release Notes

**MiniBook3 — MiniBook-Shop** · *Portable · Recorded · Reliable*

Release date: 2026-07-31  
Hosted on: [MiniBook3-Downloads · v1.0.2](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/tag/v1.0.2)

---

## What’s New

Scale and register-feel release: the till stays snappy at large catalogs and long sales histories, with store credit / batch workflows and a faster Select payment path.

### Highlights

- **Scale performance (PERF1–7)** — schema **v38** indexes, SQL-paged stock movements, lean checkout catalog (`fields=checkout`), hybrid FTS+LIKE search (no false-zero mid-token misses), Credits pagination + summary API, skeleton loaders with Retry on Returns / Credits / transaction drawers
- **Transaction history at volume** — keyset pagination skips expensive COUNT on cursor pages; Returns UI keeps the cached total
- **Credits** — left-nav Credits workspace (customers, open bills, settlements); FIFO settle; settlement receipts / history / CSV export
- **Batches** — smart batch (FEFO) in Inventory and checkout batch pick
- **Select payment polish** — customer search on Store credit; fixed modal size; Enter confirms when a customer is attached; Manager PIN only when over remaining credit; gift card opens the cash drawer on confirm
- **Verified at target scale** — soak bench: **100k SKUs** catalog search p95 &lt; 2 ms; **5M** sales keyset page p95 ~3 ms (Windows full soak; Linux smoke + parity suite green)
- **Core CSS budget** — raised to 32 KiB gzip for PERF5 skeleton styles

---

## Downloads

All installers for this version are published as GitHub Release assets:

https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/tag/v1.0.2

| Artifact | Link |
|----------|------|
| Linux tarball | [minibook3-1.0.2-linux-x86_64.tar.gz](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.2/minibook3-1.0.2-linux-x86_64.tar.gz) |
| Debian / Ubuntu | [minibook3_1.0.2_amd64.deb](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.2/minibook3_1.0.2_amd64.deb) |
| AppImage | [minibook3-1.0.2-linux-x86_64.AppImage](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.2/minibook3-1.0.2-linux-x86_64.AppImage) |
| Checksums | [SHA256SUMS.txt](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.2/SHA256SUMS.txt) |
| One-line installer | [install.sh](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.2/install.sh) |

Also listed on https://zolestio.com/downloads when Admin Releases point at these URLs.

---

## Install

See [packaging/INSTALL.md](packaging/INSTALL.md).

### Linux — offline tarball

```bash
tar -xzf minibook3-1.0.2-linux-x86_64.tar.gz
cd minibook3-1.0.2-linux
./install.sh
```

### Linux — one-line install

```bash
curl -fsSL https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.2/install.sh | bash -s -- --version 1.0.2
```

Latest rolling bootstrap (always follows the newest Release):

```bash
curl -fsSL https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/latest/download/install.sh | bash
```

### Windows

Run `minibook3-1.0.2-win64-setup.exe` — four clicks to complete — from the same Release page when the Windows assets are attached.

---

## Upgrade

Existing installs: Settings → Updates → **Check now**, then restart when the update is ready.

User data is preserved. Database migrations (including schema **v38** indexes) run automatically on first launch.

---

## Integrity

```bash
curl -fsSLO https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.2/SHA256SUMS.txt
curl -fsSLO https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.2/minibook3-1.0.2-linux-x86_64.tar.gz
sha256sum -c SHA256SUMS.txt --ignore-missing
```

When a GPG signature is published:

```bash
gpg --verify SHA256SUMS.txt.asc SHA256SUMS.txt
sha256sum -c SHA256SUMS.txt
```

---

## Support

- Website: https://zolestio.com  
- Operations: operations@zolestio.com  
- Release warehouse: https://github.com/ShashikaUdara/MiniBook3-Downloads/releases  
