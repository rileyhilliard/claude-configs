---
description: Start systematic debugging session for a bug
argument-hint: "<bug-description>"
model: sonnet
allowed-tools: Task
---

Launch the bug-hunter agent to systematically debug and fix a bug.

Arguments:
- `$ARGUMENTS`: Description of the bug or error message

The bug-hunter agent will:
1. Understand the bug and gather reproduction steps
2. Systematically investigate the codebase
3. Form and test hypotheses
4. Implement a fix for the root cause
5. Verify the fix thoroughly

Use the Task tool to invoke the bug-hunter agent with the user's bug description.
