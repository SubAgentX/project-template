#!/usr/bin/env pwsh
#
# Lint this project. Run locally with `./scripts/lint.ps1`; CI runs this on
# Windows and scripts/lint.sh on Linux and macOS.
#
# Keep this file and scripts/lint.sh doing the same thing. CI runs both, so
# a difference between them shows up as one platform failing.
#
# Replace the body below with your linter. Exit non-zero on failure — CI
# decides pass or fail from this script's exit status.
#
#   Node    npm run lint
#   Python  ruff check .; ruff format --check .
#   Go      go vet ./...; golangci-lint run
#   Rust    cargo clippy -- -D warnings; cargo fmt --check

$ErrorActionPreference = 'Stop'

# PowerShell does NOT fail a script when a native command exits non-zero — it
# carries on and the script still exits 0. Without this, `npm run lint`
# failing would leave CI green on a broken build. 7.3+ can make native
# commands honour $ErrorActionPreference; on Windows PowerShell 5.1 check
# $LASTEXITCODE by hand after each command:
#
#     npm run lint
#     if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
#
if ($PSVersionTable.PSVersion -ge [version]'7.3') {
    $PSNativeCommandUseErrorActionPreference = $true
}

Write-Host 'No linter configured yet.'
Write-Host 'Edit scripts/lint.ps1 and scripts/lint.sh to add one.'
