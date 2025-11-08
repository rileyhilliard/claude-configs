# Claude Essentials

A curated collection of development workflows, skills, and specialized agents for Claude Code, distributed as marketplace plugins.

## What This Is

This is a plugin marketplace that provides four focused plugins for Claude Code:

- **core-workflow** - Essential development commands and session automation
- **development-skills** - Reusable patterns for testing, debugging, and refactoring
- **agent-skills** - Meta skills for working with agents and creating custom skills
- **specialized-agents** - Expert AI personas for architecture, code review, and documentation

These plugins work together to provide a comprehensive development environment, but you can install just the ones you need.

## Quick Start

### Prerequisites

You need Claude Code installed. If you don't have it yet, head to [claude.com/product/claude-code](https://www.claude.com/product/claude-code).

### Installation

1. Add this marketplace to Claude Code:

```bash
/plugin marketplace add https://github.com/rileyhilliard/claude-configs
```

2. Install the plugins you want (recommended order):

```bash
# Start with agent-skills for foundational capabilities
/plugin install agent-skills

# Add development workflows
/plugin install development-skills

# Get the command shortcuts
/plugin install core-workflow

# Optional: specialized agents for architecture and reviews
/plugin install specialized-agents
```

### Verify Installation

Start Claude Code and try these:

```bash
# Start Claude Code
claude

# Check available commands
# Type "/" to see all commands

# Try a quick command
/explain README.md

```

## The Plugins

### core-workflow

Essential commands for everyday development work. These are your quick shortcuts.

**Commands:**

- `/test` - Run tests and analyze failures
- `/explain` - Break down code or concepts
- `/quick-fix` - Fix IDE diagnostics and linting errors
- `/debug` - Launch systematic debugging
- `/optimize` - Find performance bottlenecks
- `/refactor` - Improve code quality
- `/review` - Get comprehensive code review
- `/commit` - Generate semantic commit messages

**Hooks:**

- Session startup automation
- Project-specific configurations

### development-skills

Core development patterns you can invoke as needed. These are reusable workflows that guide specific tasks.

**Skills:**

- `writing-tests` - Testing Trophy methodology, behavior-focused tests
- `testing-anti-patterns` - Prevent common testing mistakes
- `systematic-debugging` - Four-phase debugging framework
- `refactoring-code` - Behavior-preserving code improvements
- `optimizing-performance` - Measurement-driven optimization
- `handling-errors` - Error handling best practices
- `root-cause-tracing` - Trace bugs to their source
- `verification-before-completion` - Verify before claiming success
- `writing-plans` - Create detailed implementation plans
- `executing-plans` - Execute plans in controlled batches
- `condition-based-waiting` - Replace race conditions with polling

### agent-skills

Meta skills for working with Claude Code itself. Create custom skills, dispatch parallel agents, and visualize systems.

**Skills:**

- `creating-claude-skills` - Best practices for authoring skills
- `using-superpowers` - Mandatory workflows for finding and using skills
- `dispatching-parallel-agents` - Investigate independent problems concurrently
- `subagent-driven-development` - Execute plans with fresh subagents per task
- `visualizing-with-mermaid` - Create professional technical diagrams

### specialized-agents

Expert AI personas for complex work requiring deep expertise.

**Agents:**

- `@architect` - System design and architectural planning with diagrams
- `@code-reviewer` - Comprehensive PR/MR reviews enforcing standards
- `@documentation-writer` - Clear, practical documentation

**Reference Templates:**

- ADR (Architecture Decision Record)
- PRD (Product Requirements Document)
- Technical Design Document

## Usage Examples

### Typical Workflows

**Fix failing tests:**

```bash
/test
# If complex, escalate:
@skills/systematic-debugging
```

**Review before merge:**

```bash
/review
git add .
/commit
```

**Optimize performance:**

```bash
/optimize src/components/DataTable.tsx
# For deep analysis:
@skills/optimizing-performance
```

**Plan a feature:**

```bash
@architect I need to add real-time notifications. We have 10k concurrent users.
# Then create a plan:
@skills/writing-plans
```

**Clean up legacy code:**

```bash
/explain src/legacy/payment-processor.js
@skills/refactoring-code
```

### Understanding the System

**Commands vs Skills vs Agents:**

- **Commands** (`/command-name`) are quick keyboard shortcuts for routine tasks
- **Skills** (`@skills/skill-name`) are reusable workflows that guide specific development patterns
- **Agents** (`@agent-name`) are expert personas for complex, multi-step work

Use commands for quick actions, skills for following proven patterns, and agents when you need specialized expertise.

## Customization

All plugins are just markdown files organized in directories. Want to customize? Edit them directly in `~/.claude/plugins/`.

### Creating Your Own Command

Add a markdown file to `~/.claude/plugins/core-workflow/commands/`:

```markdown
---
description: Your command description
argument-hint: "[optional-arg]"
model: sonnet
allowed-tools: Bash, Read
---

Your command instructions here.
```

### Creating Your Own Skill

Add a markdown file to a skills directory in any plugin:

```markdown
---
name: my-skill
description: What this skill does
---

# Skill Instructions

Your skill workflow here.
```

### Creating Your Own Agent

Add a markdown file to `~/.claude/plugins/specialized-agents/agents/`:

```markdown
---
name: my-agent
description: Expert at specific domain
tools: Read, Grep, Glob, Bash
model: sonnet
color: blue
---

Your agent personality and workflow here.
```

## Project Structure

```
~/.claude/
├── CLAUDE.md              # Communication guidelines (copy here manually)
└── plugins/
    ├── core-workflow/
    │   ├── commands/      # 8 development commands
    │   └── hooks/         # Session automation
    ├── development-skills/
    │   └── skills/        # 11 development patterns
    ├── agent-skills/
    │   └── skills/        # 5 meta skills
    └── specialized-agents/
        ├── agents/        # 3 expert agents
        └── references/    # Document templates
```

## Installation Order Matters

Install in this order for best results:

1. **agent-skills** - Provides foundational meta capabilities
2. **development-skills** - Adds core development patterns
3. **core-workflow** - Enables command shortcuts (depends on skills)
4. **specialized-agents** - Optional, for architecture and reviews

## Tips

**Start simple:** Install core-workflow first if you just want commands. Add other plugins as needed.

**Commands accept arguments:** Most commands work with optional parameters.

```bash
/test pytest tests/unit
/explain AuthController
/optimize src/components/
```

**Skills are for learning:** Invoke a skill to understand a pattern, then apply it.

```bash
@skills/writing-tests
# Follow the guidance to write tests
```

**Agents need context:** Give agents rich context for better results.

```bash
# Vague
@architect help with authentication

# Better
@architect We need OAuth2 + JWT authentication for a React SPA with Node backend. 50k users.
```

**Check diagnostics:** Use `/quick-fix` before committing to clean up lint errors and type issues.

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
