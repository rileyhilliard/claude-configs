#!/usr/bin/env bash
# SessionStart hook for loading skill context

set -euo pipefail

# Determine Claude Code config root directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
CONFIG_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

# Path to the using-superpowers skill
SKILL_PATH="${CONFIG_ROOT}/skills/using-superpowers/SKILL.md"

# Read using-superpowers skill content
if [ -f "$SKILL_PATH" ]; then
    skill_content=$(cat "$SKILL_PATH" 2>&1)
else
    skill_content="Error: using-superpowers skill not found at ${SKILL_PATH}"
fi

# Escape content for JSON
skill_escaped=$(echo "$skill_content" | sed 's/\\/\\\\/g' | sed 's/"/\\"/g' | awk '{printf "%s\\n", $0}')

# Output context injection as JSON
cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "<EXTREMELY_IMPORTANT>\nYou have superpowers.\n\n**Below is the full content of your 'using-superpowers' skill - your introduction to using skills. For all other skills, use the 'Skill' tool:**\n\n${skill_escaped}\n</EXTREMELY_IMPORTANT>"
  }
}
EOF

exit 0
