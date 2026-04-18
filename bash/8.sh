#!/bin/sh
uniq_vals=$(env | grep '^LC_' | cut -d= -f2- | sort -u | wc -l)
uniq_vals=$(echo "$uniq_vals" | tr -d ' ')

if [ "$uniq_vals" -gt 1 ]; then
    echo "Error: not all LC_* environment variables have the same value" >&2
    exit 1
fi

exit 0

