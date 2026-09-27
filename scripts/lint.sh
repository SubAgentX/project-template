#!/usr/bin/env bash
#
# Lint this project. Run locally with `./scripts/lint.sh`; CI runs the same
# script, so a green run here means a green run there.
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
echo "Edit scripts/lint.sh to add one — see the comments at the top of the file."
