# Claude Essentials

A comprehensive development plugin for Claude Code with essential commands, skills, and specialized agents.

## What This Is

This is a single plugin (🚀) that provides everything you need for daily development work:

- **8 commands** - Quick shortcuts for testing, debugging, reviewing, and committing
- **15 skills** - Reusable patterns for testing, debugging, refactoring, and optimization
- **3 agents** - Expert personas for architecture, code review, and documentation
- **Session hooks** - Automatic project configuration on startup

Everything in one place, with minimal namespace pollution.

## Quick Start

### Prerequisites

You need Claude Code installed. If you don't have it yet, head to [claude.com/product/claude-code](https://www.claude.com/product/claude-code).

### Installation

1. Add this marketplace to Claude Code:

```bash
/plugin marketplace add https://github.com/rileyhilliard/claude-essentials
```

2. Install the plugin:

```bash
/plugin install 🚀
```

That's it. You now have access to all commands, skills, and agents.

### Verify Installation

Start Claude Code and try these:

```bash
# Start Claude Code
claude

# Check available commands
# Type "/" to see all commands

# Try a quick command
/🚀:explain README.md
```

## What's Included

### Commands

Quick shortcuts for everyday development work:

- `/🚀:test` - Run tests and analyze failures
- `/🚀:explain` - Break down code or concepts
- `/🚀:quick-fix` - Fix IDE diagnostics and linting errors
- `/🚀:debug` - Launch systematic debugging
- `/🚀:optimize` - Find performance bottlenecks
- `/🚀:refactor` - Improve code quality
- `/🚀:review` - Get comprehensive code review
- `/🚀:commit` - Generate semantic commit messages

### Skills

Reusable workflows for specific development patterns. Invoke with `@skills/🚀:skill-name`:

**Testing & Quality:**
- `writing-tests` - Testing Trophy methodology, behavior-focused tests
- `testing-anti-patterns` - Prevent common testing mistakes
- `verification-before-completion` - Verify before claiming success

**Debugging & Problem Solving:**
- `systematic-debugging` - Four-phase debugging framework
- `root-cause-tracing` - Trace bugs to their source
- `condition-based-waiting` - Replace race conditions with polling

**Code Quality:**
- `refactoring-code` - Behavior-preserving code improvements
- `optimizing-performance` - Measurement-driven optimization
- `handling-errors` - Error handling best practices

**Planning & Execution:**
- `writing-plans` - Create detailed implementation plans
- `executing-plans` - Execute plans in controlled batches

**Meta Skills:**
- `creating-claude-skills` - Best practices for authoring skills
- `dispatching-parallel-agents` - Investigate independent problems concurrently
- `subagent-driven-development` - Execute plans with fresh subagents per task
- `visualizing-with-mermaid` - Create professional technical diagrams

### Agents

Expert personas for complex, multi-step work. Invoke with `@agent-🚀:agent-name`:

- `@architect` - System design and architectural planning with diagrams
- `@code-reviewer` - Comprehensive PR/MR reviews enforcing standards
- `@documentation-writer` - Clear, practical documentation

### Reference Templates

- ADR (Architecture Decision Record)
- PRD (Product Requirements Document)
- Technical Design Document

### Hooks

- Session startup automation that loads project-specific configurations

## Usage Examples

### Typical Workflows

**Fix failing tests:**

```bash
/🚀:test
# If complex, escalate:
@skills/🚀:systematic-debugging
```

**Review before merge:**

```bash
/🚀:review
git add .
/🚀:commit
```

**Optimize performance:**

```bash
/🚀:optimize src/components/DataTable.tsx
# For deep analysis:
@skills/🚀:optimizing-performance
```

**Plan a feature:**

```bash
@agent-🚀:architect I need to add real-time notifications. We have 10k concurrent users.
# Then create a plan:
@skills/🚀:writing-plans
```

**Clean up legacy code:**

```bash
/🚀:explain src/legacy/payment-processor.js
@skills/🚀:refactoring-code
```

### Understanding the System

**Commands vs Skills vs Agents:**

- **Commands** (`/command-name`) are quick keyboard shortcuts for routine tasks
- **Skills** (`@skills/skill-name`) are reusable workflows that guide specific development patterns
- **Agents** (`@agent-name`) are expert personas for complex, multi-step work

Use commands for quick actions, skills for following proven patterns, and agents when you need specialized expertise.

## Customization

All components are just markdown files organized in directories. Want to customize? Edit them directly in `~/.claude/plugins/🚀/`.

### Creating Your Own Command

Add a markdown file to `~/.claude/plugins/🚀/commands/`:

```markdown
---
description: Your command description
argument-hint: "[optional-arg]"
allowed-tools: Bash, Read
---

Your command instructions here.
```

### Creating Your Own Skill

Add a directory and SKILL.md file to `~/.claude/plugins/🚀/skills/`:

```markdown
---
name: my-skill
description: What this skill does
---

# Skill Instructions

Your skill workflow here.
```

### Creating Your Own Agent

Add a markdown file to `~/.claude/plugins/🚀/agents/`:

```markdown
---
name: my-agent
description: Expert at specific domain
tools: Read, Grep, Glob, Bash
color: blue
---

Your agent personality and workflow here.
```

## Project Structure

```
~/.claude/
├── CLAUDE.md              # Communication guidelines (copy here manually)
└── plugins/
    └── 🚀/
        ├── .claude-plugin/
        │   └── plugin.json     # Plugin metadata
        ├── commands/           # 8 development commands
        ├── skills/             # 15 development skills
        ├── agents/             # 3 expert agents
        ├── hooks/              # Session automation
        └── references/         # Document templates
```

## Tips

**Commands accept arguments:** Most commands work with optional parameters.

```bash
/🚀:test pytest tests/unit
/🚀:explain AuthController
/🚀:optimize src/components/
```

**Skills are for learning:** Invoke a skill to understand a pattern, then apply it.

```bash
@skills/🚀:writing-tests
# Follow the guidance to write tests
```

**Agents need context:** Give agents rich context for better results.

```bash
# Vague
@agent-🚀:architect help with authentication

# Better
@agent-🚀:architect We need OAuth2 + JWT authentication for a React SPA with Node backend. 50k users.
```

**Check diagnostics:** Use `/🚀:quick-fix` before committing to clean up lint errors and type issues.

## Contributing

Found a bug? Have an idea? Contributions welcome.

1. Fork this repo
2. Create a feature branch
3. Test your changes locally
4. Submit a PR with details

Ideas for contributions:

- New commands for common workflows
- Additional skills for specific patterns
- Specialized agents for other domains
- Documentation improvements

## Resources

- [Claude Code](https://www.claude.com/product/claude-code)
- [Claude API Docs](https://docs.anthropic.com/)
- [Model Context Protocol](https://modelcontextprotocol.io/)

## License

MIT - Use it, share it, make it better.
