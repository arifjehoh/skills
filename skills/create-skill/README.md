# create-skill

Create a new skill in the canonical skills repository (`$HOME/skills`) with guidance from `writing-great-skills`.

## What it does

Wraps the `writing-great-skills` skill to:
1. Generate skill content with best practices
2. Create the skill directory and files in `$HOME/skills/skills/`
3. Register the skill in `$HOME/skills/skills.yaml`
4. Install the skill globally

Works from anywhere on your system — always targets `$HOME/skills`.

## How to invoke

```
/create-skill
```

Also triggers on phrases like "create a skill", "new skill", "add a skill".

## Example

You're anywhere on your system:
```bash
$ pwd
/Users/arif/other-project
```

Invoke the skill:
```
/create-skill
```

The skill will:
1. Verify `$HOME/skills` exists
2. Use `writing-great-skills` to help you design the skill
3. Create `$HOME/skills/skills/your-skill/SKILL.md` and `README.md`
4. Add to `$HOME/skills/skills.yaml`
5. Install with `npx skills add`
6. Tell you to reload skills in your session

## Prerequisites

- The `writing-great-skills` skill must be installed
- Skills repository must exist at `$HOME/skills`

## Boundaries

Always creates skills in `$HOME/skills` (canonical location). Creates local skills, not remote ones.

## See also

- [`SKILL.md`](./SKILL.md) — full LLM-facing instructions
- `writing-great-skills` — the skill creation guide this wraps
