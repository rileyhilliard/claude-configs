---
description: Claude Essentials - Development workflow commands
argument-hint: "<subcommand> [args]"
allowed-tools: Bash, BashOutput, Read, Grep, Glob, Edit, Write, TodoWrite, WebFetch, mcp__ide__getDiagnostics
---

Claude Essentials unified command interface. Run development workflows with consistent, focused execution.

## Available Subcommands

- `test [command]` - Run tests and analyze failures
- `explain <target>` - Explain code in detail with examples
- `quick-fix` - Fix IDE diagnostics and linting errors
- `debug` - Launch systematic debugging workflow
- `optimize <target>` - Find and fix performance bottlenecks
- `refactor <target>` - Improve code quality and structure
- `review` - Get comprehensive code review before merge
- `commit` - Generate semantic commit message

## Usage

Parse `$ARGUMENTS` to extract the subcommand and any additional arguments.

**Format**: `<subcommand> [additional-args]`

**Examples**:
- `/ce test pytest tests/unit`
- `/ce explain src/auth/controller.ts`
- `/ce quick-fix`
- `/ce commit`

## Subcommand Execution

### test [test-command]

Run the project's test suite and analyze any failures.

**Arguments**: Optional custom test command (e.g., "yarn test", "pytest", "cargo test")

**Process**:
1. Detect test command automatically if not provided (package.json, pytest.ini, Cargo.toml, Makefile)
2. Run the tests
3. If failures occur: analyze messages, identify root causes, suggest fixes with file:line references
4. Report summary of test results

**Output**: Clear, actionable feedback on test failures

---

### explain <file-path-or-concept>

Provide detailed explanation of code or concepts in the codebase.

**Arguments**: File path, function name, or concept to explain (required)

**Process**:
1. If file path: read and explain the file
2. If function/class name: search for it and explain implementation
3. If concept: find examples in codebase and explain the pattern

**Output should include**:
- **Purpose**: What does this code do and why?
- **Key Components**: Main functions, classes, or modules involved
- **Data Flow**: How data moves through the code
- **Dependencies**: What does this rely on?
- **Usage Examples**: How is this typically used?
- **Gotchas**: Any tricky parts or edge cases to be aware of

Tailor depth of explanation to complexity of the code.

---

### quick-fix

Fix IDE diagnostics and linting errors automatically.

**Arguments**: None

**Process**:
1. Use `mcp__ide__getDiagnostics` to get all current diagnostics
2. Categorize issues by severity (error, warning, info)
3. Fix errors first, then warnings
4. For each issue:
   - Read the file
   - Apply the fix
   - Verify with diagnostics again
5. Report what was fixed

**Output**: Summary of fixes applied and remaining issues

---

### debug

Launch systematic debugging workflow for current problem.

**Arguments**: None (will ask for problem description if not clear from context)

**Process**:
1. Understand the problem: what's broken, how to reproduce, expected vs actual behavior
2. Gather context: read relevant files, check recent changes, review error messages
3. Form hypothesis about root cause
4. Test hypothesis with targeted investigation
5. Verify fix resolves the issue
6. Report findings and solution

**Output**: Root cause analysis and fix with verification

---

### optimize <target>

Find and fix performance bottlenecks.

**Arguments**: File path or directory to optimize (required)

**Process**:
1. Profile the target (if profiling tools available)
2. Identify bottlenecks: algorithmic complexity, unnecessary computations, memory issues
3. Suggest optimizations with before/after comparisons
4. Apply fixes if approved
5. Verify improvements

**Focus areas**:
- Algorithmic complexity (O(n²) → O(n log n))
- Unnecessary re-renders (React components)
- Memory leaks and excessive allocations
- Database query optimization
- Bundle size reduction

**Output**: Performance analysis with measurable improvements

---

### refactor <target>

Improve code quality and structure while preserving behavior.

**Arguments**: File path or directory to refactor (required)

**Process**:
1. Read the target code
2. Identify code smells: duplication, long functions, unclear naming, tight coupling
3. Propose refactoring with clear benefits
4. Apply changes systematically
5. Verify behavior is preserved (run tests if available)

**Focus areas**:
- Extract reusable functions/components
- Improve naming clarity
- Reduce complexity (cyclomatic, nesting depth)
- Eliminate duplication
- Separate concerns

**Output**: Cleaner code with same behavior, verified by tests

---

### review

Get comprehensive code review before merging.

**Arguments**: None (reviews current branch against base branch)

**Process**:
1. Check git status and identify base branch (main, master, develop)
2. Get complete diff: `git diff <base>...HEAD`
3. Review all changes for:
   - Correctness (logic errors, bugs, edge cases)
   - Security (vulnerabilities, input validation)
   - Performance (algorithmic complexity, memory leaks)
   - Maintainability (clarity, naming, structure)
   - Testing (coverage for new functionality)
   - Type safety (proper typing if applicable)
4. Check for IDE diagnostics
5. Verify test coverage

**Output format**:
```markdown
# Code Review

## Summary
- Files changed, change type, scope

## Critical Issues ⛔
[Must fix before merge]

## Important Issues ⚠️
[Should address]

## Suggestions 💡
[Optional improvements]

## Testing Status
- [ ] New functionality has tests
- [ ] Edge cases covered

## Merge Readiness
**[APPROVE ✅ | REQUEST CHANGES 🔄]**
```

---

### commit

Generate semantic commit message for staged changes.

**Arguments**: None (uses staged git changes)

**Process**:
1. Run `git status` to see staged changes
2. Run `git diff --staged` to see the actual changes
3. Analyze the changes to understand:
   - Type of change (feat, fix, refactor, docs, test, chore)
   - Scope of change (component/module affected)
   - Impact and purpose
4. Generate commit message following conventional commits format:
   ```
   <type>(<scope>): <description>

   <body explaining why, not what>
   ```
5. Present the commit message for approval

**Commit types**:
- `feat`: New feature
- `fix`: Bug fix
- `refactor`: Code restructuring without behavior change
- `docs`: Documentation changes
- `test`: Test additions or modifications
- `chore`: Build process, tooling, dependencies

**Output**: Semantic commit message ready to use

---

## Error Handling

If subcommand is not recognized, list available subcommands and examples.

If required arguments are missing, explain what's needed with an example.

If a subcommand fails, provide clear error message with troubleshooting steps.

## Execution Notes

- Parse `$ARGUMENTS` to extract subcommand and remaining args
- Execute the appropriate workflow based on the subcommand
- Maintain focused execution - don't stray from the specified subcommand's scope
- Always provide actionable output with file:line references where relevant
- Use TodoWrite to track multi-step workflows
