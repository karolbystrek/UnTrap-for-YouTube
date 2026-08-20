#!/bin/sh
set -eu

MAGIC="$HOME/Library/Containers/com.apple.Safari/Data/Library/Safari/MagicExtensions"
REPO_URL="https://github.com/karolbystrek/UnTrap-for-YouTube.git"
DIR_NAME="UnTrap-for-YouTube"
NAME="UnTrap for YouTube"
DESC="Removes YouTube Shorts and other distractions from YouTube."
SYMBOL="eye.slash"
COLOR="red"
PROMPT="Removes YouTube Shorts and other distractions from YouTube."

osascript -e 'tell application "Safari" to quit' >/dev/null 2>&1 || true
i=0
while pgrep -x Safari >/dev/null 2>&1 && [ "$i" -lt 30 ]; do
  sleep 0.2
  i=$((i + 1))
done

mkdir -p "$MAGIC"
if [ ! -d "$MAGIC/$DIR_NAME/.git" ]; then
  git -C "$MAGIC" clone "$REPO_URL"
fi

DB="$MAGIC/Extensions.db"
if [ ! -f "$DB" ]; then
  echo "Safari Magic Extensions database not found. Open Safari once, then re-run." >&2
  exit 1
fi

exists=$(sqlite3 "$DB" "SELECT COUNT(*) FROM magic_extensions WHERE directory_name = '$DIR_NAME';")
if [ "$exists" = "0" ]; then
  uuid=$(uuidgen)
  now=$(python3 -c 'from datetime import datetime, timezone; print((datetime.now(timezone.utc)-datetime(2001,1,1,tzinfo=timezone.utc)).total_seconds())')
  sqlite3 "$DB" "INSERT INTO magic_extensions (
    id, version, creation_date, modified_date, name, description,
    selected_symbol, prompt, directory_name, symbol_color_name,
    sync_state, sync_generation
  ) VALUES (
    '$uuid', 1, $now, $now, '$NAME', '$DESC',
    '$SYMBOL', '$PROMPT', '$DIR_NAME', '$COLOR',
    0, 0
  );"
fi

registered=$(sqlite3 "$DB" "SELECT directory_name FROM magic_extensions WHERE directory_name = '$DIR_NAME';")
if [ "$registered" != "$DIR_NAME" ]; then
  echo "Failed to register $DIR_NAME in Safari's Magic Extensions database." >&2
  exit 1
fi

echo "Installed. Open Safari → Settings → Extensions → enable UnTrap for YouTube."
