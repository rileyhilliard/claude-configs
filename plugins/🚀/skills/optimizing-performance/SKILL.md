---
name: optimizing-performance
description: Use when investigating slow execution, high memory usage, unnecessary computation, or large payload sizes - measurement-driven approach that balances performance gains against code complexity, prioritizing optimizations that simplify code while improving speed
---

# Optimizing Performance

**Core Principle:** Readable code that's "fast enough" beats complex code that's "optimal". Always measure first, optimize second.

## The Golden Rule

```
IF optimization reduces complexity AND improves performance → ALWAYS DO IT (win-win)
IF optimization increases complexity → 10x performance gain OR fix critical UX issue
```

## The Four-Phase Process

### Phase 1: Measure First (REQUIRED)

**The Iron Law:** Never optimize without data.

**What to measure:** Performance isn't just time—it includes re-renders, memory, network, and payload size.

| Metric         | What to Count                 | Tools                                               |
| -------------- | ----------------------------- | --------------------------------------------------- |
| **Time**       | ms per operation              | `performance.now()`, profilers                      |
| **Re-renders** | Component render count        | React DevTools Profiler, `console.log` in component |
| **Memory**     | MB allocated, GC frequency    | DevTools Memory tab, heap snapshots                 |
| **Network**    | Request count, KB transferred | Network tab, bundle analyzer                        |
| **Database**   | Query count, rows scanned     | Query logs, EXPLAIN plans                           |

**How to measure:**

**1. Create a benchmark script** for time-based metrics:

```javascript
// benchmark.js - Universal pattern
const ITERATIONS = 1000;
const SAMPLE_SIZE = 10000; // Realistic data size

function generateRealisticData() {
  return Array.from({ length: SAMPLE_SIZE }, (_, i) => ({
    id: i,
    name: `User ${i}`,
    active: Math.random() > 0.5,
  }));
}

function benchmark(fn, data, name) {
  const start = performance.now();
  for (let i = 0; i < ITERATIONS; i++) {
    fn(data);
  }
  const avg = (performance.now() - start) / ITERATIONS;
  console.log(`${name}: ${avg.toFixed(3)}ms avg`);
  return avg;
}

const data = generateRealisticData();
const current = benchmark(currentImpl, data, "Current");
const optimized = benchmark(optimizedImpl, data, "Optimized");
console.log(`Improvement: ${(current / optimized).toFixed(2)}x faster`);
```

**2. Measure re-renders** in React/Vue:

```javascript
// Add to component to count renders
let renderCount = 0;
function MyComponent() {
  console.log(`MyComponent render #${++renderCount}`);
  // ... rest of component
}

// Or use React DevTools Profiler:
// 1. Open DevTools → Profiler tab
// 2. Start recording
// 3. Perform action (click, type, etc.)
// 4. Stop recording
// 5. Check commit count and component render times
```

**3. Analyze algorithmic complexity** (Big O):

- Nested loops = O(n²) quadratic
- Single loop = O(n) linear
- Hash map lookup = O(1) constant
- Binary search = O(log n) logarithmic

**4. Use profiling tools** when needed:

| Context  | Tool                             |
| -------- | -------------------------------- |
| Browser  | DevTools Performance, Lighthouse |
| Node.js  | `node --prof`, Chrome DevTools   |
| React    | React DevTools Profiler          |
| Memory   | DevTools Memory, heap snapshots  |
| Database | EXPLAIN plans, query logs        |

**Phase 1 Complete When:**

- [ ] Baseline measured (time/renders/memory/requests/KB)
- [ ] Measurement script/tool set up
- [ ] Big O complexity calculated
- [ ] Bottleneck location identified (file:line)

### Phase 2: Identify Root Cause

**Common issues:**

| Issue                | Indicators                               | Fix Direction                   |
| -------------------- | ---------------------------------------- | ------------------------------- |
| **O(n²) complexity** | Nested loops, `array.includes()` in loop | Use Set/Map (O(1) lookup)       |
| **Unnecessary work** | Re-computing same result                 | Cache/memoize                   |
| **I/O bottleneck**   | N+1 queries, sequential API calls        | Batch operations, use joins     |
| **Large datasets**   | Rendering 1000+ items                    | Virtualization, pagination      |
| **Payload size**     | >500KB bundles, large JSON               | Tree-shake, compress, lazy load |
| **Blocking tasks**   | >16ms UI, >100ms input response          | Debounce, web workers, async    |

**Phase 2 Complete When:**

- [ ] Root cause identified (algorithm, I/O, payload, blocking)
- [ ] Big O complexity calculated

### Phase 3: Evaluate Cost vs Benefit

**Decision logic:**

1. Does it **reduce** complexity? → ✅ ALWAYS DO IT (even if minimal performance gain)
2. Does it **increase** complexity? → Only if 10x faster OR fixes critical UX (>16ms UI, >100ms input)
3. Otherwise → ❌ DON'T DO IT

**Phase 3 Complete When:**

- [ ] Complexity impact assessed (reduces/neutral/increases)
- [ ] Benchmark shows quantified improvement (Nx faster)
- [ ] Decision made based on rule above

### Phase 4: Implement & Verify

1. Make minimal changes targeting specific bottleneck
2. Re-run benchmark script from Phase 1
3. Verify tests still pass (behavior preserved)
4. Document measurements if adding complexity

**Phase 4 Complete When:**

- [ ] Re-benchmark shows expected improvement
- [ ] Tests pass
- [ ] No regressions introduced

## Common Optimization Patterns

### Win-Win Optimizations (Always Do)

**Multiple loops → Single loop:**

```javascript
// ❌ Three passes
const ids = users.map((u) => u.id);
const active = users.filter((u) => u.active);

// ✅ One pass (simpler + faster)
const { ids, active } = users.reduce(
  (acc, u) => {
    acc.ids.push(u.id);
    if (u.active) acc.active.push(u);
    return acc;
  },
  { ids: [], active: [] }
);
```

**Nested loops → Hash map (O(n²) → O(n)):**

```javascript
// ❌ O(n²)
const matched = orders.filter((o) => users.some((u) => u.id === o.userId));

// ✅ O(n) - simpler logic
const userIds = new Set(users.map((u) => u.id));
const matched = orders.filter((o) => userIds.has(o.userId));
```

### High-Value Optimizations

| Pattern             | When                                            | Metric Improved     | Example                        |
| ------------------- | ----------------------------------------------- | ------------------- | ------------------------------ |
| **Virtualization**  | Lists >1000 items                               | Time, re-renders    | react-window, tanstack-virtual |
| **Memoization**     | Expensive calc (>5ms) OR unnecessary re-renders | Time, re-renders    | `useMemo`, `React.memo`        |
| **Batching**        | Multiple state updates/DB writes                | Re-renders, queries | Single setState, bulk INSERT   |
| **Lazy loading**    | Large dependencies, routes                      | Payload, time       | `import('./heavy-lib')`        |
| **Data structures** | Frequent lookups                                | Time                | `Set`/`Map` vs `Array`         |
| **Payload**         | >500KB bundles                                  | Network KB          | Tree-shake, compress, paginate |

**Reducing re-renders in React:**

```javascript
// ❌ Component re-renders on every parent render
function Parent() {
  const [count, setCount] = useState(0);
  return <ExpensiveChild data={data} />;
}

// ✅ Memoize to prevent unnecessary re-renders
const ExpensiveChild = React.memo(function ExpensiveChild({ data }) {
  // Only re-renders when 'data' prop changes
});
```

## Red Flags

If you catch yourself doing any of these, STOP and return to Phase 1:

- Optimizing without benchmark data
- Micro-optimizing code <16ms (UI) or <100ms (input response)
- Adding complexity for minimal gain
- Optimizing infrequently-run code
- "Premature optimization" before it's a problem

## Integration with Other Skills

**Use with:**

- **systematic-debugging** - When optimization introduces bugs
- **refactoring-code** - Refactor first, then optimize if needed
- **verification-before-completion** - Before claiming optimization complete
