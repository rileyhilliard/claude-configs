---
name: writing-tests
description: Use when writing tests for any code - follows Testing Trophy model (Integration > E2E > Unit), focuses on behavior over implementation, uses real dependencies by default, and ensures tests survive refactoring
---

# Writing Tests

**Core Philosophy:** Test user-observable behavior with real dependencies. Tests should survive refactoring when behavior is unchanged.

## Testing Trophy Model

Write tests in this priority order:

1. **Integration Tests (PRIMARY)** - Multiple units with real dependencies
2. **E2E Tests (SECONDARY)** - Complete workflows across the stack
3. **Unit Tests (RARE)** - Pure functions only (no dependencies)

**Default to integration tests.** Only drop to unit tests for pure utility functions.

## Pre-Test Workflow

BEFORE writing any tests:

1. **Review project standards** - Check `.cursor/rules/*`, testing docs, or `*test*.md` files
2. **Understand behavior** - What should this do? What can go wrong?
3. **Choose test type** - Integration (default), E2E (critical workflows), or Unit (pure functions)
4. **Identify dependencies** - What needs to be real vs mocked?

## Test Type Decision

```
Is this a complete user workflow?
  → YES: E2E test (Playwright/Cypress)

Is this a pure function (no side effects/dependencies)?
  → YES: Unit test

Everything else:
  → Integration test (with real dependencies)
```

## Mocking Guidelines

**Default: Don't mock. Use real dependencies.**

### ✅ Only Mock These

- External APIs (fetch, HTTP requests)
- Timers (setTimeout, setInterval, Date.now)
- Randomness (Math.random, crypto)
- File I/O
- Browser APIs (window.location, localStorage)
- Third-party services (payments, analytics)

### ❌ Never Mock These

- State management (Redux, Zustand, Context)
- Providers/Context
- Child components
- Internal modules
- Hooks/composables
- Routing (use memory router instead)

**Why:** Mocking internal dependencies creates brittle tests that break during refactoring.

## Integration Test Pattern

```javascript
describe("Feature Name", () => {
  // Real state/providers, not mocks
  const setup = (initialState = {}) => {
    return render(<Component />, {
      wrapper: ({ children }) => (
        <StateProvider initialState={initialState}>{children}</StateProvider>
      ),
    });
  };

  it("should show result when user performs action", async () => {
    setup({ items: [] });

    // Semantic query (role/label/text)
    const button = screen.getByRole("button", { name: /add item/i });
    await userEvent.click(button);

    // Assert on UI output
    await waitFor(() => expect(screen.getByText(/item added/i)).toBeVisible());
  });
});
```

## E2E Test Pattern

```javascript
test("should complete workflow when user takes action", async ({ page }) => {
  await page.goto("/dashboard");

  // Given: precondition
  await expect(page.getByRole("heading", { name: "Dashboard" })).toBeVisible();

  // When: user action
  await page.getByRole("button", { name: "Add Item" }).click();

  // Then: expected outcome
  await expect(page.getByText("Item added successfully")).toBeVisible();
});
```

## Query Strategy

**Use semantic queries (order of preference):**

1. `getByRole('button', { name: /submit/i })` - Accessibility-based
2. `getByLabelText(/email/i)` - Form labels
3. `getByText(/welcome/i)` - Visible text
4. `getByPlaceholderText(/search/i)` - Input placeholders

**Avoid:**

- `getByTestId` - Implementation detail
- CSS selectors - Brittle, breaks during refactoring
- Internal state queries - Not user-observable

## String Management

**Use source constants, not hard-coded strings:**

```javascript
// ✅ Good - References actual constant
import { MESSAGES } from "@/constants/messages";
expect(screen.getByText(MESSAGES.SUCCESS)).toBeVisible();

// ❌ Bad - Hard-coded, breaks when copy changes
expect(screen.getByText("Action completed successfully!")).toBeVisible();
```

## Quality Checklist

Before completing tests, verify:

- [ ] Happy path covered
- [ ] Error conditions handled
- [ ] Loading states tested
- [ ] User interactions simulated realistically
- [ ] Accessibility queries used (role, label, text)
- [ ] Real dependencies used (minimal mocking)
- [ ] Condition-based waiting used (see `condition-based-waiting` skill)
- [ ] Tests survive refactoring (no implementation details)

## What NOT to Test

- Internal state (use testing-anti-patterns skill)
- Component props
- Function call counts
- CSS classes
- Test IDs
- Implementation details

**Test behavior users see, not code structure.**

## Quick Reference

| Test Type   | When                | Dependencies | Tools      |
| ----------- | ------------------- | ------------ | ---------- |
| Integration | Default             | Real         | Jest + RTL |
| E2E         | Critical workflows  | Real         | Playwright |
| Unit        | Pure functions only | None         | Jest       |

**Remember:** Behavior over implementation. Real over mocked. Semantic over structural.
