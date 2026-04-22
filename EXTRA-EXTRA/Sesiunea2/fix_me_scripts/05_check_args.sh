#!/bin/bash

MAX_ARGS=9

if [[ $# -eq 0 ]]; then
  echo "no arguments provided"
  exit 1
fi

if [[ $# -gt $MAX_ARGS ]]; then
  echo "too many arguments (max $MAX_ARGS)"
  exit 1
fi

echo "processing $# argument(s):"
for arg in "$@"; do
  echo "- $arg"
done
