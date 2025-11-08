# Development Skills

Core development skills covering testing, debugging, refactoring, performance optimization, error handling, and planning workflows.

## What's Included

### Skills
- `writing-tests` - Testing Trophy model (Integration > E2E > Unit), behavior-focused testing with real dependencies
- `testing-anti-patterns` - Prevents testing mock behavior, production pollution, and inappropriate mocking
- `systematic-debugging` - Four-phase debugging framework (investigation, pattern analysis, hypothesis testing, implementation)
- `refactoring-code` - Systematic refactoring with behavior preservation and test verification
- `optimizing-performance` - Measurement-driven performance optimization balancing gains vs complexity
- `handling-errors` - Error handling best practices across TypeScript/React, Python, and Go
- `root-cause-tracing` - Trace bugs backward through call stack to find original triggers
- `verification-before-completion` - Requires running verification commands before claiming work is complete
- `writing-plans` - Create detailed implementation plans for engineers with minimal context
- `executing-plans` - Execute implementation plans in controlled batches with review checkpoints
- `condition-based-waiting` - Replace arbitrary timeouts with condition polling for flaky tests

## When to Use This Plugin

Install this plugin when you need:
- Proven workflows for writing tests, debugging issues, or refactoring code
- Guidance on performance optimization and error handling
- Systematic approaches to common development tasks
- Protection against common anti-patterns in testing and error handling

These skills are language-agnostic where possible and provide specific guidance for TypeScript/React, Python, and Go where needed.

## Dependencies

None. This plugin is standalone.

## Installation

```bash
claude plugins install development-skills
```

## Usage Examples

When writing tests:
```
I'm using the writing-tests skill to add integration tests for the authentication flow.
```

When debugging a complex issue:
```
I'm using the systematic-debugging skill to investigate this race condition.
```

When optimizing slow code:
```
I'm using the optimizing-performance skill to improve the dashboard load time.
```

Skills are invoked automatically by Claude when the task matches the skill's domain. You can also explicitly request them.
