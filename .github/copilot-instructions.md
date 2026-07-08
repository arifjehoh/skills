# Copilot Instructions

Personal collection of Copilot skills for software engineering workflows.

**Canonical location:** `$HOME/skills`

## Setup

This repository must be cloned to `$HOME/skills`:

```bash
git clone <repository-url> $HOME/skills
cd $HOME/skills
./install-skills.sh
```

All local skills reference this location. Moving the repository will break skill creation and installation.

## Repository Structure

```
skills/
├── skills.yaml              # Central registry of all skills (local & remote)
├── install-skills.sh        # Installer that reads skills.yaml
└── skills/                  # Local skill implementations (SKILL.md + README.md)
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

### Working with Skills

**Adding a new local skill:**
1. Use `/create-skill` — wraps `writing-great-skills` to guide creation, then automatically creates files in `$HOME/skills/skills/`, registers in `skills.yaml`, and installs. Works from anywhere.
2. Manual alternative:
   - Create directory: `$HOME/skills/skills/skill-name/`
   - Add `SKILL.md` with frontmatter (name + description)
   - Add `README.md` for human documentation
   - Register in `$HOME/skills/skills.yaml` with `source: ./skills/skill-name`
   - Run `cd $HOME/skills && ./install-skills.sh` to install globally

**Adding a remote skill:**
1. Add to `skills.yaml` with `source: https://github.com/org/repo`
2. Run `./install-skills.sh`

**Removing a skill:**
- Use `npx skills remove <name> -g -a github-copilot`

**Composability:**
Local skills can invoke other skills via the `skill` tool — e.g., `commit` delegates message generation to community `caveman-commit`, then adds execution logic.

**Shell script notes:**
`install-skills.sh` uses `< <(...)` process substitution and `</dev/tty` redirects to handle YAML → JSON streaming and interactive prompts from `npx skills` during batch installs.
