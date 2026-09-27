#!/usr/bin/env bash
#
# Bootstrap a fresh project from this template.
#
#   ./scripts/init.sh "My Project" "owner/repo"
#
# Replaces placeholders, removes .gitkeep files, resets the changelog,
# and then deletes itself.

set -euo pipefail

PROJECT_NAME="${1:-}"
REPO_SLUG="${2:-}"

if [[ -z "$PROJECT_NAME" ]]; then
  read -rp "Project name: " PROJECT_NAME
fi
if [[ -z "$REPO_SLUG" ]]; then
  read -rp "GitHub repo (owner/name), or blank to skip: " REPO_SLUG
fi

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

# macOS ships BSD sed, which needs an argument to -i; GNU sed does not.
if sed --version >/dev/null 2>&1; then
  sed_i() { sed -i "$@"; }
else
  sed_i() { sed -i '' "$@"; }
fi

echo "==> Stripping the template-usage section from README.md"
sed_i '/<!-- TEMPLATE:START -->/,/<!-- TEMPLATE:END -->/d' README.md

echo "==> Setting project name to '$PROJECT_NAME'"
sed_i "s|^# Project Name|# ${PROJECT_NAME}|" README.md

if [[ -n "$REPO_SLUG" ]]; then
  echo "==> Setting repo to '$REPO_SLUG'"
  sed_i "s|<owner>/<repo>|${REPO_SLUG}|g; s|https://github.com/<owner>/<repo>.git|https://github.com/${REPO_SLUG}.git|g" README.md
  sed_i "s|cd <repo>|cd $(basename "$REPO_SLUG")|g" README.md
fi

# Only drop a .gitkeep once its directory holds real content. Git cannot track
# an empty directory, so removing them all here would delete the scaffold's
# structure from the very first commit.
echo "==> Tidying .gitkeep placeholders"
while IFS= read -r keep; do
  dir="$(dirname "$keep")"
  if [[ -n "$(find "$dir" -mindepth 1 -maxdepth 1 ! -name .gitkeep -print -quit)" ]]; then
    rm -- "$keep"
    echo "    removed $keep (directory has content)"
  else
    echo "    kept    $keep (directory still empty)"
  fi
done < <(find . -name .gitkeep -type f)

echo "==> Resetting CHANGELOG.md"
cat > CHANGELOG.md <<'CHANGELOG'
# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Added

### Changed

### Fixed
CHANGELOG

if [[ ! -f .env && -f .env.example ]]; then
  echo "==> Creating .env from .env.example"
  cp .env.example .env
fi

echo "==> Removing this bootstrap script"
rm -- "$ROOT/scripts/init.sh"
# This script was the only thing in scripts/, so restore the placeholder to
# keep the directory in version control.
if [[ -z "$(find "$ROOT/scripts" -mindepth 1 -maxdepth 1 -print -quit)" ]]; then
  echo "# Helper scripts (build, setup, deploy) live here." > "$ROOT/scripts/.gitkeep"
fi

echo
echo "Done. '$PROJECT_NAME' is ready."
echo "Next: replace LICENSE, fill in README.md, and start writing code in src/."
