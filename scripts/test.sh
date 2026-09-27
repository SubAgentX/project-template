#!/usr/bin/env bash
#
# Run this project's tests. Run locally with `./scripts/test.sh`; CI runs this
# on Linux and macOS and scripts/test.ps1 on Windows.
#
# Keep this file and scripts/test.ps1 doing the same thing. CI runs both, so
# a difference between them shows up as one platform failing.
#
# Replace the body below with your test runner. Exit non-zero on failure — CI
# decides pass or fail from this script's exit status.
#
#   Node    npm test
#   Python  pytest
#   Go      go test ./...
#   Rust    cargo test

set -euo pipefail

echo "No tests configured yet."
echo "Edit scripts/test.sh and scripts/test.ps1 to add a test runner."
