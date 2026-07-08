# Copilot Instructions

Personal collection of Copilot skills for software engineering workflows.

## Repository Structure

```
skills/
├── skills.yaml              # Central registry of all skills (local & remote)
├── install-skills.sh        # Installer that reads skills.yaml
└── skills/                  # Local skill implementations
    ├── caveman-commit/      # Terse Conventional Commits generator + auto-commit
    └── caveman-pr/          # PR description generator for BitBucket Stash
```

### Skill Format

Each skill in `skills/` follows the standard structure:
- `SKILL.md` — LLM-facing instructions (frontmatter + rules)
- `README.md` — Human-facing documentation

## Installation

```bash
# Install all skills from skills.yaml globally
./install-skills.sh
```

**Dependencies:** `yq` (YAML processor), `jq` (JSON processor), `npx` (npm package runner)

The installer:
1. Parses `skills.yaml` with `yq`
2. For remote skills (URLs): `npx skills add <url> --skill <name> -g -a github-copilot -y`
3. For local skills (paths): `npx skills add <path> -g -a github-copilot -y`
4. All installs target global scope (`-g`) for GitHub Copilot agent (`-a github-copilot`)

## Architecture

### Skills Registry (`skills.yaml`)

Centralized manifest for both:
- **Remote skills** — fetched from GitHub repos (e.g., vercel-labs/skills, mattpocock/skills)
- **Local skills** — implemented in `./skills/` subdirectories

Format:
```yaml
skills:
  - name: skill-name
    source: https://github.com/org/repo  # remote
  - name: local-skill
    source: ./skills/local-skill         # local path
```

### Local Skills: Caveman Style

Two skills share a common "caveman" writing voice — terse, exact, why over what:

#### caveman-commit
- Generates Conventional Commits messages: `<type>(<scope>): <subject>`
- Subject ≤50 chars, body only when "why" isn't obvious
- **Commits already-staged changes** — never stages files (`git add`) or amends
- Aborts if nothing is staged
- Auto-clarity: always includes body for breaking changes, security fixes, data migrations, reverts

Triggers: "write a commit", "commit message", `/caveman-commit`

#### caveman-pr
- Generates PR title + description from `<base>..HEAD` commit range
- Title: Conventional Commits format (same as caveman-commit)
- Description sections (in order):
  1. **Background** — why the change exists
  2. **Changes** — bullets grouped by area (not by commit)
  3. **Testing** — commands run, cases covered
  4. **Example of testing** — real test output (omitted if none exists)
- Copies result to clipboard via `pbcopy` for BitBucket Stash paste
- Never fabricates test output — says `- Not tested` if no verification exists

Triggers: "write a PR description", "describe this branch for a PR", `/caveman-pr [base]`

Base branch resolution: explicit arg → remote default (`origin/HEAD`) → `main` → `master`

## Conventions

### Commit Message Style

Follow Conventional Commits when working in this repo:
- Types: `feat`, `fix`, `refactor`, `perf`, `docs`, `test`, `chore`, `build`, `ci`, `style`, `revert`
- Use scopes: `(caveman-commit)`, `(caveman-pr)`, `(skills)` to indicate which area changed
- Recent examples:
  - `feat(caveman-pr): add PR description skill`
  - `docs(caveman-commit): rewrite skill as message generator`
  - `chore: add non-interactive flags to skills install`

### Skill Development

When adding new skills to `./skills/`:
1. Create a directory: `./skills/skill-name/`
2. Add `SKILL.md` with frontmatter:
   ```yaml
   ---
   name: skill-name
   description: >
     Concise description used in tool listings
   ---
   ```
3. Add `README.md` for humans
4. Register in `skills.yaml` with `source: ./skills/skill-name`
5. Run `./install-skills.sh` to test installation

### Shell Script Practices

`install-skills.sh` uses `< <(...)` process substitution and `</dev/tty` redirects to handle:
- YAML → JSON streaming (`yq -r '.skills[] | @json'`)
- Interactive prompts from `npx skills` during batch installs

## Git Workflow

- BitBucket Stash is the target platform (no GitHub CLI `gh pr create`)
- `caveman-pr` copies descriptions to clipboard for manual paste into Stash web UI
- Skills are installed globally, not per-project
