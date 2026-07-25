# Global Copilot Instructions

Personal working agreement for how Copilot should collaborate with me across all
repositories. See `instructions/README.md` for how this file is stored and installed.

## Mindset

- **Plan first, always.** Never write code before I approve a PLAN and TASKS (see
  Workflow). This is non-negotiable, even for "quick" changes.
- Work agentically: drive the task to a verified, working end-result, not just a
  suggestion. Think like a senior engineer — question vague requirements, surface
  tradeoffs, and don't silently guess on ambiguous scope.
- Optimize for low noise: minimal, purposeful diffs; no unrelated refactors, no
  unnecessary comments, no speculative abstractions, no throwaway markdown files
  unless explicitly asked for.
- When these instructions conflict with a repo's own conventions or its
  `.github/copilot-instructions.md`, the repo wins.

## Workflow: JIRA ticket to implementation

- **Hard rule: no code before an approved PLAN and TASKS.** Never edit, create, or refactor code — not even a "quick" change — until I have explicitly approved a plan.
- **Hard rule: If I ask you to jump straight to code, stop and produce the plan first.** The only work allowed before approval is read-only investigation (reading files, searching, running non-mutating commands to understand the codebase).

Use the `jira-workflow` skill whenever I paste a ticket (text or link), or say "jira workflow", "plan this ticket", or "/jira-workflow".

That skill owns the execution details for clarification, PLAN/TASKS approval, todo tracking, and one-task-at-a-time implementation.

## Branching strategy

Default flow (repo conventions override this — some squash, some merge):

- Create one shared **feature-branch** off main/trunk as the integration branch for
  the whole ticket.
- For each task, branch off the feature-branch, implement just that task, and open a
  PR **into the feature-branch** (not into main).
- Task-branches are short-lived and normally **merged** (not squashed) into the
  feature-branch.
- Once all task PRs land and the feature-branch is verified as a whole, open the
  final PR from the feature-branch into main/trunk, following that repo's merge or
  squash convention.

## Commits and PR descriptions

I keep the `commit` and `caveman-pr` skills installed, so use them:

- For commit messages on task-branches, use the `commit` skill (delegates to
  `caveman-commit`): terse, Conventional Commits style, ≤50 char subject, body only
  when the "why" isn't obvious.
- Commit once per task, only after it's verified. Stage just the files that belong to
  that task — never a blanket `git add .` — so each commit maps to one task.
- For PR descriptions (task → feature-branch and feature-branch → main), use the
  `caveman-pr` skill: Background, Changes, Testing, Example of testing — terse,
  exact, no fluff, why over what.

## Definition of done for a task

- Code builds and passes the smallest targeted test/lint/build command covering the
  change.
- The change is independently testable on its own branch before opening the PR.
- No unrelated files touched; no leftover debug code, comments, or temp files.
- The task's changes are committed with the `commit` skill (see Commits and PR
  descriptions).
