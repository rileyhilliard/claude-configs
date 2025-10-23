---
description: Run tests and analyze failures
argument-hint: "[test-command]"
model: sonnet
allowed-tools: Bash, BashOutput, Read, Grep
---

Run the project's test suite and analyze any failures.

Arguments:
- `$ARGUMENTS`: Optional custom test command (e.g., "npm test", "pytest", "cargo test")

Process:
1. Detect the test command automatically if not provided:
   - Check for package.json (npm test)
   - Check for pytest.ini or setup.py (pytest)
   - Check for Cargo.toml (cargo test)
   - Check for Makefile with test target
2. Run the tests
3. If failures occur:
   - Analyze the failure messages
   - Identify the root causes
   - Suggest fixes with file:line references
4. Report summary of test results

Provide clear, actionable feedback on test failures.
