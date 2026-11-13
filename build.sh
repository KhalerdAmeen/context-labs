#!/bin/bash
# Source of truth: plugin/skills/context-labs-<name>/
# The same folders serve the Claude Code plugin, `npx skills add` and manual installs.
# This script only builds the Claude app zips into dist/ (Settings → Features → Skills → upload).
set -e
cd "$(dirname "$0")"
TMP="$(mktemp -d)"
mkdir -p dist
for s in context-labs-setup context-labs-handoff context-labs-review; do
  cp -R "plugin/skills/$s" "$TMP/$s"
  find "$TMP/$s" -name .DS_Store -exec rm -f {} +
  (cd "$TMP" && zip -qr "$s.zip" "$s")
  cp -f "$TMP/$s.zip" dist/
done
rm -rf "$TMP"
ls -1 dist
