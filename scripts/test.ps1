#!/usr/bin/env pwsh
#
# Run this project's tests. Run locally with `./scripts/test.ps1`; CI runs
# this on Windows and scripts/test.sh on Linux and macOS.
#
# Keep this file and scripts/test.sh doing the same thing. CI runs both, so
# a difference between them shows up as one platform failing.
#
# Replace the body below with your test runner. Exit non-zero on failure —
# CI decides pass or fail from this script's exit status.
#
#   Node    npm test
#   Python  pytest
#   Go      go test ./...
#   Rust    cargo test

$ErrorActionPreference = 'Stop'

# PowerShell does NOT fail a script when a native command exits non-zero — it
# carries on and the script still exits 0. Without this, a failing test suite
# would leave CI green. 7.3+ can make native commands honour
# $ErrorActionPreference; on Windows PowerShell 5.1 check $LASTEXITCODE by
# hand after each command:
#
#     pytest
#     if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
#
if ($PSVersionTable.PSVersion -ge [version]'7.3') {
    $PSNativeCommandUseErrorActionPreference = $true
}

Write-Host 'No tests configured yet.'
Write-Host 'Edit scripts/test.ps1 and scripts/test.sh to add a test runner.'
