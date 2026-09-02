[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [ValidateNotNullOrEmpty()]
    [string]$Version = 'dev'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..')).Path
$distPath = Join-Path $repoRoot 'dist'
$cleanVersion = $Version.Trim()
if ($cleanVersion.StartsWith('v')) { $cleanVersion = $cleanVersion.Substring(1) }
if ([string]::IsNullOrWhiteSpace($cleanVersion)) { throw 'Version cannot be empty.' }

Push-Location $repoRoot
try {
    $insideWorkTree = (& git rev-parse --is-inside-work-tree 2>$null).Trim()
    if ($LASTEXITCODE -ne 0 -or $insideWorkTree -ne 'true') {
        throw 'package-release.ps1 must run inside a Git work tree.'
    }

    if (Test-Path -LiteralPath $distPath) {
        $resolvedDist = (Resolve-Path -LiteralPath $distPath).Path
        if (-not [string]::Equals($resolvedDist, $distPath, [System.StringComparison]::OrdinalIgnoreCase)) {
            throw "Unexpected distribution path: $resolvedDist"
        }
        Remove-Item -LiteralPath $resolvedDist -Recurse -Force
    }
    New-Item -ItemType Directory -Path $distPath | Out-Null

    $stagingPath = Join-Path $distPath '.staging'
    New-Item -ItemType Directory -Path $stagingPath | Out-Null

    $packages = @(
        @{ Folder = 'MSc'; File = 'TMU-Thesis-MSc.zip'; Root = "TMU-Thesis-MSc-$cleanVersion" },
        @{ Folder = 'PhD'; File = 'TMU-Thesis-PhD.zip'; Root = "TMU-Thesis-PhD-$cleanVersion" }
    )

    $sharedPaths = @('CHANGELOG.md', 'CITATION.cff', 'LICENSE', 'THIRD_PARTY_NOTICES.md', 'VERSION', 'docs', 'licenses')
    $sharedArchive = Join-Path $stagingPath 'shared.tar'
    & git archive --format=tar --output=$sharedArchive HEAD @sharedPaths
    if ($LASTEXITCODE -ne 0 -or -not (Test-Path -LiteralPath $sharedArchive)) {
        throw 'Failed to create the shared-files archive.'
    }

    $checksumLines = @()
    foreach ($package in $packages) {
        $zipPath = Join-Path $distPath $package.File
        $packageRoot = Join-Path $stagingPath $package.Root
        $degreeArchive = Join-Path $stagingPath "$($package.Folder).tar"
        New-Item -ItemType Directory -Path $packageRoot | Out-Null

        & git archive --format=tar --output=$degreeArchive "HEAD:$($package.Folder)"
        if ($LASTEXITCODE -ne 0 -or -not (Test-Path -LiteralPath $degreeArchive)) {
            throw "Failed to create the source archive for $($package.Folder)."
        }

        & tar -xf $degreeArchive -C $packageRoot
        if ($LASTEXITCODE -ne 0) { throw "Failed to extract $degreeArchive." }
        & tar -xf $sharedArchive -C $packageRoot
        if ($LASTEXITCODE -ne 0) { throw "Failed to extract $sharedArchive." }

        Compress-Archive -LiteralPath $packageRoot -DestinationPath $zipPath -CompressionLevel Optimal
        if (-not (Test-Path -LiteralPath $zipPath)) {
            throw "Failed to create $($package.File)."
        }
        $hash = (Get-FileHash -Algorithm SHA256 -LiteralPath $zipPath).Hash.ToLowerInvariant()
        $checksumLines += "$hash  $($package.File)"
    }

    Remove-Item -LiteralPath $stagingPath -Recurse -Force

    [System.IO.File]::WriteAllLines(
        (Join-Path $distPath 'SHA256SUMS.txt'),
        $checksumLines,
        [System.Text.UTF8Encoding]::new($false)
    )

    Get-ChildItem -LiteralPath $distPath -File | Select-Object Name, Length
}
finally {
    Pop-Location
}
