#!/bin/bash

# Paths for sync
TARGET_PATHS=(
  ~/.config/crush
  ~/.config/mise
  ~/.zshrc
)

CURRENT_DIR="$PWD"

# Start script
echo "Start sync dotfiles..."
echo -e "Paths count: ${#TARGET_PATHS[@]}\n"

for path in "${TARGET_PATHS[@]}"; do
  if [[ ! -e "$path" ]]; then
    echo $'\033[31m'"Error path not found: $path"$'\033[0m'
    continue
  fi

  NAME=$(basename "$path")

  if [[ -f "$path" ]]; then
    rsync -av --delete --exclude-from=.gitignore "$path" "./$NAME"
  else
    mkdir -p "./$NAME"
    rsync -av --delete --exclude-from=.gitignore "$path/" "./$NAME/"
  fi

  echo $'\033[32m'"Done $path"$'\033[0m'
done

echo -e "\nAll dotfiles synchronized!"
