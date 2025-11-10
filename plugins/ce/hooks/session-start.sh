#!/usr/bin/env bash
# SessionStart hook for loading user instructions
# Skills are loaded on-demand via the Skill tool (progressive disclosure pattern)

set -euo pipefail

# Claude Code config root directory
CONFIG_ROOT="~/.claude"

# Path to user instructions
CLAUDE_MD_PATH="${CONFIG_ROOT}/CLAUDE.md"

# Read CLAUDE.md user instructions if available and has content
# Only inject context if file exists and is not empty
if [ -f "$CLAUDE_MD_PATH" ] && [ -s "$CLAUDE_MD_PATH" ]; then
    claude_md_content=$(cat "$CLAUDE_MD_PATH" 2>&1)
    claude_md_escaped=$(echo "$claude_md_content" | sed 's/\\/\\\\/g' | sed 's/"/\\"/g' | awk '{printf "%s\\n", $0}')
    additional_context="<CRITICAL_USER_INSTRUCTIONS>\n${claude_md_escaped}\n</CRITICAL_USER_INSTRUCTIONS>"

    # Output context injection as JSON
    cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "${additional_context}"
  }
}
EOF
else
    # No config present, output minimal hook result
    cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart"
  }
}
EOF
fi

exit 0
