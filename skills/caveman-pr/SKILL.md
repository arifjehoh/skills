---
name: caveman-pr
description: >
  Generates a pull request title and description from the commits on the current branch
  compared to a base branch. Caveman writing: terse, exact, no fluff, why over what.
  Sections: Background, Changes, Testing, Example of testing. Copies the result to the
  clipboard with pbcopy for pasting into BitBucket Stash. Use when the user says
  "write a PR description", "PR description", "pull request description", "describe this
  branch for a PR", or invokes "/caveman-pr".
---

Write the PR title and description **caveman**: terse and exact, why over what, no fluff. Same voice as `caveman-commit`.

## Steps

1. **Resolve the range.** Current branch: `git branch --show-current`. Base branch: the argument the user gave, else the remote default (`git symbolic-ref --short refs/remotes/origin/HEAD`), else `main`, else `master`. Range is `<base>..HEAD`. If current and base resolve to the same ref, or the range is empty, stop and tell the user there is nothing to describe.

2. **Read every commit in the range.** `git log --no-merges <base>..HEAD` for messages, `git diff <base>...HEAD` for content. *Completion criterion: every non-merge commit in the range is accounted for in Changes — no commit dropped, none invented.*

3. **Compose the title.** Always Conventional Commits, same rules as `caveman-commit`: `<type>(<scope>): <summary>`, `<scope>` optional. One line, imperative, no trailing period, ≤50 chars when possible, hard cap 72. Types: `feat`, `fix`, `refactor`, `perf`, `docs`, `test`, `chore`, `build`, `ci`, `style`, `revert`. Append `!` after the type/scope for a breaking change (`feat(api)!: ...`). Pick the type that fits the outcome; when the branch spans several types, choose the one covering the primary change (`feat` beats `fix` beats `refactor`, etc.). The title names the outcome, not the branch name or ticket id.

4. **Compose the description** using the section format below.

5. **Copy to clipboard.** Pipe the title and description as one Markdown block to `pbcopy` (BitBucket Stash has no CLI PR creation). Use a quoted heredoc to preserve the formatting:
   ```
   pbcopy <<'EOF'
   <title>

   <description>
   EOF
   ```
   Also print the block so the user sees what was copied, then confirm it is on the clipboard.

## Section format

Fixed order. Drop a section only when it has no content (see each rule).

**Background** — why this change exists: the problem, gap, or request that motivated it. State the world before. Skip only if the diff is purely mechanical (e.g. a rename with no rationale).

**Changes** — what changed, as `-` bullets. One bullet per coherent change, grouped by area not by commit. The diff says the detail; each bullet is the outcome, not a file list.

**Testing** — how the change was verified: commands run, cases covered, manual steps. Pull from the diff (added/changed tests) and the commit messages. If nothing verifies it, write `- Not tested` — do not invent tests.

**Example of testing** — a fenced block showing a real test invocation and its output, when one exists in the diff, commit history, or session. Omit the section entirely when there is no real example — never fabricate output.

## Caveman voice

- Why over what. The diff says what; spend words on why.
- Imperative, present. "Add", "fix", "remove" — not "added", "this PR adds".
- Positive statements of the change. No "This PR does X", no "I", "we", "now", "currently".
- No ticket restatement, no AI attribution, no emoji unless project convention requires.
- Bullets `-` not `*`. Reference issues at the end of Background or in a trailer: `Closes #42`.

## Example

Title: `fix(auth): stop refresh token reuse after logout`

Description (rendered):

> ## Background
> Logged-out sessions kept a valid refresh token, so a stolen token minted new access tokens past logout. Closes #212.
>
> ## Changes
> - Revoke refresh token on logout, not just the access token
> - Reject refresh grants whose token is on the revocation list
>
> ## Testing
> - Unit: revoked token fails the refresh grant
> - Manual: logout, replay captured refresh request, get 401
>
> ## Example of testing
>
>     $ pytest tests/auth/test_refresh.py -q
>     ..                                                         [100%]
>     2 passed in 0.31s

The "Example of testing" block holds a real fenced command and its output; drop the section when no such example exists.

## Boundaries

Generates the title and description, prints it, and copies it to the clipboard with `pbcopy`. Does not open the PR, push, or commit (BitBucket Stash has no CLI PR creation). Reads git history and diff; writes nothing to the repo.
