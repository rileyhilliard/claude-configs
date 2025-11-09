---
description: Find and fix performance issues in code
argument-hint: "[file-path-or-area]"
allowed-tools: Skill, Bash
---

Use the Skill tool to invoke the optimizing-performance skill to analyze code for performance issues and suggest optimizations.

Arguments:

- `$ARGUMENTS`: Optional file path or area to focus on (defaults to unstaged changes)

If `$ARGUMENTS` is empty:

1. Run `git diff` to get unstaged changes
2. Focus on optimizing the unstaged changes

If `$ARGUMENTS` is provided:

- Use it as the focus area for optimization

When invoking the optimizing-performance skill:

"Analyze code for performance issues and suggest optimizations.

Focus area: [unstaged changes from git diff OR $ARGUMENTS]

Provide:

- Specific file:line references for each issue
- Explanation of the performance impact
- Code examples showing the optimization
- Estimated improvement (if measurable)
- Cost-benefit analysis for each proposed optimization

Prioritize high-impact optimizations over micro-optimizations."
