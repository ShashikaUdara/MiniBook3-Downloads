#!/usr/bin/env bash
# MiniBook3 — hosted one-line Linux remote installer (IR-L02 / IR-L03)
# Generated at build time — edit packaging/linux/install-remote.sh.in
#
# Usage (GitHub Releases warehouse):
#   curl -fsSL https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/latest/download/install.sh | bash
#   curl -fsSL …/releases/latest/download/install.sh | bash -s -- --version 1.0.2
#
# Local test host (legacy path layout):
#   curl -fsSL http://127.0.0.1:8765/minibook3/linux/latest/install.sh | bash -s -- \
#     --base-url http://127.0.0.1:8765/minibook3 --version 1.0.2

set -euo pipefail

DEFAULT_BASE_URL="https://github.com/ShashikaUdara/MiniBook3-Downloads/releases"
DEFAULT_VERSION="1.0.2"
DEFAULT_CHANNEL="stable"
SUPPORTED_ARCH="x86_64"

VERSION=""
CHANNEL="${DEFAULT_CHANNEL}"
BASE_URL="${MINIBOOK3_INSTALL_BASE_URL:-${DEFAULT_BASE_URL}}"
DRY_RUN=0
INSTALL_ARGS=()

usage() {
  cat <<EOF
MiniBook3 — one-line Linux installer (remote bootstrap)

Downloads the release tarball, verifies SHA-256, extracts, and runs install.sh.

Usage:
  curl -fsSL https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/latest/download/install.sh | bash
  curl -fsSL …/install.sh | bash -s -- --version 1.0.2
  curl -fsSL …/install.sh | bash -s -- [options]

Options:
  --version X.Y.Z       Pin release version (default: latest stable / baked version)
  --channel NAME        Release channel: stable or beta (default: stable)
  --base-url URL        Override download base URL (GitHub …/releases or legacy CDN root)
  --dry-run             Print resolved URLs and exit
  --help                Show this help

Forwarded install.sh options:
  --prefix PATH         Install location (default: ~/.local/opt/minibook3)
  --no-desktop          Skip applications menu desktop entry
  --no-bin              Skip ~/.local/bin/minibook3 launcher
  --no-icon             Skip hicolor theme icons
  --skip-deps-check     Skip system library pre-flight check

Environment:
  MINIBOOK3_INSTALL_BASE_URL   Override download base URL
  MINIBOOK3_INSTALL_VERSION    Pin release version
EOF
}

mb3_require_command() {
  local cmd="$1"
  if ! command -v "${cmd}" >/dev/null 2>&1; then
    echo "Required command not found: ${cmd}" >&2
    exit 1
  fi
}

mb3_detect_arch() {
  local arch
  arch="$(uname -m)"
  case "${arch}" in
    x86_64|amd64)
      echo "x86_64"
      ;;
    *)
      echo "Unsupported architecture: ${arch}. MiniBook3 Linux releases require ${SUPPORTED_ARCH}." >&2
      exit 1
      ;;
  esac
}

mb3_fetch_text() {
  local url="$1"
  curl -fsSL "${url}"
}

mb3_is_github_releases_base() {
  case "${BASE_URL}" in
    *github.com*/releases) return 0 ;;
    *) return 1 ;;
  esac
}

mb3_resolve_version() {
  if [[ -n "${VERSION}" ]]; then
    echo "${VERSION}"
    return 0
  fi

  if [[ -n "${MINIBOOK3_INSTALL_VERSION:-}" ]]; then
    echo "${MINIBOOK3_INSTALL_VERSION}"
    return 0
  fi

  if mb3_is_github_releases_base; then
    # GitHub Releases: use the version baked into this install.sh asset.
    echo "${DEFAULT_VERSION}"
    return 0
  fi

  local latest_url="${BASE_URL}/linux/latest/${CHANNEL}/latest.txt"
  local resolved=""
  if resolved="$(mb3_fetch_text "${latest_url}" 2>/dev/null | tr -d '[:space:]')"; then
    if [[ -n "${resolved}" ]]; then
      echo "${resolved}"
      return 0
    fi
  fi

  # Legacy feed fallback
  latest_url="${BASE_URL}/linux/${CHANNEL}/latest.txt"
}

mb3_tarball_name() {
  local ver="$1"
  echo "minibook3-${ver}-linux-x86_64.tar.gz"
}

mb3_release_dir_name() {
  local ver="$1"
  echo "minibook3-${ver}-linux"
}

mb3_version_slug() {
  local ver="$1"
  ver="${ver#v}"
  echo "v${ver}"
}

mb3_build_urls() {
  local ver="$1"
  local slug
  slug="$(mb3_version_slug "${ver}")"
  TARBALL_NAME="$(mb3_tarball_name "${ver}")"
  RELEASE_DIR_NAME="$(mb3_release_dir_name "${ver}")"
  if mb3_is_github_releases_base; then
    TARBALL_URL="${BASE_URL}/download/${slug}/${TARBALL_NAME}"
    MANIFEST_URL="${BASE_URL}/download/${slug}/SHA256SUMS.txt"
    if [[ -z "${VERSION}" && -z "${MINIBOOK3_INSTALL_VERSION:-}" ]]; then
      TARBALL_URL="${BASE_URL}/latest/download/${TARBALL_NAME}"
      MANIFEST_URL="${BASE_URL}/latest/download/SHA256SUMS.txt"
    fi
  else
    TARBALL_URL="${BASE_URL}/linux/latest/${TARBALL_NAME}"
    MANIFEST_URL="${BASE_URL}/linux/latest/SHA256SUMS.txt"
    if [[ -n "${VERSION}" || -n "${MINIBOOK3_INSTALL_VERSION:-}" ]]; then
      TARBALL_URL="${BASE_URL}/linux/${slug}/${TARBALL_NAME}"
      MANIFEST_URL="${BASE_URL}/linux/${slug}/SHA256SUMS.txt"
    fi
  fi
}

mb3_verify_sha256() {
  local file_path="$1"
  local expected_name="$2"
  local manifest_path="$3"

  local expected actual
  expected="$(awk -v name="${expected_name}" '$2 == name { print $1; exit }' "${manifest_path}")"
  if [[ -z "${expected}" ]]; then
    echo "Checksum entry not found in manifest for: ${expected_name}" >&2
    echo "Manifest: ${manifest_path}" >&2
    exit 1
  fi

  actual="$(sha256sum "${file_path}" | awk '{print $1}')"
  if [[ "${expected}" != "${actual}" ]]; then
    echo "Checksum verification failed for ${expected_name}." >&2
    echo "  Expected: ${expected}" >&2
    echo "  Actual:   ${actual}" >&2
    echo "Download may be corrupted or tampered. Aborting install." >&2
    exit 1
  fi
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --version)
      VERSION="$2"
      shift 2
      ;;
    --channel)
      CHANNEL="$2"
      shift 2
      ;;
    --base-url)
      BASE_URL="${2%/}"
      shift 2
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    --prefix|--no-desktop|--no-bin|--no-icon|--skip-deps-check)
      INSTALL_ARGS+=("$1")
      if [[ "$1" == "--prefix" ]]; then
        INSTALL_ARGS+=("$2")
        shift 2
      else
        shift
      fi
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

case "${CHANNEL}" in
  stable|beta) ;;
  *)
    echo "Unsupported channel: ${CHANNEL} (use stable or beta)" >&2
    exit 1
    ;;
esac

mb3_require_command curl
mb3_require_command tar
mb3_require_command sha256sum
mb3_detect_arch >/dev/null

RESOLVED_VERSION="$(mb3_resolve_version)"
mb3_build_urls "${RESOLVED_VERSION}"

if [[ "${DRY_RUN}" -eq 1 ]]; then
  echo "MiniBook3 remote install (dry run)"
  echo "  Channel:  ${CHANNEL}"
  echo "  Version:  ${RESOLVED_VERSION}"
  echo "  Base URL: ${BASE_URL}"
  echo "  Tarball:  ${TARBALL_URL}"
  echo "  Manifest: ${MANIFEST_URL}"
  if [[ ${#INSTALL_ARGS[@]} -gt 0 ]]; then
    echo "  Install args: ${INSTALL_ARGS[*]}"
  fi
  exit 0
fi

WORK_DIR="$(mktemp -d "${TMPDIR:-/tmp}/minibook3-install.XXXXXX")"
cleanup() {
  rm -rf "${WORK_DIR}"
}
trap cleanup EXIT

TARBALL_PATH="${WORK_DIR}/${TARBALL_NAME}"
MANIFEST_PATH="${WORK_DIR}/SHA256SUMS.txt"

echo "MiniBook3 — downloading v${RESOLVED_VERSION} (${CHANNEL})..."
curl -fL --progress-bar "${TARBALL_URL}" -o "${TARBALL_PATH}"
curl -fsSL "${MANIFEST_URL}" -o "${MANIFEST_PATH}"

echo "Verifying SHA-256 checksum..."
mb3_verify_sha256 "${TARBALL_PATH}" "${TARBALL_NAME}" "${MANIFEST_PATH}"

EXTRACT_DIR="${WORK_DIR}/extract"
mkdir -p "${EXTRACT_DIR}"
tar -xzf "${TARBALL_PATH}" -C "${EXTRACT_DIR}"

RELEASE_DIR="${EXTRACT_DIR}/${RELEASE_DIR_NAME}"
if [[ ! -d "${RELEASE_DIR}" ]]; then
  echo "Release directory not found after extract: ${RELEASE_DIR_NAME}" >&2
  exit 1
fi

if [[ ! -x "${RELEASE_DIR}/install.sh" ]]; then
  echo "Installer not found in release archive: ${RELEASE_DIR}/install.sh" >&2
  exit 1
fi

echo "Running bundled installer..."
bash "${RELEASE_DIR}/install.sh" "${INSTALL_ARGS[@]}"

echo ""
echo "Remote install complete. Launch MiniBook3 from your applications menu or run: minibook3"
