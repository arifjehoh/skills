# Copilot Instructions

Personal collection of Copilot agent skills. This repo is both a **skills registry**
(`skills.yaml` + `install-skills.sh`) and a home for **locally-authored skills**
(`skills/*`). There is no application code, build, or test suite — the "product" is the
skills and the installer that publishes them globally.

## Canonical location

The repo **must** live at `$HOME/skills`. Local skills, `create-skill`, and the
installer all hard-code this path — cloning elsewhere breaks skill creation and the
global instructions symlink.

## Install / validate changes

There is no test or lint command. To apply and verify changes, run the installer:

```bash
cd $HOME/skills && ./install-skills.sh
```

It reads `skills.yaml`, installs every skill globally for the Copilot agent, then
symlinks `instructions/copilot-instructions.md` → `~/.copilot/copilot-instructions.md`.
Requires `yq`, `jq`, and `npx`. After changing a skill, reload skills or start a new
session before the change takes effect.

Install or reinstall a single skill without running the whole batch:

```bash
cd $HOME/skills && npx skills add ./skills/<skill-name> -g -a github-copilot -y   # local
npx skills add <repo-url> --skill <name> -g -a github-copilot -y                  # remote
npx skills remove <name> -g -a github-copilot                                     # uninstall
```

## Two instruction files — don't confuse them

- **`.github/copilot-instructions.md`** (this file) — repo-specific guidance for working
  *in* this repository.
- **`instructions/copilot-instructions.md`** — the author's **global** working agreement
  (mindset, JIRA-to-PR workflow, branching, commit rules). `install-skills.sh` symlinks
  it into `~/.copilot/`, so it applies to *every* repo/session. Edit the file in this
  repo — never edit the symlink target.

## Authoring a skill

Prefer `/create-skill` (wraps the community `writing-great-skills` skill, then creates
files, registers in `skills.yaml`, and installs). To add one manually:

1. Create `skills/<name>/` with `SKILL.md` and `README.md`.
2. Register it in `skills.yaml` with `source: ./skills/<name>`.
3. Run `./install-skills.sh`.

### SKILL.md conventions (follow the existing skills exactly)

- **Frontmatter**: `name` + a `description` that ends with explicit trigger phrases and
  the slash-command form (e.g. `Use when the user says "commit this"... or invokes
  /commit.`). The description is how the agent decides to fire the skill — be specific.
- **Body** is imperative instructions to the agent, not prose docs.
- **`## Steps`** are numbered, each ending with a `_Completion:_` / `*Completion
  criterion:*` marker stating how you know the step is done.
- **`## Boundaries`** at the end states what the skill does and explicitly does *not* do.

### Composability

Local skills orchestrate community skills via the `skill` tool rather than duplicating
their logic. `commit` delegates message generation to `caveman-commit` and only owns the
commit step; `create-skill` delegates authoring to `writing-great-skills`. When wrapping
a skill, own one concern and defer the rest — say so in `## Boundaries`.

## skills.yaml

Central manifest for both remote skills (`source:` is a GitHub URL) and local skills
(`source:` is `./skills/<name>`). The installer branches on whether `source` starts with
`http`. Keep new local skills registered here or they won't be installed.

## install-skills.sh gotchas

Uses `< <(yq ... | @json)` process substitution to stream YAML→JSON, and `</dev/tty` on
each `npx skills add` so the interactive prompts still reach the terminal during the
batch loop. Preserve both when editing the loop.
