---
name: commit
description: >
  Generates a caveman commit message for staged changes and commits them. Delegates
  message generation to the caveman-commit skill, then executes the commit. Use when
  the user says "commit this", "write a commit", "commit these changes", or invokes
  /commit.
---

Generate a commit message for staged changes using the **caveman-commit** skill, then commit with that message.

## Steps

1. **Check staged changes.** Run `git diff --cached --stat`. If nothing is staged, stop and tell the user — do not stage files yourself. _Completion: know whether there are staged changes to commit._

2. **Invoke caveman-commit.** Use the `skill` tool to invoke `caveman-commit`. It will read the staged diff and generate a terse Conventional Commits message. _Completion: message generated and returned._

3. **Enforce line-length limits.** Commitlint's `body-max-line-length` rule (used by many CI
   pipelines) rejects body lines over 100 characters. Check every line of the subject and body
   from step 2:
   - Subject must stay ≤50 chars (already a caveman-commit rule — re-trim if it slipped through).
   - Each body line must be ≤100 chars. If a line exceeds 100 chars, hard-wrap it at a word
     boundary onto multiple lines instead of truncating content — never drop information to fit.
   _Completion: no subject or body line exceeds its limit._

4. **Commit the staged changes.** Take the (now-wrapped) message from step 3 and commit:
   - If the message has both subject and body, use: `git commit -m "<subject>" -m "<body>"`
   - If subject only, use: `git commit -m "<subject>"`
   - Include the Co-authored-by trailer: `Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>`
   
   Never use `git add` — only commit what's already staged. _Completion: commit created in repository._

5. **Show the result.** Run `git log -1 --stat` and display it so the user can verify. _Completion: user sees the commit details._

## Boundaries

Generates commit messages via caveman-commit and commits already-staged changes. Does not stage files, does not amend. Message-generation rules (tone, format, Conventional Commits type) live in caveman-commit; this skill owns the committing step and enforces commitlint's line-length limits (subject ≤50, body lines ≤100) as a safety net before the commit lands.
