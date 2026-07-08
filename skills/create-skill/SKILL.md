---
name: create-skill
description: >
  Create a new skill in the skills repository ($HOME/skills) using writing-great-skills
  guidance, then install it. Use when the user says "create a skill", "new skill",
  "add a skill", or invokes /create-skill.
---

Create a new skill in the skills repository using **writing-great-skills** guidance, then install and register it.

## Steps

1. **Verify skills repo exists.** Check that `$HOME/skills/skills.yaml` exists. If not, stop and tell the user the skills repository isn't found at `$HOME/skills`. _Completion: know the repo exists._

2. **Invoke writing-great-skills.** Use the `skill` tool to invoke `writing-great-skills` with the user's requirements. It will guide the skill creation with best practices (leading words, information hierarchy, completion criteria, etc.). _Completion: skill content generated._

3. **Create the skill directory and files.** In `$HOME/skills/skills/`:
   - Create `<skill-name>/`
   - Write `SKILL.md` with the generated content (must include frontmatter: name + description)
   - Write `README.md` with human-facing documentation
   _Completion: files exist in the repo._

4. **Register in skills.yaml.** Add the skill to `$HOME/skills/skills.yaml`:
   ```yaml
   - name: <skill-name>
     source: ./skills/<skill-name>
   ```
   Append to the existing skills list. _Completion: skill registered._

5. **Install the skill.** Run:
   ```bash
   cd $HOME/skills && npx skills add ./skills/<skill-name> -g -a github-copilot -y </dev/tty
   ```
   _Completion: skill installed globally._

6. **Tell the user to reload.** Instruct: "Skill created and installed. To use it in this session, reload skills or start a new session." _Completion: user knows next step._

## Boundaries

Creates skills in the canonical skills repository at `$HOME/skills`, installs them globally. Does not modify remote skills. The skill content generation rules live in writing-great-skills — this skill only owns the file creation, registration, and installation steps.
