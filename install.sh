#!/usr/bin/env bash
# Installs the /rocket-fuel skill into ~/.claude for all projects.
set -euo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
home="${CLAUDE_HOME:-$HOME/.claude}"
dest="$home/skills/rocket-fuel"

if ! command -v codex >/dev/null 2>&1; then
  echo "Warning: 'codex' isn't on your PATH yet. Install it first:"
  echo "  npm i -g @openai/codex@latest && codex login"
fi

if [ -d "$dest" ] && ! diff -rq "$here/skills/rocket-fuel" "$dest" >/dev/null 2>&1; then
  # Back up OUTSIDE skills/, or Claude Code would load the backup as a second skill.
  mkdir -p "$home/skill-backups"
  backup="$home/skill-backups/rocket-fuel.bak-$(date +%Y%m%d-%H%M%S)"
  mv "$dest" "$backup"
  echo "You already had a different rocket-fuel skill. Moved it to $backup"
fi

mkdir -p "$dest"
cp "$here"/skills/rocket-fuel/*.md "$dest/"
echo "Installed /rocket-fuel -> $dest"
echo "Done. Restart Claude Code, then type /rocket-fuel."
