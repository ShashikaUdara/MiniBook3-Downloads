# MiniBook3 — hosted one-line Windows remote installer (IR-W02)
# Generated at build time — edit packaging/windows/install-remote.ps1.in
#
# Usage (GitHub Releases warehouse):
#   irm https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/latest/download/install.ps1 | iex
#   irm …/install.ps1 | iex -Version 1.0.2
#
# Local test host (legacy path layout):
#   irm http://127.0.0.1:8765/minibook3/windows/latest/install.ps1 | iex -BaseUrl http://127.0.0.1:8765/minibook3

#Requires -Version 5.1

[CmdletBinding()]
param(
    [string]$Version = "",
    [ValidateSet("stable", "beta")]
    [string]$Channel = "stable",
    [string]$BaseUrl = "",
    [switch]$DryRun,
    [switch]$Silent
)

$ErrorActionPreference = "Stop"

$DefaultBaseUrl = "https://github.com/ShashikaUdara/MiniBook3-Downloads/releases"
$DefaultVersion = "1.0.2"
$SupportedArch = "AMD64"

if ([string]::IsNullOrWhiteSpace($BaseUrl)) {
    if ($env:MINIBOOK3_INSTALL_BASE_URL) {
        $BaseUrl = $env:MINIBOOK3_INSTALL_BASE_URL.TrimEnd("/")
    } else {
        $BaseUrl = $DefaultBaseUrl
    }
}

function Show-Usage {
    @"
MiniBook3 — one-line Windows installer (remote bootstrap)

Usage:
  irm https://github.com/ShashikaUdara/MiniBook3-Downloads/releases/latest/download/install.ps1 | iex
  irm …/install.ps1 | iex -Version 1.0.2

Options:
  -Version X.Y.Z     Pin release version (default: baked / latest stable)
  -Channel NAME      stable or beta (default: stable)
  -BaseUrl URL       Override download base (GitHub …/releases or legacy CDN root)
  -DryRun            Print resolved URLs and exit
  -Silent            Forward silent install flags to setup.exe

Environment:
  MINIBOOK3_INSTALL_BASE_URL   Override download base URL
  MINIBOOK3_INSTALL_VERSION    Pin release version
"@
}

function Assert-Architecture {
    if ([System.Runtime.InteropServices.RuntimeInformation]::OSArchitecture.ToString() -ne $SupportedArch) {
        throw "Unsupported architecture. MiniBook3 Windows releases require $SupportedArch."
    }
}

function Get-VersionSlug([string]$Ver) {
    $clean = $Ver.Trim()
    if ($clean.StartsWith("v") -or $clean.StartsWith("V")) {
        $clean = $clean.Substring(1)
    }
    return "v$clean"
}

function Try-FetchText([string]$Url) {
    try {
        $text = (Invoke-WebRequest -Uri $Url -UseBasicParsing).Content.Trim()
        if ($text) { return $text }
    } catch {
        return $null
    }
    return $null
}

function Get-ResolvedVersion {
    if (-not [string]::IsNullOrWhiteSpace($Version)) {
        return $Version.Trim()
    }
    if ($env:MINIBOOK3_INSTALL_VERSION) {
        return $env:MINIBOOK3_INSTALL_VERSION.Trim()
    }
    if ($BaseUrl -match 'github\.com/.+/releases') {
        return $DefaultVersion
    }
    $candidates = @(
        "$BaseUrl/windows/latest/$Channel/latest.txt",
        "$BaseUrl/windows/$Channel/latest.txt"
    )
    foreach ($latestUrl in $candidates) {
        $resolved = Try-FetchText $latestUrl
        if ($resolved) { return $resolved }
    }
    return $DefaultVersion
}

function Get-SetupName([string]$Ver) {
    return "minibook3-$Ver-win64-setup.exe"
}

function Get-FileSha256([string]$Path) {
    return (Get-FileHash -Algorithm SHA256 -Path $Path).Hash.ToLowerInvariant()
}

function Assert-Checksum([string]$FilePath, [string]$ExpectedName, [string]$ManifestPath) {
    $lines = Get-Content -Path $ManifestPath
    $expected = ""
    foreach ($line in $lines) {
        if ($line -match '^\s*#') { continue }
        $parts = $line -split '\s+', 2
        if ($parts.Count -eq 2 -and $parts[1] -eq $ExpectedName) {
            $expected = $parts[0].ToLowerInvariant()
            break
        }
    }
    if (-not $expected) {
        throw "Checksum entry not found in manifest for: $ExpectedName"
    }
    $actual = Get-FileSha256 $FilePath
    if ($actual -ne $expected) {
        throw "Checksum verification failed for $ExpectedName.`n  Expected: $expected`n  Actual:   $actual"
    }
}

if ($PSBoundParameters.ContainsKey("Help")) {
    Show-Usage
    exit 0
}

Assert-Architecture
$resolvedVersion = Get-ResolvedVersion
$setupName = Get-SetupName $resolvedVersion
$slug = Get-VersionSlug $resolvedVersion

$pinned = (-not [string]::IsNullOrWhiteSpace($Version)) -or (-not [string]::IsNullOrWhiteSpace($env:MINIBOOK3_INSTALL_VERSION))
$isGitHub = $BaseUrl -match 'github\.com/.+/releases'
if ($isGitHub) {
    if ($pinned) {
        $setupUrl = "$BaseUrl/download/$slug/$setupName"
        $manifestUrl = "$BaseUrl/download/$slug/SHA256SUMS.txt"
    } else {
        $setupUrl = "$BaseUrl/latest/download/$setupName"
        $manifestUrl = "$BaseUrl/latest/download/SHA256SUMS.txt"
    }
} elseif ($pinned) {
    $setupUrl = "$BaseUrl/windows/$slug/$setupName"
    $manifestUrl = "$BaseUrl/windows/$slug/SHA256SUMS.txt"
} else {
    $setupUrl = "$BaseUrl/windows/latest/$setupName"
    $manifestUrl = "$BaseUrl/windows/latest/SHA256SUMS.txt"
}

if ($DryRun) {
    Write-Host "MiniBook3 remote install (dry run)"
    Write-Host "  Channel:  $Channel"
    Write-Host "  Version:  $resolvedVersion"
    Write-Host "  Base URL: $BaseUrl"
    Write-Host "  Setup:    $setupUrl"
    Write-Host "  Manifest: $manifestUrl"
    exit 0
}

$workDir = New-TemporaryFile | ForEach-Object { Remove-Item $_; New-Item -ItemType Directory -Path $_.FullName }
try {
    $setupPath = Join-Path $workDir.FullName $setupName
    $manifestPath = Join-Path $workDir.FullName "SHA256SUMS.txt"

    Write-Host "MiniBook3 — downloading v$resolvedVersion ($Channel)..."
    try {
        Invoke-WebRequest -Uri $setupUrl -OutFile $setupPath -UseBasicParsing
        Invoke-WebRequest -Uri $manifestUrl -OutFile $manifestPath -UseBasicParsing
    } catch {
        # Legacy flat layout fallback during CDN migration
        $setupUrl = "$BaseUrl/windows/$setupName"
        $manifestUrl = "$BaseUrl/windows/SHA256SUMS.txt"
        Write-Host "Falling back to legacy Windows CDN layout..."
        Invoke-WebRequest -Uri $setupUrl -OutFile $setupPath -UseBasicParsing
        Invoke-WebRequest -Uri $manifestUrl -OutFile $manifestPath -UseBasicParsing
    }

    Write-Host "Verifying SHA-256 checksum..."
    Assert-Checksum -FilePath $setupPath -ExpectedName $setupName -ManifestPath $manifestPath

    Write-Host "Launching installer..."
    if ($Silent) {
        Start-Process -FilePath $setupPath -ArgumentList "/VERYSILENT", "/SUPPRESSMSGBOXES", "/NORESTART" -Wait
    } else {
        Start-Process -FilePath $setupPath -Wait
    }

    Write-Host ""
    Write-Host "Remote install complete. Launch MiniBook3 from the Start Menu."
} finally {
    Remove-Item -Recurse -Force $workDir.FullName -ErrorAction SilentlyContinue
}
