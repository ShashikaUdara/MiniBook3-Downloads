# MiniBook3 — Delta packages (``.mb3delta``)

> **Audience:** Warehouse / release operators  
> **Format:** `mb3delta-v1` (zstd dictionary patch of the **full** artifact)  
> **Canonical design:** [`../../MiniBook3/docs/updates-delta.md`](../../MiniBook3/docs/updates-delta.md)  
> **POS phases:** **U7** (manifest) · **U8** (pack / apply / fallback)

---

## Plain language

Shops still always get a **full** installer on the Release. Optionally, also upload a **patch file** that turns last month’s full package into this month’s. Tills that still have last month’s package cached download the patch; everyone else downloads the full file. Safety checks (checksum + allowlist) are identical.

---

## When to publish a delta

| Ship | Publish delta? |
|------|----------------|
| Patch / UI / backend only (Qt/WebEngine unchanged) | **Yes** — usually much smaller |
| Qt / WebEngine / major native bump | Optional — may not shrink enough; full is enough |
| First release on a platform | **No** (no prior base) |

Always publish: full tarball/zip + `SHA256SUMS.txt`. Never remove the full artifact.

---

## Build (from POS tree)

```bash
cd Linux-MiniBook3   # or Windows-MiniBook3

python packaging/scripts/build_mb3delta.py \
  --old  path/to/minibook3-1.0.4-linux-x86_64.tar.gz \
  --new  path/to/minibook3-1.0.5-linux-x86_64.tar.gz \
  --from-version 1.0.4 \
  --to-version 1.0.5 \
  --platform linux \
  --out release/minibook3-1.0.4-to-1.0.5-linux-x86_64.mb3delta \
  --manifest-json release/delta-artifact-1.0.4-to-1.0.5.json
```

The script prints a JSON **artifact** fragment to paste into `channel-manifest.json` / `download-manifest.json`.

Naming:

`minibook3-{from}-to-{to}-{linux|windows}-x86_64.mb3delta`

---

## Warehouse / GitHub Release checklist

1. Upload **full** `minibook3-{to}-…tar.gz` (or Windows zip) as usual.  
2. Upload the `.mb3delta` next to it on the **same** `v{to}` Release tag.  
3. Add both digests to `SHA256SUMS.txt`.  
4. Extend channel + download manifests with a `kind: "delta"` artifact (see design doc). Keep the `kind: "tarball"` / `portable_zip` entry.  
5. Push warehouse `main` pointers (`latest.txt`, manifests) only after assets return HTTP **200**.

Example artifact entry:

```json
{
  "kind": "delta",
  "format": "mb3delta-v1",
  "from_version": "1.0.4",
  "to_version": "1.0.5",
  "filename": "minibook3-1.0.4-to-1.0.5-linux-x86_64.mb3delta",
  "url": "https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/download/v1.0.5/minibook3-1.0.4-to-1.0.5-linux-x86_64.mb3delta",
  "sha256": "<delta file sha>",
  "result_sha256": "<full new tarball sha — must match SHA256SUMS>",
  "result_filename": "minibook3-1.0.5-linux-x86_64.tar.gz",
  "result_kind": "tarball",
  "base_sha256": "<full old tarball sha>"
}
```

---

## How the till uses it (U8)

1. Plan prefers delta when `from_version` == installed version.  
2. Needs a **cached base** under `…/updates/base-cache/{from_version}/` (filled after any successful full download/verify of that version).  
3. If base missing → **full download** automatically (**E10**).  
4. Reconstruct → verify with existing `SHA256SUMS` → stage/apply unchanged.  
5. Lab force-full: `MINIBOOK3_UPDATE_DELTAS=0`.

**Note:** Shops that never completed a full download of version N cannot use the N→N+1 delta until they have that base (first upgrade after enabling deltas is often still full).

---

## Memory / size notes

Pack/apply loads the **base** artifact into memory as the zstd dictionary. Typical Linux full package ~190 MB after U6 — fine on 4 GB tills; avoid packing from machines with &lt;1 GB free RAM. Future `mb3delta-v2` may switch to streaming hdiffz if needed.
