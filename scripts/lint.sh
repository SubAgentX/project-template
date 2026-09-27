#!/usr/bin/env bash
#
# Lint this project. Run locally with `./scripts/lint.sh`; CI runs this on
# Linux and macOS and scripts/lint.ps1 on Windows.
#
# Keep this file and scripts/lint.ps1 doing the same thing. CI runs both, so
# a difference between them shows up as one platform failing.
#
# Replace the body below with your linter. Exit non-zero on failure — CI
# decides pass or fail from this script's exit status.
#
#   Node    npm run lint
#   Python  ruff check . && ruff format --check .
#   Go      go vet ./... && golangci-lint run
#   Rust    cargo clippy -- -D warnings && cargo fmt --check
#   Shell   shellcheck scripts/*.sh

set -euo pipefail

echo "No linter configured yet."
echo "Edit scripts/lint.sh and scripts/lint.ps1 to add one."
