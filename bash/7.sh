#!/bin/bash

awk -v p="$PATH" '
BEGIN {
    n = split(p, chunk, ":")
    for (i = 1; i <= n; i++) {
        d = chunk[i]
        if (d == "") continue
        if (!seen[d]++) order[++k] = d
    }
    for (i = 1; i <= k; i++) print order[i]
}
' | while IFS= read -r bindir || [ -n "$bindir" ]; do
    [ -z "$bindir" ] && continue
    if [ ! -d "$bindir" ] || [ ! -r "$bindir" ]; then
        continue
    fi
    files=$(find "$bindir" -maxdepth 1 -type f 2>/dev/null | wc -l)
    files=$(echo "$files" | tr -d ' ')
    printf '%s => %s\n' "$bindir" "$files"
done

