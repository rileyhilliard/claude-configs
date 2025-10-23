# Claude Code Configuration Repo ⚡

> Your personal arsenal of supercharged commands and specialized AI agents for Claude Code

## What's This All About?

This repository contains a carefully crafted Claude Code configuration that transforms your CLI experience from "pretty good" to "absolutely magical." Think of it as a power-up pack for your AI pair programmer.

**What you get:**

- **8 Custom Commands** - Lightning-fast shortcuts for common dev tasks
- **7 Specialized Agents** - Expert AI personas that excel at specific engineering challenges
- **Battle-tested workflows** - Proven patterns for debugging, reviewing, optimizing, and more

---

## Table of Contents

- [Quick Start](#quick-start) - Get up and running
- [What's Inside](#whats-inside) - Commands and agents overview
- [Usage Examples](#usage-examples) - Real-world scenarios
- [Customization](#customization--extension) - Build your own
- [Tips & Tricks](#tips--tricks) - Power user moves
- [Agent Personalities](#agent-personality-guide) - Know your specialists
- [FAQ](#faq) - Common questions

---

## Quick Start

### 1-Line Install

![Hacker Man](https://media.giphy.com/media/2vN0qPsqHOZISBxvEA/giphy.gif)

**Fresh install** (no existing config):

```bash
npm install -g @anthropic-ai/claude-code && git clone https://github.com/rileyhilliard/claude-configs.git ~/.claude
```

**Merge with existing config:**

```bash
git clone https://github.com/rileyhilliard/claude-configs.git /tmp/claude-configs && mkdir -p ~/.claude && cp -r /tmp/claude-configs/{commands,agents} ~/.claude/ && rm -rf /tmp/claude-configs
```

That's it! Start Claude Code with `claude` and your commands/agents are ready to use.

### Test It Out

```bash
# Start Claude Code in any project
claude

# Try these:
# Type "/" to see all commands
# Type "@" to see all agents
# Run: /explain README.md
```

**First time?** Try this progression: `/test` → `/explain some-file.js` → `/quick-fix` → `/review` → `@technical-architect help me plan X`

💡 **Remember:** Commands are for quick tasks, agents are for deep work. Escalate from commands to agents when needed.

## What's Inside

### Commands vs Agents: What's the Difference?

**Commands** (`/command-name`) are like quick keyboard shortcuts - they're fast, focused actions that get the job done right now. Use them for routine tasks you do all the time.

**Agents** (`@agent-name`) are like calling in a specialist - they're expert AI personas with deep knowledge, sophisticated workflows, and the patience to work through complex problems systematically. Use them when you need expertise and thoroughness.

---

### Custom Commands (`/command-name`)

Commands invoke Claude with specific tools and constraints for common dev tasks. They're your daily driver shortcuts.

| Command      | What It Does                                                | Usage Example                            |
| ------------ | ----------------------------------------------------------- | ---------------------------------------- |
| `/test`      | Runs tests and analyzes failures with detailed debugging    | `/test` or `/test npm run test:unit`     |
| `/explain`   | Breaks down code or concepts with examples and context      | `/explain src/utils/parser.ts`           |
| `/quick-fix` | Fixes IDE diagnostics, linting errors, and type issues fast | `/quick-fix`                             |
| `/debug`     | Launches the bug-hunter agent for systematic debugging      | `/debug authentication not working`      |
| `/optimize`  | Invokes performance-optimizer agent to find bottlenecks     | `/optimize src/components/DataTable.tsx` |
| `/refactor`  | Invokes refactor-specialist to improve code quality         | `/refactor src/legacy/user-service.js`   |
| `/review`    | Gets comprehensive code review from code-reviewer agent     | `/review`                                |
| `/commit`    | Analyzes staged changes and generates semantic commits      | `/commit`                                |

---

### Specialized Agents (`@agent-name`)

Agents are expert AI personas with specialized knowledge, custom workflows, and focused toolsets. Each agent has a distinct personality and approach to their domain.

| Agent                    | Color     | What They Do                                                         | Best For                                                                     |
| ------------------------ | --------- | -------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| `@bug-hunter`            | 🟠 Orange | Systematic debugging with hypothesis testing and root cause analysis | Tracking down elusive bugs, analyzing crashes, investigating race conditions |
| `@code-reviewer`         | 🔴 Red    | Comprehensive PR/MR review enforcing project standards               | Pre-merge reviews, ensuring quality, catching bugs before production         |
| `@documentation-writer`  | ⚫ Gray   | Writing clear, practical docs that people actually read              | API documentation, architecture docs, explaining complex systems             |
| `@performance-optimizer` | 🟡 Yellow | Data-driven performance analysis and targeted optimization           | Slow renders, memory leaks, large bundle sizes, API latency                  |
| `@refactor-specialist`   | 🔵 Blue   | Code restructuring that improves quality without changing behavior   | Reducing duplication, simplifying logic, improving maintainability           |
| `@technical-architect`   | 🔵 Blue   | System design and architectural planning with Mermaid diagrams       | Planning new features, evaluating technical approaches, writing ADRs         |
| `@test-writer`           | 🟢 Green  | Behavior-driven testing focused on integration and E2E tests         | Adding test coverage, writing maintainable tests, testing user workflows     |

## Usage Examples

### Real-World Scenarios

**Scenario 1: You broke the build and tests are failing**

```bash
# Run tests and get instant analysis
/test

# If failures are complex, bring in the specialist
@bug-hunter The user authentication tests are failing with "TypeError: Cannot read property 'token' of undefined"
```

**Scenario 2: Code review time**

```bash
# Make your changes, then get a review
/review

# Address any feedback, then stage and commit
git add .
/commit
```

**Scenario 3: Performance is terrible**

```bash
# Identify bottlenecks in a specific file
/optimize src/components/DataTable.tsx

# Or let the optimizer analyze everything
@performance-optimizer The dashboard takes 3+ seconds to load, can you find out why?
```

**Scenario 4: Planning a new feature**

```bash
# Get architectural guidance
@technical-architect I need to add real-time notifications to the app. Users should see updates instantly when data changes, and we have 10k concurrent users.

# Once planned, add comprehensive tests
@test-writer Create integration tests for the notification system following our testing patterns
```

**Scenario 5: Legacy code needs love**

```bash
# Explain what this gnarly code does
/explain src/legacy/payment-processor.js

# Then refactor it with expert guidance
@refactor-specialist This payment processor has grown to 800 lines with nested callbacks. Help me clean this up while keeping it working.
```

**Scenario 6: Quick fixes for the win**

```bash
# Auto-fix linting and type errors instantly
/quick-fix

# Or get help understanding a specific piece of code
/explain parseUserSession
```

## Customization & Extension

Want to create your own commands and agents? It's easier than you think!

### Adding Your Own Commands

Commands are perfect for tasks you do repeatedly. Create a new `.md` file in `~/.claude/commands/`:

**Example: `~/.claude/commands/changelog.md`**

```markdown
---
description: Generate a changelog from git commits
argument-hint: "[from-version]"
model: sonnet
allowed-tools: Bash, Read
---

Generate a changelog from git commits since the specified version (or last tag if not provided).

Process:

1. If $ARGUMENTS is provided, use it as the starting point
2. Otherwise, find the most recent git tag
3. Get all commits since that point with `git log`
4. Organize commits by type (feat, fix, docs, etc.)
5. Format as a markdown changelog

Output should be ready to paste into CHANGELOG.md.
```

**Usage:** `/changelog v1.2.0`

### Creating Custom Agents

Agents are for complex, multi-step work that requires expertise. Create a new `.md` file in `~/.claude/agents/`:

**Example: `~/.claude/agents/security-auditor.md`**

```markdown
---
name: security-auditor
description: Expert at identifying security vulnerabilities and suggesting fixes
tools: Read, Grep, Glob, Bash, TodoWrite
model: sonnet
color: purple
---

You are a security expert specializing in web application security.

## Focus Areas

- SQL injection and NoSQL injection
- XSS (Cross-Site Scripting) vulnerabilities
- CSRF protection
- Authentication and authorization flaws
- Insecure dependencies
- Sensitive data exposure
- Missing security headers

## Workflow

1. **Scan codebase** for common vulnerability patterns
2. **Analyze** authentication/authorization logic
3. **Check** dependencies for known vulnerabilities
4. **Review** API endpoints for proper validation
5. **Document findings** with severity ratings
6. **Suggest fixes** with code examples

Always explain the risk and impact of each vulnerability found.
```

**Usage:** `@security-auditor Review the authentication system for vulnerabilities`

### Command & Agent Syntax

**Frontmatter options:**

| Option          | Type         | Description                                |
| --------------- | ------------ | ------------------------------------------ |
| `description`   | String       | Brief description shown in help text       |
| `argument-hint` | String       | Hint for command arguments (commands only) |
| `name`          | String       | Agent identifier (agents only)             |
| `model`         | String       | `sonnet`, `opus`, or `haiku`               |
| `tools`         | String/Array | Tools the agent can use                    |
| `allowed-tools` | Array        | Tools the command can use                  |
| `color`         | String       | Agent color in UI (agents only)            |

**Available tools:**

- `Read`, `Edit`, `Write` - File operations
- `Grep`, `Glob` - Code search
- `Bash`, `BashOutput` - Shell execution
- `TodoWrite` - Task tracking
- `Task` - Invoke sub-agents
- `WebFetch`, `WebSearch` - Web access
- `mcp__*` - MCP server tools (IDE diagnostics, etc.)

## Project Structure

```
~/.claude/
├── commands/          # Quick command shortcuts
│   ├── test.md
│   ├── explain.md
│   ├── debug.md
│   └── ...
└── agents/           # Specialized AI personas
    ├── bug-hunter.md
    ├── code-reviewer.md
    ├── test-writer.md
    └── ...
```

## Tips & Tricks

### Combining Commands and Agents

Start with a command for quick analysis, then bring in an agent if you need deep expertise:

```bash
# Quick test run
/test

# If failures are complex, escalate to the specialist
@bug-hunter The payment integration tests are failing intermittently. I suspect a race condition.
```

### Chaining Workflows

Commands and agents work great in sequence:

```bash
# Development workflow
/refactor src/utils/validator.js
/test
/review
/commit

# Investigation workflow
/explain src/core/auth-middleware.ts
@security-auditor Check this authentication middleware for vulnerabilities
@test-writer Add comprehensive security tests for the auth middleware
```

### Pro Tips

**Commands accept arguments:** Most commands are smart about optional arguments.

```bash
/test pytest tests/unit          # Run specific test command
/explain AuthController          # Explain a concept or function
/optimize                        # Analyzes unstaged changes if no arg provided
/refactor src/legacy/           # Refactor a whole directory
```

**Agents understand context:** Give agents rich context for better results.

```bash
# Basic (works, but vague)
@bug-hunter fix the login bug

# Better (specific and contextual)
@bug-hunter The login flow returns 401 for valid credentials, but only in production. Local dev works fine. Started after we deployed the session refactor yesterday.
```

**Use git for scoping:** Many commands automatically work with git changes.

```bash
# These commands default to analyzing unstaged changes
/optimize      # Finds performance issues in your current work
/refactor      # Suggests improvements to uncommitted code
/review        # Reviews your uncommitted changes
```

**Check IDE diagnostics:** The `/quick-fix` command is magic for cleanup.

```bash
# Before committing, auto-fix common issues
/quick-fix

# It handles:
# - Import organization
# - Missing semicolons
# - Unused variables
# - Type errors
# - Formatting issues
```

## Agent Personality Guide

Each agent has a distinct approach to their domain. Understanding their "personality" helps you work with them more effectively.

**@bug-hunter** - The Detective

- Methodical and systematic
- Forms testable hypotheses before making changes
- Never guesses - always proves with evidence
- Documents findings thoroughly
- _Use when:_ You need root cause analysis, not just quick fixes

**@code-reviewer** - The Quality Guardian

- Direct and thorough
- Separates critical issues from nice-to-haves
- Compares against project standards
- Recognizes good work alongside criticism
- _Use when:_ You want honest feedback before merging

**@documentation-writer** - The Clarity Champion

- Hates obvious documentation
- Focuses on "why" over "what"
- Keeps things concise and practical
- Updates or deletes, never leaves stale docs
- _Use when:_ You need docs people will actually read

**@performance-optimizer** - The Pragmatist

- Measures first, optimizes second
- Asks "Is the complexity worth it?"
- Loves simplifying refactors that also improve speed
- Won't optimize just to optimize
- _Use when:_ You have real performance problems

**@refactor-specialist** - The Restructurer

- Preserves behavior religiously
- Requires good tests before refactoring
- Breaks large changes into safe incremental steps
- Questions their own abstractions
- _Use when:_ Code works but needs improvement

**@technical-architect** - The Designer

- Challenges assumptions openly
- Uses diagrams over words
- Defaults to battle-tested solutions
- Writes like a human, not a bot
- _Use when:_ Planning new systems or features

**@test-writer** - The Behavior Believer

- Integration tests over unit tests
- Tests what users see, not implementation
- Makes tests that survive refactoring
- Imports constants instead of hard-coding strings
- _Use when:_ You need tests that actually catch bugs

## FAQ

**Q: Do I need to use agents for everything?**
A: Nope! Commands are great for 90% of daily tasks. Only bring in agents when you need specialized expertise or complex multi-step work.

**Q: Can I modify the existing commands and agents?**
A: Absolutely! They're just markdown files. Edit them to match your workflow, add new tools, change the instructions - make them yours.

**Q: Which model should I use: Sonnet, Opus, or Haiku?**
A: Sonnet is the sweet spot for most tasks (fast + smart). Use Opus for complex reasoning or planning. Use Haiku when speed matters more than sophistication.

**Q: Can agents call other agents?**
A: Yes! Agents can use the `Task` tool to invoke other agents. Some commands (like `/debug`, `/optimize`, `/refactor`) are actually agent launchers.

**Q: How do I see available commands and agents?**
A: In Claude Code, type `/` to see commands or `@` to see agents. Both show autocomplete with descriptions.

**Q: Can I use this config in VS Code or Cursor?**
A: These are specifically for Claude Code (the CLI). VS Code and Cursor have their own extension systems. However, you could adapt the agent prompts for use in those tools.

## Contributing

Found a bug? Have a killer command or agent idea? Contributions are welcome!

**To contribute:**

1. Fork this repo
2. Create your feature branch (`git checkout -b feature/amazing-agent`)
3. Test your changes in your local `~/.claude` setup
4. Commit with good messages (`/commit` makes this easy!)
5. Submit a PR with details about what you've added

**Ideas for contributions:**

- New commands for common workflows
- Specialized agents for specific domains (mobile dev, DevOps, data science)
- Improvements to existing agent prompts
- Better examples in this README
- Integrations with popular tools

## Resources

- [Claude Code on NPM](https://www.npmjs.com/package/@anthropic-ai/claude-code)
- [Anthropic API Console](https://console.anthropic.com/)
- [Claude API Documentation](https://docs.anthropic.com/)
- [Model Context Protocol (MCP)](https://modelcontextprotocol.io/) - Extend Claude Code with custom tools

## License

MIT - Use it, share it, make it better!

---

**Happy coding!** May your bugs be few, your commits be meaningful, and your code reviews be kind. ✨
