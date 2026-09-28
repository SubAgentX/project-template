# CLAUDE.md

A language-agnostic project scaffold: structure, docs and CI, with no language
chosen yet. `scripts/init.sh` (or `init.ps1`) bootstraps a new project from it
and then deletes itself.

If the project needs a Next.js front end with a Python API behind it, use the
`nextjs-python-template` sibling instead of adding one here.

## The contract between CI and the scripts

`.github/workflows/ci.yml` never names a language. It checks out the repo and
runs the script pairs, then reads their exit status:

```
./scripts/lint.sh   /   scripts/lint.ps1
./scripts/test.sh   /   scripts/test.ps1
```

So adding a language means filling in those four bodies, not rewriting the
workflow. The only edit CI needs is the language setup step — `setup-node`,
`setup-python`, `setup-go` — at the marked spot in each job, which has
commented examples.

Two rules keep this honest:

- **Exit non-zero on failure.** CI decides pass or fail from the exit status
  alone, so a script that swallows an error produces a green build over broken
  code.
- **Each `.sh` and `.ps1` pair must do the same thing.** CI runs both halves on
  every push, so drift surfaces as one platform failing rather than as a
  surprise when you switch machines.

The scripts start as stubs that print a reminder and exit 0. The comment at the
top of each lists the usual commands per language.

### PowerShell gotcha

A failing native command does not fail a PowerShell script — it carries on and
still exits 0, which would turn a broken test suite into a green build. The
`.ps1` stubs set `$PSNativeCommandUseErrorActionPreference` to prevent that on
PowerShell 7.3+. On Windows PowerShell 5.1, check `$LASTEXITCODE` after each
command instead.

## Layout

```
src/            application source
tests/          automated tests, mirroring src/
docs/           anything too long for the README
scripts/        one .sh and .ps1 pair per job
```

`src/`, `tests/` and `docs/` are empty and held open by `.gitkeep`, because git
does not track empty directories. `init` removes a `.gitkeep` only once its
directory has real content.

## Conventions

- Comments explain why something exists, not what the line does. The existing
  files set the tone; match their density.
- Record changes in `CHANGELOG.md` under `Unreleased`.
- Document every environment variable in `.env.example` and in the README's
  configuration table. `.env` is gitignored; `.env.example` is not. Never commit
  a real secret.
- `README.md` holds a `TEMPLATE:START`/`TEMPLATE:END` block that `init` strips.
  Leave the markers in place when editing around them.
- `.gitattributes` normalizes everything to LF. CRLF in a `.sh` file breaks the
  shebang and the script will not run.

## Once this is a real project

Replace this section with the project's own facts: what it does, the commands
that actually run it, and any rule a newcomer would otherwise have to infer
from the code. That is what makes this file worth loading.
