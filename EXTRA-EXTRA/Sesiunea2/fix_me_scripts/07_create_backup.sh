#!/bin/bash

if [[ ! -f "$1" ]]; then
    echo "$1 not a file, exiting..."
    exit 1
fi


SOURCE=$1
DEST=/tmp/backups

if [[ ! -d "$DEST" ]]; then
    mkdir $DEST
fi

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME=$(basename $SOURCE)_$TIMESTAMP.bak

echo "Backing up: $SOURCE"
cp $SOURCE $DEST/$BACKUP_NAME

echo "Saved to: $DEST/$BACKUP_NAME \n"
