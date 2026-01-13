#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="$SCRIPT_DIR/skills"

CODEX_SKILLS="$HOME/.codex/skills"
CLAUDE_SKILLS="$HOME/.claude/skills"

install_skills() {
    local target="$1"
    mkdir -p "$target"

    for skill in "$SKILLS_DIR"/*/; do
        skill_name=$(basename "$skill")
        rm -rf "${target}/${skill_name}"
        cp -r "$skill" "${target}/${skill_name}"
        echo "  $skill_name -> $target"
    done
}

echo "Installing skills..."
install_skills "$CODEX_SKILLS"
install_skills "$CLAUDE_SKILLS"
echo "Done"
