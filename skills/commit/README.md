# commit

Commit staged changes with a caveman-style message.

## What it does

Wraps the community `caveman-commit` skill to generate a terse Conventional Commits message, then commits the currently staged changes with that message.

The message generation is delegated to `caveman-commit` (from https://github.com/juliusbrussee/caveman), which produces:
- Subject ≤50 chars in `<type>(<scope>): <summary>` format
- Body only when "why" isn't obvious
- No fluff, imperative mood

This skill adds the commit execution step — it takes the generated message and runs `git commit`.

## How to invoke

```
/commit
```

Also triggers on phrases like "commit this", "write a commit", "commit these changes".

## Example

You have staged changes:
```bash
$ git add src/auth.ts
$ git status --short
M  src/auth.ts
```

Invoke the skill:
```
/commit
```

Output:
```
fix(auth): validate token expiry before refresh

Prevents expired tokens from minting new access tokens.

Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>

 src/auth.ts | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)
```

## Prerequisites

The `caveman-commit` skill must be installed (from https://github.com/juliusbrussee/caveman or your skills registry).

## See also

- [`SKILL.md`](./SKILL.md) — full LLM-facing instructions
- Community caveman-commit: https://github.com/juliusbrussee/caveman
