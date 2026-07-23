#!/bin/bash

# Read each skill from YAML and install globally
while IFS= read -r json; do
  source=$(echo "$json" | jq -r '.source')
  name=$(echo "$json" | jq -r '.name')

  echo "Installing skill: $name"

  if [[ "$source" == http* ]]; then
    npx skills add "$source" --skill "$name" -g -a github-copilot -y </dev/tty
  else
    npx skills add "$source" -g -a github-copilot -y </dev/tty
  fi
done < <(yq -r '.skills[] | @json' skills.yaml)

echo "Done installing skills!"

# Symlink global instructions so they apply across all repos/sessions
mkdir -p "$HOME/.copilot"
ln -sf "$HOME/skills/instructions/copilot-instructions.md" "$HOME/.copilot/copilot-instructions.md"
echo "Linked global instructions: ~/.copilot/copilot-instructions.md -> ~/skills/instructions/copilot-instructions.md"
