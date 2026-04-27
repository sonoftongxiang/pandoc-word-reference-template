#!/usr/bin/env bash

set -euo pipefail

SOURCE_DIR="${1:-reference}"
OUTPUT_BASENAME="${2:-reference}"
OUTPUT_DIR="${3:-$(pwd)}"

if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "Source directory not found: $SOURCE_DIR" >&2
  exit 1
fi

if [[ ! -f "$SOURCE_DIR/[Content_Types].xml" ]]; then
  echo "Not a valid unpacked docx directory: missing [Content_Types].xml" >&2
  exit 1
fi

SOURCE_DIR_ABS="$(cd "$SOURCE_DIR" && pwd)"
OUTPUT_DIR_ABS="$(cd "$OUTPUT_DIR" && pwd)"
ZIP_PATH="$OUTPUT_DIR_ABS/${OUTPUT_BASENAME}.zip"
DOCX_PATH="$OUTPUT_DIR_ABS/${OUTPUT_BASENAME}.docx"
TMP_ZIP="/tmp/${OUTPUT_BASENAME}-$$.zip"

cleanup() {
  rm -f "$TMP_ZIP"
}

trap cleanup EXIT

rm -f "$ZIP_PATH" "$DOCX_PATH"

(
  cd "$SOURCE_DIR_ABS"
  zip -r "$TMP_ZIP" . -x "*.DS_Store" "*/.DS_Store"
)

cp "$TMP_ZIP" "$ZIP_PATH"
cp "$TMP_ZIP" "$DOCX_PATH"

echo "Created:"
echo "  $ZIP_PATH"
echo "  $DOCX_PATH"
