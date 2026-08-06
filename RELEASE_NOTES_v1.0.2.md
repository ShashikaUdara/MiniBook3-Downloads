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
- **Core CSS budget** — re-baselined for shared PERF5, enterprise, recovery, and update surfaces

---

## Downloads

All installers for this version are published as GitHub Release assets:

https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/tag/v1.0.2

### Linux

| Artifact | Link |
|----------|------|
| Linux tarball | [minibook3-1.0.2-linux-x86_64.tar.gz](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.2/minibook3-1.0.2-linux-x86_64.tar.gz) |
| Debian / Ubuntu | [minibook3_1.0.2_amd64.deb](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.2/minibook3_1.0.2_amd64.deb) |
| AppImage | [minibook3-1.0.2-linux-x86_64.AppImage](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.2/minibook3-1.0.2-linux-x86_64.AppImage) |
| One-line installer | [install.sh](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.2/install.sh) |

### Windows

| Artifact | Link |
|----------|------|
| Windows setup (recommended) | [minibook3-1.0.2-win64-setup.exe](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.2/minibook3-1.0.2-win64-setup.exe) |
| Windows portable | [minibook3-1.0.2-win64-portable.zip](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.2/minibook3-1.0.2-win64-portable.zip) |
| One-line installer | [install.ps1](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.2/install.ps1) |

### Integrity

| Artifact | Link |
|----------|------|
| Checksums (Linux + Windows) | [SHA256SUMS.txt](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.2/SHA256SUMS.txt) |

Also listed on https://zolestio.com/downloads when Admin Releases point at these URLs.

> **Ops note:** Linux assets are live on the Release. Windows setup / portable / `install.ps1` are prepared in this repo’s thin feed and local `staging/v1.0.2/`; attach them to the same Release before treating Windows downloads as public.

---

## Install

See packaging `INSTALL.md` in each MiniBook3 app tree.

### Linux — offline tarball

```bash
tar -xzf minibook3-1.0.2-linux-x86_64.tar.gz
cd minibook3-1.0.2-linux
./install.sh
```

### Linux — one-line install

```bash
curl -fsSL https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.2/install.sh | bash
```

### Windows — setup (recommended)

1. Download `minibook3-1.0.2-win64-setup.exe` from the Release page  
2. Double-click → **Next** → **Install** → **Finish**

### Windows — one-line install

```powershell
irm https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.2/install.ps1 | iex
```

Latest rolling bootstrap (after `install.ps1` is on the Release):

```powershell
irm https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/latest/download/install.ps1 | iex
```

### Windows — portable

Extract `minibook3-1.0.2-win64-portable.zip` into its **own empty folder**, then run `minibook3.exe` from that folder. Do not unpack over an existing MiniBook3 install directory.

---

## Upgrade

Existing installs: Settings → Updates → **Check now**, then restart when the update is ready.

User data is preserved. Database migrations (including schema **v38** indexes) run automatically on first launch.

Windows auto-update consumes the **portable zip**. Fresh installs should prefer the **setup** exe.

---

## Integrity

### Linux

```bash
curl -fsSLO https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.2/SHA256SUMS.txt
curl -fsSLO https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.2/minibook3-1.0.2-linux-x86_64.tar.gz
sha256sum -c SHA256SUMS.txt --ignore-missing
```

### Windows

```powershell
Invoke-WebRequest https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.2/SHA256SUMS.txt -OutFile SHA256SUMS.txt
Invoke-WebRequest https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.2/minibook3-1.0.2-win64-setup.exe -OutFile minibook3-1.0.2-win64-setup.exe
$expected = (Get-Content SHA256SUMS.txt | Where-Object { $_ -match 'minibook3-1\.0\.2-win64-setup\.exe$' }) -split '\s+' | Select-Object -First 1
$actual = (Get-FileHash -Algorithm SHA256 .\minibook3-1.0.2-win64-setup.exe).Hash.ToLowerInvariant()
if ($actual -ne $expected.ToLowerInvariant()) { throw "Checksum mismatch" } else { "OK $actual" }
```

---

## Support

- Website: https://zolestio.com  
- Operations: operations@zolestio.com  
- Release warehouse: https://github.com/ShashikaUdara/MiniBook3-Downloads/releases  
