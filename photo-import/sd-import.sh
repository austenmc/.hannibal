#!/bin/bash
INBOX="$HOME/Pictures/SD-Imports"
YEAR=$(date +%Y)
DROPBOX_OUT="$HOME/Dropbox/$YEAR Photos"
LOG="$HOME/Library/Logs/sd-import.log"

notify() {
  osascript -e "display notification \"$2\" with title \"$1\""
}

raw_count=0
jpg_count=0

for vol in /Volumes/*/; do
  vol_name=$(basename "$vol")

  if [ "$vol_name" = "Macintosh HD" ]; then
    continue
  fi

  [ -d "${vol}DCIM" ] || continue
  echo "$(date): found card at $vol" >> "$LOG"

  DATE_SUB=$(date +%Y-%m-%d)
  mkdir -p "$INBOX/$DATE_SUB"
  mkdir -p "$DROPBOX_OUT/$DATE_SUB"

  # count files before copying, so we can diff after
  before_raw=$(find "$INBOX/$DATE_SUB" -type f \( -iname "*.RAF" -o -iname "*.CR3" \) | wc -l)
  before_jpg=$(find "$DROPBOX_OUT/$DATE_SUB" -type f \( -iname "*.JPG" -o -iname "*.JPEG" -o -iname "*.MP4" \) | wc -l)

  find "${vol}DCIM" -type f \( -iname "*.RAF" -o -iname "*.CR3" \) -exec cp -np {} "$INBOX/$DATE_SUB/" \; >> "$LOG" 2>&1
  find "${vol}DCIM" -type f \( -iname "*.JPG" -o -iname "*.JPEG" -o -iname "*.MP4" \) -exec cp -np {} "$DROPBOX_OUT/$DATE_SUB/" \; >> "$LOG" 2>&1

  after_raw=$(find "$INBOX/$DATE_SUB" -type f \( -iname "*.RAF" -o -iname "*.CR3" \) | wc -l)
  after_jpg=$(find "$DROPBOX_OUT/$DATE_SUB" -type f \( -iname "*.JPG" -o -iname "*.JPEG" -o -iname "*.MP4" \) | wc -l)

  raw_count=$((raw_count + after_raw - before_raw))
  jpg_count=$((jpg_count + after_jpg - before_jpg))

  echo "$(date): import complete for $vol" >> "$LOG"
done

if [ "$raw_count" -gt 0 ] || [ "$jpg_count" -gt 0 ]; then
  notify "SD Import Complete" "${raw_count} new RAWs, ${jpg_count} new JPEGs/videos"
else
  notify "SD Import" "Card scanned, nothing new found"
fi
