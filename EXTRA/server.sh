#!/bin/bash

DIR="./received_files"

if [[ ! -d "$DIR" ]]; then
        mkdir -p "$DIR"
fi

while true; do
	FILENAME="$DIR/$(date +"%M%S")"
        nc -l 6767 > "$FILENAME"
	echo "File saved to: $FILENAME"
done
