#!/bin/bash

> logs.log

for file in /var/log/*.log; do
  [ -f "$file" ] || continue
  tail -n 1 "$file" 2>/dev/null >> logs.log
done
