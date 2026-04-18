#!/bin/bash

file=$1
time=$2

for ((i=0; i<$time; i++))
do
    echo "$(date '+%d.%m.%y %H:%M') = $(cat /proc/loadavg)" >> "$file"
    sleep 1
done

