# caveman-pr

Generates a pull request **title and description** from the commits on your current branch
compared to a base branch. Caveman voice: terse, exact, no fluff, why over what — the same
style as `caveman-commit`.

## What it does

- Resolves the commit range: `<base>..HEAD` (base = your argument, else the remote default
  branch, else `main`/`master`).
- Reads every non-merge commit and the branch diff.
- Emits a paste-ready title (Conventional Commits, same format as `caveman-commit`) plus a
  description with fixed sections:
  - **Background** — why the change exists
  - **Changes** — what changed, as bullets grouped by area
  - **Testing** — how it was verified
  - **Example of testing** — a real command + output block, when one exists (omitted otherwise)
- Copies the result to the clipboard with `pbcopy` for pasting into BitBucket Stash (no CLI PR creation).

## Use it

Say any of:

- "write a PR description"
- "pull request description"
- "describe this branch for a PR"
- `/caveman-pr`
- `/caveman-pr develop` (name the base branch explicitly)

## Boundaries

Generates text, prints it, and copies it to the clipboard with `pbcopy`. Does not open the
PR, push, or commit — BitBucket Stash has no CLI PR creation, so you paste the clipboard into
the Stash web form. Reads git history and diff; writes nothing to the repo. Never fabricates
test output — if nothing verifies the change, Testing says `- Not tested` and the example
section is dropped.
