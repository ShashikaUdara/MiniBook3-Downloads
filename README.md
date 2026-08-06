# MiniBook3-Downloads

Public package warehouse for **MiniBook3** (Linux and Windows).

| Role | Location |
|------|----------|
| Installer binaries | [GitHub Releases](https://github.com/ShashikaUdara/MiniBook3-Downloads/releases) only |
| Thin update feed | This git tree (`linux/latest/…`, `windows/latest/…`) |
| Site download buttons | Zolestio Admin → Releases (paste Release asset URLs) |

**Rule:** never commit `.exe`, `.zip`, `.tar.gz`, AppImage, or `.deb` files. Stage them under `staging/` (gitignored) and upload with `gh release upload`.

## Current stable

| Platform | Version | Pointer |
|----------|---------|---------|
| Linux | **1.0.2** | `linux/latest/stable/latest.txt` |
| Windows | **1.0.2** | `windows/latest/stable/latest.txt` |

Release notes: [`RELEASE_NOTES_v1.0.2.md`](./RELEASE_NOTES_v1.0.2.md)  
Operator guide: [`docs/guide.md`](./docs/guide.md)

## Windows v1.0.2 — quick status

Thin feed in git is ready (manifests, `install.ps1`, checksums).  
Large Windows assets are staged locally under `staging/v1.0.2/` for the operator to attach to Release `v1.0.2` (see `docs/guide.md` §11).
