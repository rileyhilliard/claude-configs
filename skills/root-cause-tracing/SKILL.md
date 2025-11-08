---
name: root-cause-tracing
description: Use when errors occur deep in execution and you need to trace back to find the original trigger - systematically traces bugs backward through call stack, adding instrumentation when needed, to identify source of invalid data or incorrect behavior
---

# Root Cause Tracing

## Core Principle

**Don't fix symptoms. Trace backward through the call chain to find the original trigger, then fix at the source.**

Bugs often manifest deep in the call stack (git init in wrong directory, file created in wrong location, database opened with wrong path). Your instinct is to fix where the error appears—that's treating a symptom, not the disease.

## When to Use

- Error happens deep in execution (not at entry point)
- Stack trace shows long call chain
- Unclear where invalid data originated
- Need to find which test/code path triggers the problem
- Same symptom appears in multiple places

## RCA Methodology

### Systematic Approach

**1. Collect Data First**

- Gather logs, error messages, stack traces
- Document what happened vs. what was expected
- Note when/where it occurs (specific tests, code paths)
- Check for patterns across multiple failures

**2. Use Five Whys + Backward Tracing**

Combine asking "Why?" with tracing the call stack backward:

```
@example
Symptom: git init creates .git in source code directory
Why? → cwd parameter is empty string, defaults to process.cwd()
Why? → projectDir variable passed to git init is ''
Why? → Session.create() received empty tempDir
Why? → Test accessed context.tempDir before beforeEach initialized it
Why? → setupCoreTest() returns object with tempDir: '' initially
Root Cause: Top-level variable initialization accessing uninitialized value
```

**3. Trace the Call Chain**

Work backward through the stack:

```typescript
// @example
execFileAsync('git', ['init'], { cwd: projectDir })  // Symptom
  ← WorktreeManager.createSessionWorktree(projectDir, sessionId)
  ← Session.initializeWorkspace()
  ← Session.create(tempDir)
  ← Test: Project.create('name', context.tempDir)  // Root trigger
```

**4. Verify the Root Cause**

Test your hypothesis:

- If you fix at the source, does the symptom disappear?
- Does the fix prevent recurrence across all code paths?
- Can you add validation to catch it early?

## Instrumentation Techniques

### Adding Stack Traces

When the call chain isn't clear, add instrumentation **before** the problematic operation:

```typescript
async function gitInit(directory: string) {
  const stack = new Error().stack;
  console.error("DEBUG:", { directory, cwd: process.cwd(), stack });
  await execFileAsync("git", ["init"], { cwd: directory });
}
```

**Key points:**

- Use `console.error()` in tests (logger may be suppressed)
- Log before the operation, not after it fails
- Include context: directory, cwd, environment variables
- Capture with: `yarn test 2>&1 | grep 'DEBUG'`

### Finding Test Polluters

If you don't know which test creates unwanted state, use bisection:

```bash
./find-polluter.sh '.git' 'src/**/*.test.ts'
```

The @find-polluter.sh script runs tests one-by-one and stops at the first polluter.

## Fixing at the Source

### Defense-in-Depth Strategy

Don't just fix the root cause—add validation at each layer to make the bug impossible:

**Example:**

1. **Root fix:** Prevent uninitialized value access at the source
2. **Layer 1:** Entry point validates inputs
3. **Layer 2:** Core logic validates preconditions
4. **Layer 3:** Environment guards (NODE_ENV checks, directory restrictions)
5. **Layer 4:** Instrumentation for debugging

Result: Bug impossible to reintroduce, even with future code changes.

**Remember:** Fixing symptoms creates technical debt. Finding root causes eliminates entire classes of bugs.
