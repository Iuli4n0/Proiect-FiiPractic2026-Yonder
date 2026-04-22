#!/bin/bash

DIR=$1
EXTENSIONS="sh txt conf log"

echo "Counting files in: $DIR"

for EXT in $EXTENSIONS; do
  COUNT=$(find $DIR -name "*.$EXT" 2>/dev/null | wc -l)
  echo "There are $COUNT .$EXT files"
done
