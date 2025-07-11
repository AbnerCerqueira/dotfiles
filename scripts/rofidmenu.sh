#!/bin/bash

SCRIPT_DIR="$HOME/dotfiles/scripts"

mapfile -t paths < <(find "$SCRIPT_DIR" -type f -executable)

names=()
for path in "${paths[@]}"; do
  names+=("$(basename "$path")")
done

selected_name=$(printf "%s\n" "${names[@]}" | rofi -dmenu -p "scripts")

[[ -z "$selected_name" ]] && exit

for path in "${paths[@]}"; do
  if [[ "$(basename "$path")" == "$selected_name" ]]; then
    bash "$path" &
    break
  fi
done
