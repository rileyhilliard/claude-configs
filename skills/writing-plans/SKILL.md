---
name: writing-plans
description: Use when design is complete and you need detailed implementation tasks for engineers with zero codebase context - creates comprehensive implementation plans with exact file paths, complete code examples, and verification steps assuming engineer has minimal domain knowledge
---

# Writing Plans

Write comprehensive implementation plans assuming the engineer has zero context about the codebase. Each task should be bite-sized (2-5 minutes) following TDD: write test, verify failure, implement, verify pass, commit.

**Save plans to:** `./YYYY-MM-DD-<feature-name>-PLAN.md`

## Plan Document Structure

````markdown
# [Feature Name] Implementation Plan

> **For Claude:** Use @executing-plans or @subagent-driven-development to implement this plan.

**Goal:** [One sentence describing what this builds]

**Architecture:** [2-3 sentences about approach]

**Tech Stack:** [Key technologies/libraries]

---

### Task N: [Component Name]

**Files:**

- Create: `src/exact/path/to/file.ts`
- Modify: `src/exact/path/existing.ts:45-67`
- Test: `tests/exact/path/file.test.ts`

**Step 1: Write the failing test**

```typescript
describe("FeatureName", () => {
  it("should handle specific behavior", () => {
    const result = functionName(input);
    expect(result).toBe(expected);
  });
});
```

Run: `yarn test -- file.test.ts`
Expected: FAIL - "functionName is not defined"

**Step 2: Write minimal implementation**

```typescript
export function functionName(input: InputType): ReturnType {
  return expected;
}
```

**Step 3: Verify test passes**

Run: `npm test -- file.test.ts`
Expected: PASS

**Step 4: Commit**

```bash
git add tests/exact/path/file.test.ts src/exact/path/file.ts
git commit -m "feat: add specific feature"
```

---

### Task N+1: [Next Component]

...
````

## Key Principles

- **Exact file paths** - No ambiguity about where code goes
- **Complete code** - Show actual implementation, not "add validation here"
- **Exact commands** - Include expected output for verification
- **One action per step** - Write test, run test, implement, verify, commit
- **Reference skills** - Mention skill names when relevant

## After Writing Plan

Offer execution choice:

**"Plan saved to `./YYYY-MM-DD-<feature-name>-PLAN.md`. How would you like to execute?**

1. **Subagent-Driven (this session)** - Fresh subagent per task with code review between tasks (@subagent-driven-development)
2. **Parallel Session (new terminal)** - Batch execution with checkpoints (@executing-plans)

**Which approach?"**
