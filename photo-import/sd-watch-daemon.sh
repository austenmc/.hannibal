#!/bin/bash
IMPORT_SCRIPT="/Users/austenmc/.hannibal/photo-import/sd-import.sh"
LOG="$HOME/Library/Logs/sd-watch-daemon.log"

echo "$(date): daemon started" >> "$LOG"

diskutil activity | while read -r line; do
  if echo "$line" | grep -q "DiskAppeared"; then
    echo "$(date): disk appeared event: $line" >> "$LOG"

    # poll /Volumes for up to 10s, since DiskAppeared fires before the mount completes
    found=0
    for i in $(seq 1 20); do
      if ls /Volumes/*/DCIM >/dev/null 2>&1; then
        found=1
        break
      fi
      sleep 0.5
    done

    if [ "$found" -eq 1 ]; then
      echo "$(date): DCIM folder found, running import" >> "$LOG"
      "$IMPORT_SCRIPT"
    else
      echo "$(date): timed out waiting for DCIM mount" >> "$LOG"
    fi
  fi
done
