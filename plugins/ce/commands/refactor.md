---
description: Refactor code following best practices
argument-hint: "<file-path-or-pattern>"
allowed-tools: Bash, Task
---

Refactor code to improve quality, maintainability, and adherence to best practices.

Arguments:

- `$ARGUMENTS`: File path, function name, or pattern to refactor. If not provided, refactors unstaged changes.

First, determine what code to refactor:

**If `$ARGUMENTS` is provided:**

- Use the provided file path, pattern, or target directly

**If `$ARGUMENTS` is empty:**

- Run `git diff` to get unstaged changes
- If there are unstaged changes, use those as the refactoring target
- If there are no unstaged changes, ask the user what they want to refactor

Once you have the target, invoke the refactor-specialist agent using the Task tool with:

- subagent_type: "refactor-specialist"
- A detailed prompt that includes:
  - What code to refactor (file paths, function names, or the diff of unstaged changes)
  - Any specific focus areas mentioned by the user
  - Instructions to follow the refactoring guidelines in the agent's prompt
