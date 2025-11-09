---
description: Quick fix for IDE diagnostics and linting errors
allowed-tools: mcp__ide__getDiagnostics, Read, Edit, Bash
---

Automatically fix IDE diagnostics, linting errors, and type errors in the project.

Process:

1. Use `mcp__ide__getDiagnostics` to get all current errors and warnings
2. Categorize issues by severity and type
3. Fix automatically fixable issues:
   - Import organization
   - Missing semicolons
   - Unused variables
   - Simple type errors
   - Formatting issues
4. For complex issues, explain the problem and suggest solutions
5. Run linter/formatter if available (eslint --fix, prettier, black, etc.)

Report:

- Number of issues found and fixed
- Remaining issues that need manual attention
- Suggestions for preventing similar issues

This command is useful for cleaning up the codebase quickly before commits.
