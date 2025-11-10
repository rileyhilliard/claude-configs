# Tactical Debugging Techniques

Use these tactical techniques when executing the systematic debugging process to gather evidence and isolate problems.

## Binary Search / Code Bisection

Systematically narrow down the problem:

1. Comment out or disable half the suspicious code
2. If bug persists, problem is in the active half
3. If bug disappears, problem is in the disabled half
4. Repeat until you isolate the exact line

Also useful: `git bisect` to find which commit introduced a bug

**Example:**
```bash
# Find the commit that broke tests
git bisect start
git bisect bad HEAD  # Current version is broken
git bisect good v2.1.0  # v2.1.0 was working
# Git will check out middle commit - run tests
npm test
git bisect good  # or 'bad' depending on result
# Repeat until git identifies the breaking commit
```

## Minimal Reproduction

Strip away everything non-essential to isolate the issue:

- Remove unrelated features, components, dependencies
- Use hardcoded data instead of complex data flows
- Simplify to the smallest code that reproduces the bug
- Creates a focused test case that reveals the root cause

**Benefits:**
- Eliminates confounding variables
- Makes the actual problem visible
- Easier to reason about and test
- Often reveals the bug during the simplification process

## Strategic Logging & Instrumentation

Add diagnostic output at key points to gather evidence:

```python
# Trace execution flow
print(f"1. Starting with: {input_data}")
result = process(input_data)
print(f"2. After processing: {result}")
print(f"3. Type: {type(result)}, Length: {len(result) if hasattr(result, '__len__') else 'N/A'}")
```

```javascript
// Verify assumptions
console.log('Type:', typeof value, 'Value:', value)
console.log('Is truthy:', !!value)
console.log('Is null/undefined:', value == null)
console.log('Object keys:', Object.keys(object))
console.log('Array length:', array?.length)
```

```javascript
// Track timing and performance
const start = performance.now()
await longOperation()
console.log(`Operation took ${performance.now() - start}ms`)
```

```bash
# Debug script execution
set -x  # Print each command before executing
set -e  # Exit on first error
echo "DEBUG: Variable value is: $MY_VAR"
```

**Strategic placement:**
- Before/after critical operations
- At component boundaries
- Where data transforms
- Where assumptions are made
- In error handlers

## Runtime Assertions

Make assumptions explicit and fail fast when they're violated:

```javascript
// Validate preconditions
if (!user) throw new Error('User should be authenticated here')
if (items.length === 0) console.warn('Unexpected empty items array')
if (typeof id !== 'string') throw new TypeError(`Expected string ID, got ${typeof id}`)
```

```python
# Python assertions
assert user is not None, "User should be authenticated"
assert len(items) > 0, "Items should not be empty"
assert isinstance(id, str), f"Expected str, got {type(id)}"
```

**Benefits:**
- Catches bad state early
- Documents assumptions in code
- Provides clear error messages
- Helps narrow down where logic breaks

## Differential Analysis

Compare working vs broken states to identify differences:

- **Version comparison:** Working code in old version vs broken in new version
- **Environment comparison:** Working environment vs broken environment
- **Data comparison:** Working input vs problematic input
- **Configuration comparison:** Working settings vs broken settings

**Process:**
1. Identify a working baseline
2. Identify the broken case
3. List every difference between them
4. Test each difference in isolation
5. Find which difference causes the failure

**Example:**
```bash
# Compare environment variables
diff <(env | sort) <(docker exec container env | sort)

# Compare configuration files
diff config/production.json config/staging.json

# Compare dependency versions
diff <(npm list --depth=0) old-package-lock.json
```

## Multi-Component System Debugging

**WHEN system has multiple components (CI → build → signing, API → service → database):**

**BEFORE proposing fixes, add diagnostic instrumentation:**

```
For EACH component boundary:
  - Log what data enters component
  - Log what data exits component
  - Verify environment/config propagation
  - Check state at each layer

Run once to gather evidence showing WHERE it breaks
THEN analyze evidence to identify failing component
THEN investigate that specific component
```

**Example (multi-layer system):**

```bash
# Layer 1: Workflow
echo "=== Secrets available in workflow: ==="
echo "IDENTITY: ${IDENTITY:+SET}${IDENTITY:-UNSET}"

# Layer 2: Build script
echo "=== Env vars in build script: ==="
env | grep IDENTITY || echo "IDENTITY not in environment"

# Layer 3: Signing script
echo "=== Keychain state: ==="
security list-keychains
security find-identity -v

# Layer 4: Actual signing
codesign --sign "$IDENTITY" --verbose=4 "$APP"
```

**This reveals:** Which layer fails (secrets → workflow ✓, workflow → build ✗)

## Backward Tracing for Deep Call Stack Errors

**WHEN error is deep in call stack:**

- Where does bad value originate?
- What called this with bad value?
- Keep tracing up until you find the source
- Fix at source, not at symptom

For complex cases, see the `root-cause-tracing` skill for detailed backward tracing techniques.
