---
description: Find and fix performance issues in code
argument-hint: "[file-path-or-area]"
model: sonnet
allowed-tools: Task, Bash
---

Use the Task tool to invoke the performance-optimizer agent to analyze code for performance issues and suggest optimizations.

Arguments:
- `$ARGUMENTS`: Optional file path or area to focus on (defaults to unstaged changes)

If `$ARGUMENTS` is empty:
1. Run `git diff` to get unstaged changes
2. Pass the unstaged changes as the focus area to the agent

If `$ARGUMENTS` is provided:
- Pass it directly as the focus area

Pass the following prompt to the performance-optimizer agent:

"Analyze code for performance issues and suggest optimizations.

Focus area: [unstaged changes from git diff OR $ARGUMENTS]

Provide:
- Specific file:line references for each issue
- Explanation of the performance impact
- Code examples showing the optimization
- Estimated improvement (if measurable)
- Cost-benefit analysis for each proposed optimization

Prioritize high-impact optimizations over micro-optimizations."
