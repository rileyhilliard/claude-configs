---
name: testing-anti-patterns
description: Use when writing or changing tests, adding mocks, or tempted to add test-only methods to production code - prevents testing mock behavior, production pollution with test-only methods, and mocking without understanding dependencies
---

# Testing Anti-Patterns

**Core Principle:** Test real behavior, not mock behavior. Mocks isolate, they're not the thing being tested.

**Use with:** `writing-tests` skill provides positive guidance on how to write good tests. This skill focuses on what NOT to do.

**Following TDD prevents these anti-patterns.**

## Iron Laws

1. **NEVER test mock behavior** - Test real component behavior
2. **NEVER add test-only methods to production** - Put them in test utilities
3. **NEVER mock without understanding** - Know dependencies before mocking

## Anti-Pattern 1: Testing Mock Behavior

**Violation:**
```typescript
// ❌ Testing mock existence, not real behavior
test('renders sidebar', () => {
  render(<Page />);
  expect(screen.getByTestId('sidebar-mock')).toBeInTheDocument();
});
```

**Fix:**
```typescript
// ✅ Test real component with semantic query
test('renders sidebar', () => {
  render(<Page />);  // Don't mock sidebar
  expect(screen.getByRole('navigation')).toBeInTheDocument();
});
```

**Gate:** Before asserting on mock elements, ask "Am I testing real behavior or mock existence?" If testing mocks → Stop, delete assertion or unmock.

**Note:** Use semantic queries (getByRole, getByLabelText, etc.) - see `writing-tests` skill Query Strategy section.

## Anti-Pattern 2: Test-Only Methods in Production

**Violation:**
```typescript
// ❌ destroy() only used in tests - pollutes production class
class Session {
  async destroy() {
    await this._workspaceManager?.destroyWorkspace(this.id);
  }
}

afterEach(() => session.destroy());
```

**Fix:**
```typescript
// ✅ Test utilities handle cleanup
// In test-utils/cleanupSession.ts
export async function cleanupSession(session: Session) {
  const workspace = session.getWorkspaceInfo();
  if (workspace) await workspaceManager.destroyWorkspace(workspace.id);
}

afterEach(() => cleanupSession(session));
```

**Gate:** Before adding methods to production classes, ask "Is this only for tests?" Yes → Put in test utilities. Also ask "Does this class own this resource's lifecycle?" No → Wrong class.

## Anti-Pattern 3: Mocking Without Understanding

**The Mistake:** Mocking methods without understanding their side effects or what your test depends on.

**Violation:**
```typescript
// ❌ Mock prevents side effect test depends on
test('detects duplicate server', () => {
  vi.mock('ToolCatalog', () => ({
    discoverAndCacheTools: vi.fn().mockResolvedValue(undefined)
  }));

  await addServer(config);
  await addServer(config);  // Should detect duplicate, won't!
});
```

**Why this fails:** The mocked method had a side effect (writing config) that the test depends on to detect duplicates.

**Fix:**
```typescript
// ✅ Mock at correct level, preserve needed behavior
test('detects duplicate server', () => {
  vi.mock('MCPServerManager'); // Mock slow startup only

  await addServer(config);  // Config written ✓
  await addServer(config);  // Duplicate detected ✓
});
```

**Gate:** Before mocking:
1. Ask: "What side effects does this method have?"
2. Ask: "Does my test depend on those side effects?"
3. If yes → Mock at lower level (the slow/external operation, not the method test needs)
4. Unsure? → Run with real implementation first, observe what's needed, THEN add minimal mocking

**For mocking guidelines** (what to mock vs use real), see `writing-tests` skill Mocking Guidelines section.

**Red flags:**
- "I'll mock this to be safe"
- "This might be slow, better mock it"
- Can't explain why mock is needed
- Mock setup longer than test logic

## Anti-Pattern 4: Incomplete Mocks

**Violation:**
```typescript
// ❌ Partial mock - missing fields downstream code needs
const mockResponse = {
  status: 'success',
  data: { userId: '123', name: 'Alice' }
  // Missing: metadata.requestId that downstream code uses
};
```

**Fix:**
```typescript
// ✅ Mirror real API completely
const mockResponse = {
  status: 'success',
  data: { userId: '123', name: 'Alice' },
  metadata: { requestId: 'req-789', timestamp: 1234567890 }
};
```

**Gate:** Before creating mocks, check "What fields does real API return?" Include ALL fields, not just what your test uses. Partial mocks fail silently when downstream code needs omitted fields.

## Anti-Pattern 5: Tests as Afterthought

**Violation:**
```
✅ Implementation complete
❌ No tests
"Ready for testing"
```

**Fix:** Use TDD cycle:
1. Write failing test
2. Implement to pass
3. Refactor
4. THEN claim complete

Testing is part of implementation, not optional follow-up.

## How TDD Prevents These Anti-Patterns

1. **Write test first** → Think about what you're testing (not mocks)
2. **Watch it fail** → Confirms test tests real behavior
3. **Minimal implementation** → No test-only methods creep in
4. **Real dependencies first** → See what test needs before mocking

**If testing mock behavior, you violated TDD** - you added mocks without watching test fail against real code.

## Quick Reference

| Anti-Pattern | Fix |
|--------------|-----|
| Testing mock existence | Test real component or unmock |
| Test-only methods in production | Move to test utilities |
| Mocking without understanding | Understand dependencies, mock minimally at right level |
| Incomplete mocks | Mirror real API completely with all fields |
| Tests as afterthought | TDD - write tests first |

## Red Flags

- Asserting on `*-mock` test IDs
- Methods only called in test files
- Mock setup >50% of test
- Test fails when removing mock
- Can't explain why mock needed
- "I'll mock this to be safe"

**Bottom line:** Mocks isolate, they're not the thing being tested. Test real behavior or question why you're mocking.
