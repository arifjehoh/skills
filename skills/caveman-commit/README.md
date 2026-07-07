# caveman-commit

Terse commit workflow. Analyzes diff, asks before staging, commits with compressed message.

## What it does

Full git commit workflow in Conventional Commits format:
1. Analyzes staged/unstaged changes
2. If nothing staged, asks which files to stage
3. Generates terse message (subject ≤50 chars, body only when *why* isn't obvious)
4. Executes `git commit`

Imperative mood. Body required for breaking changes, security fixes, migrations, reverts.

## How to invoke

```
/caveman-commit
```

Also triggers on "commit", "write commit", or when you stage changes.

## Example commits

New endpoint:
```
feat(api): add GET /users/:id/profile

Mobile client needs profile data without full user payload
to reduce LTE bandwidth on cold-launch screens.

Closes #128
```

Breaking change:
```
feat(api)!: rename /v1/orders to /v1/checkout

BREAKING CHANGE: clients must migrate before 2026-06-01.
Old route returns 410 after that date.
```

## See also

- [`SKILL.md`](./SKILL.md) — full workflow
- Original: https://www.skills.sh/juliusbrussee/caveman/caveman-commit

