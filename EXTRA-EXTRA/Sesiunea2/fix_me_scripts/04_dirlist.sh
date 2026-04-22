#!/bin/bash

echo "List directories in /var"

for dir in /var/*; do
    if [ -d "$dir" ]; then
        echo "$dir: size=$(du -sh $dir 2>/dev/null | cut -f1)"
    fi
done
