#!/bin/bash

# Read each skill from YAML and install globally
while IFS= read -r json; do
  source=$(echo "$json" | jq -r '.source')
  name=$(echo "$json" | jq -r '.name')

  echo "Installing skill: $name"
  
  if [[ "$source" == http* ]]; then
    npx skills add "$source" --skill "$name" -g </dev/tty
  else
    npx skills add "$source" -g </dev/tty
  fi
done < <(yq -r '.skills[] | @json' skills.yaml)

echo "Done installing skills!"
