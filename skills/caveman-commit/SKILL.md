---
name: caveman-commit
description: >
  Terse commit workflow. Conventional Commits format: subject ≤50 chars, body only when "why" isn't obvious. Analyzes diff, asks before staging, commits with compressed message. Use when user says "commit", "write commit", "/commit", or stages changes.
allowed-tools: Bash
---

Terse commits. Conventional Commits. Why over what.

## Workflow

### 1. Analyze State

```bash
git status --porcelain
git diff --staged  # staged changes
git diff           # unstaged changes
```

Completion: know which files changed, whether staged or not.

### 2. Stage (if needed)

Nothing staged → **ask user which files to stage**. Never auto-stage without confirmation. Never commit secrets (.env, credentials.json, keys).

```bash
git add path/to/file
```

Completion: files staged for commit, or user explicitly declined (abort workflow).

### 3. Generate Message

From the diff:
- **Type**: `feat`, `fix`, `refactor`, `perf`, `docs`, `test`, `chore`, `build`, `ci`, `style`, `revert`
- **Scope**: module/area affected (optional)
- **Subject**: imperative mood, ≤50 chars (hard cap 72), no period
- **Body**: only for non-obvious *why*, breaking changes, migrations, reverts, linked issues

Format: `<type>(<scope>): <imperative summary>`

Body required for: breaking changes (!), security fixes, data migrations, reverts.

Banned: "This commit", "I", "we", "now", "currently", AI attribution, emoji, restating file names when scope says it.

Completion: message written, ready to commit.

### 4. Execute Commit

```bash
# Single line
git commit -m "type(scope): summary"

# Multi-line
git commit -m "$(cat <<'EOF'
type(scope): summary

Body explaining why.

Closes #42
EOF
)"
```

Completion: commit created.

## Safety

- Never `git commit --amend` without explicit request
- Never `--force` or hard reset
- Never `--no-verify` unless asked
- If hooks fail, fix and create NEW commit

## Examples

New endpoint with why:
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

