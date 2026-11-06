#!/bin/bash
# Source of truth: plugin/skills/<name>/ (the Claude Code plugin).
# This script generates, from it:
#   skills/context-labs-<name>/   for `npx skills add` and any agent that reads SKILL.md folders
#   dist/context-labs-<name>.zip  for the Claude app (Settings → Features → Skills → upload)
# Run it after every change to plugin/skills, then commit skills/.
set -e
cd "$(dirname "$0")"
TMP="$(mktemp -d)"
mkdir -p dist skills
for s in setup handoff review; do
  d="skills/context-labs-$s"
  rm -rf "$d"; mkdir -p "$d"
  cp -R "plugin/skills/$s/." "$d/"
  find "$d" -name .DS_Store -exec rm -f {} +
  sed "2s/^name: $s\$/name: context-labs-$s/" "plugin/skills/$s/SKILL.md" > "$d/SKILL.md"
  (cd skills && rm -f "$TMP/context-labs-$s.zip" && zip -qr "$TMP/context-labs-$s.zip" "context-labs-$s")
  cp -f "$TMP/context-labs-$s.zip" "dist/"
done
rm -rf "$TMP"
ls -1 skills dist
