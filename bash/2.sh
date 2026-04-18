#!/bin/bash

input_path="$1"
output_path="$HOME/tasks/bash/2shTest"

if [ ! -d "$input_path" ]; then
  echo "Path not found"
  exit 1
fi

mkdir -p "$output_path"

for dir in "$input_path"/*/; do
  [ -d "$dir" ] || continue
  name=$(basename "$dir")
  count=$(ls -A "$dir" 2>/dev/null | wc -l)
  echo "$count" > "$output_path/$name"
done
