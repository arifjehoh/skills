# instructions

My personal, cross-repo working agreement for how Copilot collaborates with me
(mindset, JIRA-ticket-to-PR workflow, branching, definition of done).

## How it's installed

`copilot-instructions.md` is symlinked to `~/.copilot/copilot-instructions.md` so the
Copilot CLI applies it globally across every repo and session:

```bash
ln -sf "$HOME/skills/instructions/copilot-instructions.md" "$HOME/.copilot/copilot-instructions.md"
```

`install-skills.sh` creates this symlink automatically.

## Editing

**Source of truth:** `$HOME/skills/instructions/copilot-instructions.md`. Edit this
file — never the symlink target — and changes take effect everywhere.

## Requirements

The Commits/PR section assumes the `commit` and `caveman-pr` skills are installed
(they're in `skills.yaml`, installed via `./install-skills.sh`).
