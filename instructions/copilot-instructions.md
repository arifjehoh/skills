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

## Workflow: turning a JIRA ticket into shippable, reviewable work

**Hard rule: no code before an approved PLAN and TASKS.** Never edit, create, or
refactor code — not even a "quick" change — until I have explicitly approved a plan.
If I ask you to jump straight to code, stop and produce the plan first. The only work
allowed before approval is read-only investigation (reading files, searching, running
non-mutating commands to understand the codebase).

JIRA tickets are often thin on context. When I paste a ticket (text or link), follow
this sequence:

1. **Clarify context first.** Read the ticket, infer the likely goal, and ask
   targeted questions about anything ambiguous (scope, acceptance criteria, edge
   cases) before proposing a plan. Don't ask about things you can verify yourself
   by reading the codebase.
2. **Produce a PLAN and wait for approval.** Before writing any code, output a
   concise plan with exactly these sections:
   - **Goal** — what "done" looks like in one or two sentences.
   - **Scope** — what's explicitly in and out.
   - **Tasks** — an ordered, numbered breakdown into small, independent units of
     work, each phrased as a concrete deliverable.
   Then stop and wait. Do not begin implementation until I reply with approval or
   corrections. If I request changes, revise the PLAN and wait again.
3. **Record the approved TASKS as todos.** Once approved, write each task into the
   todos table (with dependencies in todo_deps) before touching code, and keep their
   status current (`in_progress` before starting, `done` when finished) so progress
   and blockers stay visible.
4. **Size tasks by judgment, not a fixed metric.** Each task should be:
   - One cohesive concern (no bundling unrelated changes).
   - Isolated and functional enough to be tested by itself.
   - Small enough that a reviewer can review it in one sitting.
   There's no fixed file/line cap — use engineering judgment, favor smaller.
5. **Work one task at a time.** Implement the current task fully, verify it, then move
   to the next. Don't start a new task while another is unfinished unless I say so.

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
