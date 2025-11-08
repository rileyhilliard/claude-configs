# Agent Skills

Meta skills for working with Claude agents, creating custom skills, dispatching parallel agents, and creating professional diagrams.

## What's Included

### Skills

- `using-abilities` - Mandatory workflow for finding and using skills (loaded automatically by core-workflow session hook)
- `creating-claude-skills` - Best practices for authoring skills with proper YAML frontmatter and progressive disclosure
- `dispatching-parallel-agents` - Dispatch multiple agents to investigate independent problems concurrently
- `subagent-driven-development` - Execute implementation plans with fresh subagents and code review gates
- `visualizing-with-mermaid` - Create professional, well-styled Mermaid diagrams for technical communication

## When to Use This Plugin

Install this plugin when you want to:

- Understand and leverage Claude's skill system effectively
- Create custom skills for your team or projects
- Dispatch parallel agents for independent debugging tasks
- Generate professional architecture diagrams and flowcharts
- Ensure consistent skill usage across sessions

The `using-abilities` skill is particularly important as it establishes the protocol for how Claude finds and uses all other skills.

## Dependencies

None. This plugin is standalone, but it's recommended by the `core-workflow` plugin.

The `core-workflow` plugin's session-start hook will automatically load the `using-abilities` skill if this plugin is installed.

## Installation

```bash
claude plugins install agent-skills
```

## Usage Examples

Create a new custom skill:

```
I need to create a skill for database migrations. Can you help me author it following best practices?
```

Dispatch parallel agents to debug multiple independent failures:

```
We have 5 test failures across different modules. Let's dispatch parallel agents to investigate each one.
```

Generate an architecture diagram:

```
Can you create a sequence diagram showing how the authentication flow works?
```

The `using-abilities` skill runs automatically at session start if you have the `core-workflow` plugin installed.
