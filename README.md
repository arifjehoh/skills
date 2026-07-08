# skills

Personal collection of Copilot skills for software engineering workflows.

**Canonical location:** `$HOME/skills`

## setup

Clone this repository to `$HOME/skills`:

```bash
git clone <repository-url> $HOME/skills
cd $HOME/skills
```

## what's inside

Local skills that wrap or extend community skills:

- **commit** — commits staged changes with caveman-style messages (wraps community `caveman-commit`)
- **caveman-pr** — generates PR descriptions for BitBucket Stash

Plus a registry (`skills.yaml`) that pulls in remote skills from the community.

## prerequisites

- `yq` — YAML processor (`brew install yq`)
- `npx` — npm package runner

## usage

Install all skills (local + remote) globally:

```bash
./install-skills.sh
```

Then use them:
```bash
/commit              # commit staged changes
/caveman-pr main     # generate PR description vs main branch
```

## architecture

**Composable skills** — local skills can invoke remote skills via the `skill` tool. Example: `commit` delegates message generation to community `caveman-commit`, then adds the commit execution step.

See [`.github/copilot-instructions.md`](.github/copilot-instructions.md) for full documentation.
