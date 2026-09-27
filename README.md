<!-- TEMPLATE:START -->
<!--
  Everything between the TEMPLATE markers explains how to USE this template.
  `scripts/init.sh` deletes this block automatically when you bootstrap a new
  project, leaving the clean README template below.
-->

# Project Template

> A generic, language-agnostic project scaffold. Start a new project with
> sensible structure, docs and tooling already in place.

## Start a new project from this template

Pick whichever fits how you work — all four produce the same tree.

**1. GitHub UI** — click the green **Use this template** button above, then
`git clone` your new repo. Cleanest option: you get a brand-new repository with
a single fresh commit and no inherited history.

**2. GitHub CLI** — one command, repo created and cloned:

```bash
gh repo create my-app --template SubAgentX/project-template --private --clone
cd my-app
```

**3. degit** — no GitHub repo, no git history, nothing to clean up:

```bash
npx degit SubAgentX/project-template my-app
cd my-app && git init
```

**4. Plain git** — works anywhere, no extra tooling:

```bash
git clone --depth=1 https://github.com/SubAgentX/project-template.git my-app
cd my-app && rm -rf .git && git init
```

## Then bootstrap it

```bash
./scripts/init.sh "My App" "SubAgentX/my-app"
```

That script replaces the placeholders, deletes the `.gitkeep` files, resets the
changelog, copies `.env.example` to `.env`, strips this template section from the
README, and finally removes itself. Run it with no arguments to be prompted.

<!-- TEMPLATE:END -->

# Project Name

> One-sentence description of what this project does and who it's for.

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

---

## Table of contents

- [Overview](#overview)
- [Project structure](#project-structure)
- [Getting started](#getting-started)
- [Usage](#usage)
- [Configuration](#configuration)
- [Testing](#testing)
- [Contributing](#contributing)
- [License](#license)
- [What else to put in this README](#what-else-to-put-in-this-readme)

---

## Overview

Explain the problem this project solves, the approach it takes, and anything a
newcomer needs to understand before reading the code. Two or three paragraphs is
usually enough.

**Status:** _Alpha / Beta / Stable_

---

## Project structure

```
.
├── .github/
│   └── workflows/          # CI/CD pipeline definitions (GitHub Actions)
├── docs/                   # Long-form documentation, diagrams, ADRs
├── scripts/                # Setup, build, deploy and maintenance scripts
│   └── init.sh             # One-time bootstrap; deletes itself after running
├── src/                    # Application source code
├── tests/                  # Automated tests, mirroring the src/ layout
├── .editorconfig           # Editor formatting rules shared across IDEs
├── .env.example            # Template for environment variables (copy to .env)
├── .gitignore              # Files and folders git should never track
├── CHANGELOG.md            # Human-readable record of notable changes
├── CONTRIBUTING.md         # How to contribute: branching, style, PR process
├── LICENSE                 # The project's license terms
└── README.md               # You are here
```

### What each directory is for

| Path | Purpose |
| :--- | :--- |
| `src/` | All production source code. Keep it free of test and build artifacts. |
| `tests/` | Automated tests. Mirror the `src/` folder layout so tests are easy to locate. |
| `docs/` | Anything too long for the README: architecture notes, API references, decision records. |
| `scripts/` | Repeatable developer tasks — bootstrapping, migrations, releases. |
| `.github/workflows/` | CI pipelines that run on push and pull request. |

> **Note:** empty directories contain a `.gitkeep` file, because git does not
> track empty folders. `scripts/init.sh` removes them for you.

---

## Getting started

### Prerequisites

List the tools and versions a developer needs before they begin.

- _e.g._ Node.js 20+ / Python 3.11+ / Go 1.22+
- Git

### Installation

```bash
# Clone the repository
git clone https://github.com/<owner>/<repo>.git
cd <repo>

# Install dependencies
# <your install command here, e.g. npm install / pip install -r requirements.txt>

# Copy the environment template and fill in your values
cp .env.example .env
```

---

## Usage

Show the shortest possible example that proves the project works, then link to
`docs/` for anything more involved.

```bash
# <your run command here>
```

---

## Configuration

Document every environment variable in `.env.example`. Keep this table in sync.

| Variable | Required | Default | Description |
| :--- | :--- | :--- | :--- |
| `APP_ENV` | No | `development` | Runtime environment name. |
| `API_KEY` | Yes | — | Credential for the upstream API. |

> Never commit real secrets. `.env` is gitignored; `.env.example` is not.

---

## Testing

```bash
# <your test command here>
```

Explain how to run a single test, and what the CI pipeline checks on every pull
request.

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for branching strategy, code style and the
pull request process.

---

## License

Distributed under the terms in [LICENSE](LICENSE).

---

## What else to put in this README

The sections above are the baseline. Add these as the project grows — a README
is a living document, and the wrong move is letting it drift out of date.

### Strongly recommended for most projects

- **Badges** — build status, test coverage, package version, license. They give
  readers a health check in one glance. Put them directly under the title.
- **A screenshot, GIF or diagram** — for anything with a UI or a non-obvious
  data flow, one image saves several paragraphs.
- **Quick start / TL;DR** — the three commands that get someone from zero to a
  running project. Many readers never scroll past this.
- **Architecture overview** — how the major pieces fit together, and why. Link
  to `docs/` for the deep version.
- **Troubleshooting / FAQ** — the errors people actually hit during setup.
  This is the single highest-value section for reducing support questions.

### Add when they apply

- **Roadmap** — what's planned next, so contributors know where to help.
- **Deployment** — how the project reaches production, including required
  secrets and rollback steps.
- **API reference** — endpoints, parameters and example requests/responses.
  Move to `docs/` once it outgrows a page.
- **Security policy** — how to report a vulnerability privately. Pair with a
  `SECURITY.md` file.
- **Performance / benchmarks** — if speed or resource use is a selling point.
- **Versioning policy** — state that you follow [SemVer](https://semver.org/)
  and link to [CHANGELOG.md](CHANGELOG.md).
- **Acknowledgements & credits** — upstream projects, contributors, funding.
- **Support channels** — issue tracker, discussions, chat, contact email.
- **Code of Conduct** — for any project accepting outside contributions. Pair
  with a `CODE_OF_CONDUCT.md` file.

### Principles worth keeping

1. **Lead with the "why."** A reader decides in ten seconds whether this project
   is relevant to them. Make the first sentence do that work.
2. **Every command should be copy-pasteable.** No placeholders a reader has to
   decode, and no steps assumed as "obvious."
3. **Prefer linking over inlining.** When a section passes roughly a screen of
   text, move it into `docs/` and leave a link behind.
4. **Update the README in the same commit as the change.** A stale README costs
   more trust than a missing one.
5. **Write for a newcomer, not for yourself.** Assume no prior knowledge of the
   codebase, the domain jargon, or your internal tooling.
