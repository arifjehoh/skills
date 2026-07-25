---
name: jira-workflow
description: >
  Drive JIRA ticket execution from clarification to implementation with mandatory
  PLAN/TASKS approval and todo tracking. Use when the user says "jira workflow",
  "plan this ticket", "ticket workflow", or invokes /jira-workflow.
---

Turn a JIRA ticket into shippable work with strict plan approval gates.

## Steps

1. **Clarify context first.** Read the ticket, infer likely intent, and ask targeted questions for ambiguous scope, acceptance criteria, and edge cases before planning. Verify anything you can from the repo before asking. _Completion: open ambiguities are identified or resolved._

2. **Produce PLAN and wait.** Before any code changes, output:
   - **Goal** (1–2 sentences)
   - **Scope** (in/out)
   - **Tasks** (ordered, concrete deliverables)
   Then stop and wait for explicit approval or corrections. If corrected, revise and wait again. _Completion: approved PLAN and TASKS._

3. **Record approved TASKS as todos.** Insert each task into `todos`, set dependencies in `todo_deps`, and maintain status (`in_progress` before work, `done` when complete). _Completion: todo state matches real progress._

4. **Implement one task at a time.** Fully implement and verify the current task before starting the next one unless the user explicitly reprioritizes. _Completion: current task is complete and verified before moving on._

## Definition of Done

- PLAN/TASKS were approved before any code changes.
- Every approved task was tracked in `todos`/`todo_deps` with final status `done`.
- The smallest targeted verification for each completed task was run and passed.
- No unrelated files or changes were included.

## Boundaries

Owns workflow orchestration (clarify → plan approval → todo tracking → execution order). Does not replace repository-specific coding, testing, or release instructions.
