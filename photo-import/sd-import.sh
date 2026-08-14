#!/bin/bash
INBOX="$HOME/Pictures/SD-Imports"
YEAR=$(date +%Y)
DROPBOX_OUT="$HOME/Dropbox/$YEAR Photos"
LOG="$HOME/Library/Logs/sd-import.log"

for vol in /Volumes/*/; do
  vol_name=$(basename "$vol")

  if [ "$vol_name" = "Macintosh HD" ]; then
    continue
  fi

  [ -d "${vol}DCIM" ] || continue
  echo "$(date): found card at $vol" >> "$LOG"

  DATE_SUB=$(date +%Y-%m-%d)
  mkdir -p "$DROPBOX_OUT/$DATE_SUB"

  # RAWs -> flat into local staging inbox, so LR Auto Import (non-recursive) sees them
  find "${vol}DCIM" -type f \( -iname "*.RAF" -o -iname "*.CR3" \) -exec cp -n {} "$INBOX/" \; >> "$LOG" 2>&1

  # JPEGs -> flat into dated Dropbox folder
  find "${vol}DCIM" -type f \( -iname "*.JPG" -o -iname "*.JPEG" -o -iname "*.MP4" \) -exec cp -n {} "$DROPBOX_OUT/$DATE_SUB/" \; >> "$LOG" 2>&1

  echo "$(date): import complete for $vol" >> "$LOG"
done
