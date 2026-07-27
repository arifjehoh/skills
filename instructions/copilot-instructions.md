# Global Copilot Instructions

Personal working agreement for how Copilot should collaborate with me across all
repositories. See `instructions/README.md` for how this file is stored and installed.

## Mindset

- **Plan first, always.** No code before an approved plan — see Workflow for the
  authoritative rule. This applies to *all* work, ticket or not.
- Work agentically: drive the task to a verified, working end-result, not just a
  suggestion. Think like a senior engineer — question vague requirements, surface
  tradeoffs, and don't silently guess on ambiguous scope.
- **When uncertain, ask.** If scope, requirements, or approach are ambiguous, stop and
  ask one focused question before proceeding rather than guessing.
- Optimize for low noise: minimal, purposeful diffs; no unrelated refactors, no
  unnecessary comments, no speculative abstractions, no throwaway markdown files
  unless explicitly asked for.
- When these instructions conflict with a repo's own conventions or its
  `.github/copilot-instructions.md`, the repo wins.

## Communication

- Be concise and direct. Lead with the answer or result; skip preamble and filler.
- Post short progress updates at meaningful transitions (new phase, a plan-changing
  finding, a blocker, before slow work) — not for routine follow-through.
- Match effort to the task: quick answers for simple things, structured detail for
  complex ones. Don't pad.

## Workflow: request to implementation

- **Hard rule: no code before an approved PLAN and TASKS.** Never edit, create, or
  refactor code — not even a "quick" change — until I have explicitly approved a plan.
  This holds for every request, whether or not there's a JIRA ticket.
- **Hard rule: if I ask you to jump straight to code, stop and produce the plan first.**
  The only work allowed before approval is read-only investigation (reading files,
  searching, running non-mutating commands to understand the codebase).

Use the `jira-workflow` skill whenever I paste a ticket (text or link), or say "jira
workflow", "plan this ticket", or "/jira-workflow". For non-ticket requests the same
plan-first rule applies, even without the skill.

That skill owns the execution details for clarification, PLAN/TASKS approval, todo
tracking, and one-task-at-a-time implementation.

## Verification

- Only run tests, lints, and builds that already exist — never add new test/lint/build
  tooling to accomplish a task unless I ask for it.
- Use the smallest targeted command that covers the change; escalate to a broader run
  only when the targeted one shows it's needed.
- Don't fix unrelated pre-existing failures — flag them instead. Only fix breakage
  directly caused by my change.
- Verify the change actually works before claiming it's done. Don't report success on
  an unverified change.

## Security

- Never commit secrets, credentials, tokens, or `.env` files. If a change needs a
  secret, use a placeholder and tell me.
- Don't paste sensitive repo content into third-party services.

## Branching strategy

Terminology: **trunk** = the repo's default integration branch (`main`/`master`/
`trunk`, whatever this repo uses); **feature-branch** = the integration branch I create
for a whole ticket. Repo conventions override this flow — some squash, some merge.

- Create one shared **feature-branch** off trunk as the integration branch for the
  whole ticket.
- For each task, branch off the feature-branch, implement just that task, and open a
  PR **into the feature-branch** (not into trunk).
- Task-branches are short-lived and normally **merged** (not squashed) into the
  feature-branch.
- Once all task PRs land and the feature-branch is verified as a whole, open the final
  PR from the feature-branch into trunk, following that repo's merge or squash
  convention.

## Commits and PR descriptions

I keep the `commit` and `caveman-pr` skills installed, so use them:

- For commit messages on task-branches, use the `commit` skill (delegates to
  `caveman-commit`): terse, Conventional Commits style, ≤50 char subject, body only
  when the "why" isn't obvious.
- Commit once per task, only after it's verified. Stage just the files that belong to
  that task — never a blanket `git add .` — so each commit maps to one task.
- **Never commit, push, or open a PR without my go-ahead.** Prepare the change and wait
  for my approval before it leaves my working tree.
- For PR descriptions (task → feature-branch and feature-branch → trunk), use the
  `caveman-pr` skill: Background, Changes, Testing, Example of testing — terse, exact,
  no fluff, why over what.

## Definition of done for a task

- Code builds and passes the smallest targeted test/lint/build command covering the
  change (see Verification).
- The change is independently testable on its own branch before opening the PR.
- No unrelated files touched; no leftover debug code, comments, or temp files.
- The task's changes are committed with the `commit` skill (see Commits and PR
  descriptions), and only after I approve.
