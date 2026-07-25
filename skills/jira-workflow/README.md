# jira-workflow

Run a consistent JIRA-ticket workflow with mandatory PLAN/TASKS approval before coding.

## What it does

Guides the agent through:
1. Clarifying ambiguous ticket context
2. Producing Goal / Scope / Tasks and waiting for approval
3. Recording approved tasks in `todos` + `todo_deps`
4. Implementing and verifying one task at a time

## How to invoke

```
/jira-workflow
```

Also triggers on phrases like "jira workflow", "plan this ticket", and "ticket workflow".

## See also

- [`SKILL.md`](./SKILL.md) — full LLM-facing instructions
