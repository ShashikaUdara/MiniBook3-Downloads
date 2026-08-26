# Publish MiniBook3 v1.0.4

> **Status (2026-08-26): CLOSED — both OS live**  
> GitHub Release [`v1.0.4`](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/tag/v1.0.4) has Linux **and** Windows binaries (HTTP **200**).  
> Raw channel pointers on `main`: Linux **1.0.4** · Windows **1.0.4** (promoted by **Publish Warehouse** / WF19).  
> Remaining: Zolestio **Admin / website** Downloads rows + SPA fallback seed — not this warehouse git tree.

**Do not** commit `*.exe`, `*.zip`, or large tarballs. **Do not** push a platform’s `latest.txt` until that platform’s public assets return **HTTP 200**.

**Git default branch must be `main`** (D127). POS Check now reads `raw.githubusercontent.com/…/MiniBook3-Downloads/main/…`.

**Notes file (GitHub Release body):** [`RELEASE_NOTES_v1.0.4.md`](./RELEASE_NOTES_v1.0.4.md)  
**Layout rules:** [`../layout.md`](../layout.md)

---

> **WF20 incident (2026-08-25):** Release `v1.0.4` briefly missing while raw Linux `latest.txt` said **1.0.4** → Check/CDN smoke 404. Local aisle rolled back to **1.0.2** during investigate. Re-publish via **Publish Warehouse** restored assets; pointers re-promoted to **1.0.4** after smoke.

---

## HTTP 200 smoke (final · 2026-08-26)

Probed against live GitHub Release tag [`v1.0.4`](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/tag/v1.0.4).

### Linux — **Done**

| Asset | HTTP |
|-------|-----:|
| `minibook3-1.0.4-linux-x86_64.tar.gz` | **200** |
| `minibook3-1.0.4-linux-x86_64.AppImage` | **200** |
| `minibook3_1.0.4_amd64.deb` | **200** |
| `SHA256SUMS.txt` (merged OS) | **200** |
| `install.sh` | **200** |
| Manifest / `*-stable-latest.txt` helpers | **200** |

### Windows — **Done**

| Asset | HTTP |
|-------|-----:|
| `minibook3-1.0.4-win64-setup.exe` | **200** |
| `minibook3-1.0.4-win64-portable.zip` | **200** |
| `install.ps1` | **200** |

```bash
# Spot-check (expect final HTTP 200 after redirects)
for f in \
  minibook3-1.0.4-linux-x86_64.tar.gz \
  minibook3-1.0.4-win64-setup.exe \
  minibook3-1.0.4-win64-portable.zip \
  install.sh install.ps1 SHA256SUMS.txt
do
  curl -sIL -o /dev/null -w "%{http_code} $f\n" \
    "https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/$f"
done

# Channel pointers on main
curl -fsSL https://raw.githubusercontent.com/ShashikaUdara/MiniBook3-Downloads/main/linux/latest/stable/latest.txt
curl -fsSL https://raw.githubusercontent.com/ShashikaUdara/MiniBook3-Downloads/main/windows/latest/stable/latest.txt
```

### Raw channel (live)

| Path on `main` | Value |
|----------------|-------|
| `linux/latest/stable/latest.txt` | **1.0.4** |
| `windows/latest/stable/latest.txt` | **1.0.4** |
| `linux/v1.0.4/*` · `windows/v1.0.4/*` | Present on `main` |

---

## Live SHA-256 (basename · Release `SHA256SUMS.txt`)

```
10a036d8271346cad3894e9c94570814c9d27c1d5a3c2267de58ff867c5ba213  install.ps1
92ca95f8a3c44a105a4e3780753fe9ccb055aba0b2d908e527942a91b6ca4559  install.sh
9bac45224a8db1f96e4a39b6c0b175a8db7037890c086bc5c61ec7e5fbaa3d05  minibook3-1.0.4-linux-x86_64.AppImage
1bae3d6db523062a887805f3223f7f1be8a8d68dc220192f96005dadad628181  minibook3-1.0.4-linux-x86_64.tar.gz
f76bc13cc9ae4efd9d4e23696d4ce7e98931f59b7454686bfd264b3d3e8c67fa  minibook3-1.0.4-win64-portable.zip
c1890f4ae1bc7a0b3a09b12068a295a7df1ce5af073b07ca9458eac456274c92  minibook3-1.0.4-win64-setup.exe
a5b8b5e8feac2d8dcfe41e0a7b209bb49579ad54a3892cbcafc47ec84e1bf069  minibook3_1.0.4_amd64.deb
```

Per-OS slim copies live under `linux/latest/SHA256SUMS.txt` and `windows/latest/SHA256SUMS.txt` (same hashes).

---

## Order (safety rule — for the next tag)

1. POS **Release** green → **Publish Warehouse** (smoke 200 → promote `latest.txt`).
2. Never flip `latest.txt` before that OS’s assets return **200**.
3. Admin → paste **versioned** `/download/vX.Y.Z/…` URLs (prefer over `/latest/download/`).
4. Only then bump MiniBook3 website seed / fallback (`releases.ts` / `init.sql`).

Existing shops read:

`https://raw.githubusercontent.com/ShashikaUdara/MiniBook3-Downloads/main/windows/latest/stable/latest.txt`  
`https://raw.githubusercontent.com/ShashikaUdara/MiniBook3-Downloads/main/linux/latest/stable/latest.txt`

---

## Public URLs (both OS)

```
https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/minibook3-1.0.4-linux-x86_64.tar.gz
https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/minibook3_1.0.4_amd64.deb
https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/minibook3-1.0.4-linux-x86_64.AppImage
https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/minibook3-1.0.4-win64-setup.exe
https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/minibook3-1.0.4-win64-portable.zip
https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/SHA256SUMS.txt
https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/install.sh
https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.4/install.ps1
```

---

## Operator closeout (outside this repo)

- [x] Warehouse assets HTTP **200** (Linux + Windows)
- [x] Raw `latest.txt` = **1.0.4** both OS
- [ ] Admin → Releases slug `minibook3-v1-0-4` with **versioned** Linux + Windows URLs
- [ ] Fresh VM install smoke (Linux 24.04 + Windows)
- [ ] Bump SPA fallback seed after Admin 200 (`MiniBook3/web/src/data/releases.ts`)

Rollback: set the affected OS `latest/stable/latest.txt` to the prior live tag; keep old binaries ≥ 30 days.

Canonical playbook: POS monorepo `MiniBook3/docs/release.md` · workflows §12.
