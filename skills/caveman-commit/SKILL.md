---
name: caveman-commit
description: >
  Ultra-compressed commit message generator that also commits staged changes. Cuts noise from
  commit messages while preserving intent and reasoning. Conventional Commits format. Subject
  ≤50 chars, body only when "why" isn't obvious. Commits already-staged files (never stages or
  amends). Use when user says "write a commit", "commit message", "generate commit",
  "/commit", or invokes /caveman-commit. Auto-triggers when staging changes.
---

Write commit messages terse and exact. Conventional Commits format. No fluff. Why over what.

## Rules

**Subject line:**
- `<type>(<scope>): <imperative summary>` — `<scope>` optional
- Types: `feat`, `fix`, `refactor`, `perf`, `docs`, `test`, `chore`, `build`, `ci`, `style`, `revert`
- Imperative mood: "add", "fix", "remove" — not "added", "adds", "adding"
- ≤50 chars when possible, hard cap 72
- No trailing period
- Match project convention for capitalization after the colon

**Body (only if needed):**
- Skip entirely when subject is self-explanatory
- Add body only for: non-obvious *why*, breaking changes, migration notes, linked issues
- Wrap at 72 chars
- Bullets `-` not `*`
- Reference issues/PRs at end: `Closes #42`, `Refs #17`

**What NEVER goes in:**
- "This commit does X", "I", "we", "now", "currently" — the diff says what
- "As requested by..." — use Co-authored-by trailer
- "Generated with Claude Code" or any AI attribution — unless the user's own rule requires an `Assisted-by`/AI-attribution trailer, then add it as a trailer
- Emoji (unless project convention requires)
- Restating the file name when scope already says it

## Examples

Diff: new endpoint for user profile with body explaining the why
- ❌ "feat: add a new endpoint to get user profile information from the database"
- ✅
  ```
  feat(api): add GET /users/:id/profile

  Mobile client needs profile data without the full user payload
  to reduce LTE bandwidth on cold-launch screens.

  Closes #128
  ```

Diff: breaking API change
- ✅
  ```
  feat(api)!: rename /v1/orders to /v1/checkout

  BREAKING CHANGE: clients on /v1/orders must migrate to /v1/checkout
  before 2026-06-01. Old route returns 410 after that date.
  ```

## Auto-Clarity

Always include body for: breaking changes, security fixes, data migrations, anything reverting a prior commit. Never compress these into subject-only — future debuggers need the context.

## Committing

After composing the message, commit the currently staged changes:

1. Inspect staged changes first: `git diff --cached --stat` (and `git diff --cached` for content). Base the message on what's actually staged.
2. If nothing is staged, stop and tell the user — do not stage files yourself, do not commit an empty tree.
3. Commit with the composed message: `git commit -F -` (pipe the message via stdin) or `git commit -m "<subject>" -m "<body>"`. Never use `git add`; only what the user already staged gets committed.
4. Show the resulting commit (`git log -1 --stat`) so the user can confirm.

Still does not stage files (`git add`) and does not amend unless the user explicitly asks.

## Boundaries

Generates the commit message and commits already-staged changes. Does not stage files, does not amend. "stop caveman-commit" or "normal mode": revert to verbose commit style.
