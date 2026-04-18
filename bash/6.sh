#!/bin/sh

if [ "$FOO" = "5" ] && [ "$BAR" = "1" ]; then
    echo "Error: execution is forbidden when FOO=5 and BAR=1" >&2
    exit 1
fi

target=${1:-fix.txt}

until [ -e "$target" ]; do
    sleep 1
done

printf 'File %s appeared\n' "$target"

