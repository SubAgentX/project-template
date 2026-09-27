#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Bootstrap a fresh project from this template.

.DESCRIPTION
    Replaces the README placeholders, strips the template-usage section,
    tidies the .gitkeep files, resets the changelog, creates .env, and then
    removes the bootstrap scripts.

    This is the PowerShell counterpart of scripts/init.sh, for Windows users
    who are not running Git Bash or WSL. Run either one; both do the same
    thing and both delete each other when finished.

.EXAMPLE
    ./scripts/init.ps1 "My Project" "owner/repo"

.EXAMPLE
    ./scripts/init.ps1
    Prompts for anything not supplied.
#>

[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [string]$ProjectName,

    [Parameter(Position = 1)]
    [string]$RepoSlug
)

$ErrorActionPreference = 'Stop'

if (-not $ProjectName) { $ProjectName = Read-Host 'Project name' }
if (-not $RepoSlug)    { $RepoSlug    = Read-Host 'GitHub repo (owner/name), or blank to skip' }

$root = Split-Path -Parent $PSScriptRoot
Set-Location -LiteralPath $root

# Write UTF-8 without a BOM so the output matches what init.sh produces.
# Windows PowerShell's Set-Content would otherwise prepend a BOM, which shows
# up as stray characters at the top of the README on other platforms.
$utf8NoBom = [System.Text.UTF8Encoding]::new($false)
function Write-TextFile {
    param([string]$Path, [string]$Content)
    [System.IO.File]::WriteAllText($Path, $Content, $utf8NoBom)
}

$readmePath = Join-Path $root 'README.md'
$readme = [System.IO.File]::ReadAllText($readmePath)

Write-Host '==> Stripping the template-usage section from README.md'
$readme = [regex]::Replace(
    $readme,
    '(?s)<!-- TEMPLATE:START -->.*?<!-- TEMPLATE:END -->\r?\n?',
    ''
)
# Drop the blank lines the removal leaves at the top of the file.
$readme = [regex]::Replace($readme, '^(\s*\r?\n)+', '')

Write-Host "==> Setting project name to '$ProjectName'"
$readme = [regex]::Replace($readme, '(?m)^# Project Name', "# $ProjectName")

if ($RepoSlug) {
    Write-Host "==> Setting repo to '$RepoSlug'"
    $repoName = ($RepoSlug -split '/')[-1]
    $readme = $readme.Replace('<owner>/<repo>', $RepoSlug)
    $readme = $readme.Replace('cd <repo>', "cd $repoName")
}

Write-TextFile -Path $readmePath -Content $readme

# Only drop a .gitkeep once its directory holds real content. Git cannot track
# an empty directory, so removing them all here would delete the scaffold's
# structure from the very first commit.
Write-Host '==> Tidying .gitkeep placeholders'
foreach ($keep in Get-ChildItem -LiteralPath $root -Recurse -Force -File -Filter '.gitkeep') {
    $siblings = Get-ChildItem -LiteralPath $keep.DirectoryName -Force |
                Where-Object { $_.Name -ne '.gitkeep' }
    # Substring rather than [System.IO.Path]::GetRelativePath: that method is
    # .NET Core only, and Windows PowerShell 5.1 runs on .NET Framework.
    $relative = $keep.FullName.Substring($root.Length).TrimStart('\','/')
    if ($siblings) {
        Remove-Item -LiteralPath $keep.FullName -Force
        Write-Host "    removed $relative (directory has content)"
    }
    else {
        Write-Host "    kept    $relative (directory still empty)"
    }
}

Write-Host '==> Resetting CHANGELOG.md'
$changelog = @'
# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Added

### Changed

### Fixed
'@
Write-TextFile -Path (Join-Path $root 'CHANGELOG.md') -Content ($changelog.Replace("`r`n", "`n") + "`n")

$envPath    = Join-Path $root '.env'
$envExample = Join-Path $root '.env.example'
if ((-not (Test-Path -LiteralPath $envPath)) -and (Test-Path -LiteralPath $envExample)) {
    Write-Host '==> Creating .env from .env.example'
    Copy-Item -LiteralPath $envExample -Destination $envPath
}

Write-Host '==> Removing the bootstrap scripts'
$scriptsDir = Join-Path $root 'scripts'
foreach ($name in @('init.sh', 'init.ps1')) {
    $path = Join-Path $scriptsDir $name
    if (Test-Path -LiteralPath $path) { Remove-Item -LiteralPath $path -Force }
}

# The bootstrap scripts were the only thing in scripts/, so restore the
# placeholder to keep the directory in version control.
if (-not (Get-ChildItem -LiteralPath $scriptsDir -Force)) {
    Write-TextFile -Path (Join-Path $scriptsDir '.gitkeep') `
                   -Content "# Helper scripts (build, setup, deploy) live here.`n"
}

Write-Host ''
Write-Host "Done. '$ProjectName' is ready."
Write-Host 'Next: replace LICENSE, fill in README.md, and start writing code in src/.'
