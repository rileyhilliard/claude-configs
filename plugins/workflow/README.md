# Workflow

Essential development workflow commands and session automation.

## What's Included

### Commands

- `/test` - Run tests and analyze failures
- `/review` - Comprehensive code review
- `/commit` - Create well-formatted git commits
- `/debug` - Start systematic debugging session
- `/optimize` - Find and fix performance issues
- `/refactor` - Refactor code following best practices
- `/quick-fix` - Quick fix for IDE diagnostics and linting errors
- `/explain` - Explain code in detail with examples

### Hooks

- `session-start.sh` - Automatically loads user instructions from ~/.claude/CLAUDE.md

## When to Use This Plugin

Install this plugin when you want:

- Quick access to common development workflows via slash commands
- Automatic loading of skills and configuration at session start
- Standardized commands for testing, reviewing, committing, debugging, and optimizing code

This is the foundation plugin that most developers will want installed.

## Dependencies

**Requires:** `meta` plugin

## Installation

```bash
claude plugins install workflow
```

## Usage Examples

Run tests and get failure analysis:

```bash
/test
```

Create a commit with proper formatting:

```bash
/commit
```

Start a systematic debugging session:

```bash
/debug "authentication failing for new users"
```

Get performance recommendations:

```bash
/optimize src/components/Dashboard.tsx
```

Each command is context-aware and will adapt to your project setup automatically.
