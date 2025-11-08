# Specialized Agents

Specialized agents for technical architecture, code review, and documentation writing, plus reference templates for ADRs, PRDs, and technical designs.

## What's Included

### Agents
- `architect` - Technical design and architecture planning with system diagrams
- `code-reviewer` - Comprehensive code review following best practices
- `documentation-writer` - Write clear, practical documentation without buzzwords

### Reference Templates
- `adr.md` - Architecture Decision Record template
- `prd.md` - Product Requirements Document template
- `technical-design.md` - Technical Design Document template

## When to Use This Plugin

Install this plugin when you need:
- Architectural guidance and system design review
- Thorough code reviews before merging
- Help writing clear, well-structured documentation
- Templates for technical decision-making and planning

These agents are specialized for specific tasks and provide focused expertise beyond general development workflows.

## Dependencies

None. This plugin is standalone.

The reference templates can be used independently or in conjunction with the agents.

## Installation

```bash
claude plugins install specialized-agents
```

## Usage Examples

Get architectural guidance:
```
I need to design a caching layer for our API. Can you help me think through the architecture?
```
(The architect agent will be invoked automatically)

Request a code review:
```
/review
```
(If you have core-workflow installed, or invoke the code-reviewer agent directly)

Write documentation:
```
I need a README for our authentication service that explains how to integrate it.
```
(The documentation-writer agent will help)

Use a template for decision making:
```
Can you help me create an ADR for switching from REST to GraphQL?
```
(The agent will use the ADR template as reference)
