#!/usr/bin/env bash
# apply-settings.sh — idempotently merge config/settings.json into the live
# prime-agent settings file, preserving every key the template does not
# manage. A timestamped backup is written before any modification.
#
# Usage: scripts/apply-settings.sh
# Environment:
#   SETTINGS_TEMPLATE   template path   (default: <repo>/config/settings.json)
#   SETTINGS_TARGET     target path     (default: ${PRIME_AGENT_CODING_AGENT_DIR:-$HOME/.prime/agent}/settings.json)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE="${SETTINGS_TEMPLATE:-$SCRIPT_DIR/../config/settings.json}"
AGENT_DIR="${PRIME_AGENT_CODING_AGENT_DIR:-$HOME/.prime/agent}"
TARGET="${SETTINGS_TARGET:-$AGENT_DIR/settings.json}"

fail() {
  echo "error: $*" >&2
  exit 1
}

command -v jq >/dev/null 2>&1 || fail "jq is required but was not found in PATH"
[ -f "$TEMPLATE" ] || fail "template not found: $TEMPLATE"
jq -e . "$TEMPLATE" >/dev/null 2>&1 || fail "template is not valid JSON: $TEMPLATE"

TARGET_DIR="$(dirname "$TARGET")"
mkdir -p "$TARGET_DIR"

if [ -f "$TARGET" ]; then
  jq -e . "$TARGET" >/dev/null 2>&1 || fail "existing settings are not valid JSON: $TARGET"
  MERGED="$(jq -s '.[0] * .[1]' "$TARGET" "$TEMPLATE")"
else
  MERGED="$(jq -S . "$TEMPLATE")"
fi

# Idempotency: when the target already equals the desired result, do nothing.
if [ -f "$TARGET" ] && [ "$(jq -S . "$TARGET")" = "$(printf '%s' "$MERGED" | jq -S .)" ]; then
  echo "settings already up to date: $TARGET"
  exit 0
fi

# Timestamped backup before any write; uniquify same-second collisions.
if [ -f "$TARGET" ]; then
  STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
  BACKUP="$TARGET.bak-$STAMP"
  n=1
  while [ -e "$BACKUP" ]; do
    BACKUP="$TARGET.bak-$STAMP.$n"
    n=$((n + 1))
  done
  cp -p "$TARGET" "$BACKUP"
  echo "backup written: $BACKUP"
fi

# Atomic write; settings stay owner-only (0600).
umask 077
TMP_FILE="$(mktemp "$TARGET_DIR/.settings.tmp.XXXXXX")"
printf '%s\n' "$MERGED" > "$TMP_FILE"
mv "$TMP_FILE" "$TARGET"
echo "settings applied: $TARGET"
