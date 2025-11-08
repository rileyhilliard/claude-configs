---
name: handling-errors
description: Applies software engineering error handling best practices across TypeScript/React, Python, and Go. Use when implementing error boundaries, adding try-catch blocks, handling async errors, or reviewing error handling code. Prevents anti-patterns like error hiding, swallowing exceptions, and returning booleans for error conditions.
---

# Handling Errors

Errors are not exceptional—they're expected. Handle them explicitly, preserve their context, and make failures observable.

## Iron Laws

```
1. NEVER swallow errors silently (catch without logging or re-throwing)
2. NEVER convert error conditions into boolean returns
3. ALWAYS preserve error context when wrapping or propagating
4. ALWAYS log at the appropriate level for the caller's needs
5. NEVER add error handling that makes debugging harder
```

## When to Use This Skill

Use this skill when:

- Implementing error boundaries in React components
- Adding try-catch blocks around async operations
- Designing error propagation strategies across layers
- Handling API calls, file I/O, or network requests
- Reviewing code for error handling anti-patterns
- Deciding between throwing vs returning errors
- Setting up logging and observability for failures
- Writing error messages for logs or user interfaces

Do NOT skip this skill when:

- "It's just a quick fix" - Error handling is never optional
- Writing async/await code - Most bugs happen in error paths
- Building user-facing features - Users need meaningful feedback
- Integrating with external services - Failures are guaranteed

## Error Message Best Practices

Every error message should answer three questions: **What happened? Why? How to recover?**

### For Logs (Developer Audience)

Include technical details, identifiers, and full context for debugging.

**Structure:** What + Why + Context (IDs, values, state)

```typescript
// ❌ Bad: No context
logger.error("Database error");

// ❌ Bad: Only what
logger.error("Failed to save user");

// ✅ Good: What + Why + Context
logger.error("Failed to save user: Connection timeout after 30s", {
  userId: user.id,
  email: user.email,
  dbHost: config.db.host,
  attemptCount: retryCount,
  error: error.stack,
});
```

### For Users (Non-Technical Audience)

Use plain language, avoid jargon, and provide clear next steps.

**Structure:** What + Why (user-friendly) + How to Recover

```typescript
// ❌ Bad: Technical jargon
showError("ECONNREFUSED: Connection refused");

// ❌ Bad: No recovery path
showError("Upload failed");

// ✅ Good: Clear what, why, and recovery
showError({
  title: "Upload Failed",
  message: "Your file is too large. Maximum size is 10MB.",
  actions: [
    { label: "Choose a smaller file", onClick: selectFile },
    { label: "Compress this file", onClick: compressFile },
  ],
});
```

### Message Quality Comparison

| Type     | ❌ Bad                      | ✅ Good                                                                                                                              |
| -------- | --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| **Log**  | `Error: Invalid input`      | `User registration failed: Email format invalid for user_id=123, provided="notanemail", expected pattern: user@domain.com`           |
| **User** | `Error code: INVALID_EMAIL` | `Please enter a valid email address (e.g., you@example.com)`                                                                         |
| **Log**  | `Database error`            | `Failed to insert order_id=456: Duplicate key violation on constraint "orders_pkey", existing order created_at=2024-01-15T10:30:00Z` |
| **User** | `Cannot save order`         | `This order already exists. Please check your recent orders or contact support.`                                                     |

### Environment-Aware Error Handling

Show different levels of detail based on environment.

```typescript
function formatError(error: Error, env: string) {
  if (env === "development") {
    // Full details for developers
    return {
      message: error.message,
      stack: error.stack,
      cause: error.cause,
      timestamp: new Date().toISOString(),
    };
  } else {
    // User-friendly for production
    return {
      message: "Something went wrong. Please try again.",
      supportId: generateSupportId(), // For support team lookup
    };
  }
}
```

## Error Categorization and Handling Strategy

Different error types require different handling approaches.

| Type           | Examples                                         | Log Level        | User Message                      | Handling                           |
| -------------- | ------------------------------------------------ | ---------------- | --------------------------------- | ---------------------------------- |
| **Expected**   | Validation failure, Not found, Unauthorized      | `warn` or `info` | Specific, actionable              | Return Result type or custom error |
| **Transient**  | Network timeout, Rate limit, Service unavailable | `warn`           | "Please try again" + retry button | Automatic retry with backoff       |
| **Unexpected** | Null reference, Type error, Database crash       | `error`          | Generic message + support ID      | Log full context, alert on-call    |
| **Critical**   | Auth system down, Payment gateway offline        | `critical`       | Maintenance message               | Circuit breaker, failover          |

```typescript
async function handleApiCall<T>(
  operation: () => Promise<T>
): Promise<Result<T>> {
  try {
    const data = await operation();
    return { success: true, data };
  } catch (error) {
    // Expected errors - user can fix
    if (error instanceof ValidationError) {
      logger.info("Validation failed", { error });
      return { success: false, error: error.message, recoverable: true };
    }

    // Transient errors - retry might work
    if (error.code === "NETWORK_TIMEOUT" || error.code === "RATE_LIMIT") {
      logger.warn("Transient error", { error, retryable: true });
      return {
        success: false,
        error: "Service temporarily unavailable",
        retryable: true,
      };
    }

    // Unexpected errors - log everything
    logger.error("Unexpected error in API call", {
      error: error.stack,
      operation: operation.name,
      timestamp: Date.now(),
    });
    return {
      success: false,
      error: "An unexpected error occurred",
      supportId: generateId(),
    };
  }
}
```

## Fail Fast vs Degrade Gracefully

Know when to fail hard and when to provide fallbacks.

### Fail Fast (Critical Dependencies)

When the system cannot function without it, fail immediately.

```typescript
// Critical: Database connection required for startup
async function initializeApp() {
  try {
    await connectToDatabase();
  } catch (error) {
    logger.critical("Cannot start: Database unavailable", { error });
    process.exit(1); // Fail fast - app cannot function
  }
}
```

### Degrade Gracefully (Optional Features)

When the feature is nice-to-have, use fallbacks.

```typescript
// Optional: User preferences enhance experience but aren't critical
async function loadUserPreferences(userId: string) {
  try {
    return await fetchPreferences(userId);
  } catch (error) {
    logger.warn("Failed to load user preferences, using defaults", {
      userId,
      error,
    });
    return DEFAULT_PREFERENCES; // Degrade gracefully
  }
}

// Optional: Analytics shouldn't block user actions
async function trackEvent(event: Event) {
  try {
    await analytics.track(event);
  } catch (error) {
    logger.warn("Analytics tracking failed", { event, error });
    // Don't throw - user action succeeded even if tracking failed
  }
}
```

## Language-Specific Patterns

For detailed language-specific error handling patterns:

- **TypeScript/React**: See `references/typescript-react.md` for Error Boundaries, typed error classes, Result pattern, UI error display patterns, and centralized error handling
- **Python**: See `references/python.md` for EAFP pattern, custom exception hierarchies, context managers, and exception chaining
- **Go**: See `references/go.md` for explicit error returns, error wrapping, sentinel errors, and defer patterns

## Universal Best Practices

### 1. Log at Appropriate Levels

Don't log at every layer - log where errors are handled.

**Anti-pattern:**

```typescript
// Low-level function
async function fetchData(url: string) {
  try {
    return await fetch(url);
  } catch (error) {
    console.error("Fetch failed:", error); // ❌ Logging here...
    throw error;
  }
}

// Mid-level function
async function getUserData(id: string) {
  try {
    return await fetchData(`/api/users/${id}`);
  } catch (error) {
    console.error("Get user failed:", error); // ❌ ...and here...
    throw error;
  }
}

// Top-level
try {
  await getUserData(id);
} catch (error) {
  console.error("Failed:", error); // ❌ ...and here = 3x same error!
}
```

**Better:**

```typescript
// Low-level - just throw
async function fetchData(url: string) {
  const response = await fetch(url);
  if (!response.ok) {
    throw new Error(`HTTP ${response.status}`);
  }
  return response;
}

// Mid-level - add context, don't log
async function getUserData(id: string) {
  try {
    return await fetchData(`/api/users/${id}`);
  } catch (error) {
    throw new Error(`Failed to load user ${id}: ${error.message}`);
  }
}

// Top-level - log once where handled
try {
  await getUserData(id);
} catch (error) {
  logger.error("User data fetch failed:", error); // ✅ Log once at boundary
  showErrorToUser("Could not load user profile");
}
```

### 2. Provide Context, Not Just Messages

Include relevant data that helps debugging.

```typescript
// ❌ Wrong - No context
throw new Error("Validation failed");

// ✅ Right - Rich context
throw new ValidationError(
  "User age must be between 0 and 150",
  "age",
  providedAge
);
```

### 3. Distinguish Expected vs Unexpected Errors

Expected errors (validation, not found) vs unexpected errors (network, database) need different handling.

```typescript
async function processOrder(orderId: string) {
  // Expected error - return Result type
  const order = await getOrder(orderId);
  if (!order) {
    return { success: false, error: "Order not found" };
  }

  // Unexpected error - let it throw
  const processed = await chargePayment(order); // Infrastructure errors throw

  return { success: true, data: processed };
}
```

### 4. Fail Fast at Boundaries

Validate inputs at system boundaries, fail fast.

```typescript
// API endpoint - validate immediately
app.post("/api/users", async (req, res) => {
  const validation = validateUserInput(req.body);
  if (!validation.valid) {
    return res.status(400).json({
      error: "Validation failed",
      fields: validation.errors,
    });
  }

  // Now we can trust the data
  const user = await createUser(validation.data);
  res.json(user);
});
```

## Anti-Patterns and Red Flags

**STOP if you see these:**

| Anti-Pattern                      | Why It's Bad                              | Fix                                     |
| --------------------------------- | ----------------------------------------- | --------------------------------------- |
| **Empty catch blocks**            | Hides errors, impossible to debug         | Always log or re-throw                  |
| **Returning booleans for errors** | Loses all error context                   | Return Result type or throw             |
| **Generic error messages**        | "Error" tells nothing                     | Include what/why/how-to-fix             |
| **Bare except/catch-all**         | Catches system exits, keyboard interrupts | Catch specific exception types          |
| **Ignoring Go errors**            | `_, err := ...` without checking          | Always check: `if err != nil`           |
| **console.log in catch**          | Not proper error logging                  | Use structured logger                   |
| **Multiple logs of same error**   | Pollutes logs, hard to trace              | Log once where handled                  |
| **No error boundaries (React)**   | Entire app crashes                        | Wrap components in ErrorBoundary        |
| **Swallowing async errors**       | Unhandled promise rejections              | Always await or .catch()                |
| **Re-throwing without context**   | `throw err` loses call site               | Wrap: `throw new Error(..., { cause })` |

## Quick Reference

| Scenario           | TypeScript/React             | Python                                | Go                       |
| ------------------ | ---------------------------- | ------------------------------------- | ------------------------ |
| Expected failure   | Result type                  | Return None or raise custom exception | Return sentinel error    |
| Unexpected failure | Throw Error                  | Raise Exception                       | Return wrapped error     |
| Resource cleanup   | try-finally or using         | Context manager (with)                | defer                    |
| Add context        | Wrap in new Error            | Chain with `from`                     | Wrap with `%w`           |
| UI error handling  | Error Boundary               | Not applicable                        | Not applicable           |
| Validation errors  | Custom ValidationError class | Custom exception class                | ErrInvalidInput sentinel |
| Network/DB errors  | Let them throw to top        | Let them raise to top                 | Wrap and return          |

## Summary: Error Handling Checklist

| Principle                | ✅ Do                                          | ❌ Don't                                    |
| ------------------------ | ---------------------------------------------- | ------------------------------------------- |
| **Never Silence Errors** | Log with context, then throw or handle         | Catch without logging or re-throwing        |
| **Meaningful Messages**  | Include what/why/how-to-recover                | Generic "Error" or technical codes only     |
| **Preserve Context**     | Wrap errors, keep stack traces                 | Strip error chains or stack info            |
| **Categorize Errors**    | Expected vs unexpected vs transient            | Treat all errors the same                   |
| **Log Appropriately**    | Once where handled, with full context          | At every layer, or not at all               |
| **UI Patterns**          | Single contextual display (toast/modal/inline) | Same error in multiple places               |
| **Actionable Recovery**  | Provide retry/support/fix options              | Leave users stuck with no path forward      |
| **Environment-Aware**    | Dev: full stack, Prod: user-friendly           | Expose stack traces in production           |
| **Centralize Handling**  | Global handlers, consistent format             | Scattered ad-hoc patterns                   |
| **Fail Fast vs Degrade** | Critical: fail, Optional: fallback             | Fail silently or block on optional features |
| **Test Error Paths**     | Write tests for error scenarios                | Only test happy paths                       |

## Integration with Other Skills

**Use together with:**

- **systematic-debugging** - When errors occur and you need to trace root cause
- **verification-before-completion** - Always test error paths before claiming done
- **writing-tests** - Write tests for error scenarios, not just happy paths
- **testing-anti-patterns** - Avoid mocking errors you should be testing for real

**When to delegate:**

- If debugging complex error scenarios → use systematic-debugging skill
- If error is deep in call stack → use root-cause-tracing skill
- If tests are flaky due to error timing → use condition-based-waiting skill
