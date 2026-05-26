#!/usr/bin/env bash
# Rebuild dist/copy-that-sells.skill from skills/copy-that-sells/ source.
#
# The .skill file is a plain zip archive containing the skill folder.
# The folder must be the top-level entry in the zip (with the skill name).
# This script is idempotent: it replaces the existing dist file in place.
#
# Usage: ./scripts/build-skill.sh
# Run from the repo root.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILL_NAME="copy-that-sells"
SRC_DIR="$REPO_ROOT/skills/$SKILL_NAME"
DIST_DIR="$REPO_ROOT/dist"
OUT_FILE="$DIST_DIR/$SKILL_NAME.skill"

if [[ ! -d "$SRC_DIR" ]]; then
  echo "error: source dir not found at $SRC_DIR" >&2
  exit 1
fi

if [[ ! -f "$SRC_DIR/SKILL.md" ]]; then
  echo "error: SKILL.md not found in $SRC_DIR" >&2
  exit 1
fi

mkdir -p "$DIST_DIR"

# Build into a temp path, then move into place atomically.
# mktemp creates an empty file; remove it so zip writes a fresh archive
# instead of trying to update what it thinks is an existing one.
TMP_FILE="$(mktemp -t copy-that-sells-build.XXXXXX)"
rm -f "$TMP_FILE"
TMP_FILE="${TMP_FILE}.zip"
trap 'rm -f "$TMP_FILE"' EXIT

# Zip the skill folder. -X strips extra file attributes for reproducibility.
# Exclude OS junk and editor temp files.
(
  cd "$REPO_ROOT/skills"
  zip -rq -X "$TMP_FILE" "$SKILL_NAME" \
    -x "*.DS_Store" \
    -x "$SKILL_NAME/.git/*" \
    -x "$SKILL_NAME/*.swp" \
    -x "$SKILL_NAME/*.swo"
)

mv "$TMP_FILE" "$OUT_FILE"
trap - EXIT

echo "built $OUT_FILE"
echo
echo "contents:"
unzip -l "$OUT_FILE"
echo
echo "size: $(du -h "$OUT_FILE" | cut -f1)"
