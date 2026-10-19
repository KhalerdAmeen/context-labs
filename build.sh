#!/bin/bash
# Builds one .zip per skill for the Claude app (Settings → Features → Skills → upload).
# Inside each zip the skill is named context-labs-<skill> so it doesn't clash with other skills.
set -e
cd "$(dirname "$0")"
ROOT="$(pwd)"; TMP="$(mktemp -d)"
mkdir -p dist
for s in setup handoff review; do
  d="$TMP/context-labs-$s"; mkdir -p "$d"
  cp -R "plugin/skills/$s/." "$d/"
  find "$d" -name .DS_Store -exec rm -f {} +
  sed "2s/^name: $s\$/name: context-labs-$s/" "plugin/skills/$s/SKILL.md" > "$d/SKILL.md"
  (cd "$TMP" && zip -qr "context-labs-$s.zip" "context-labs-$s")
  cp -f "$TMP/context-labs-$s.zip" "dist/"
done
rm -rf "$TMP"
ls -1 dist
