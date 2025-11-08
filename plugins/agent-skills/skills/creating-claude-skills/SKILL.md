---
name: creating-claude-skills
description: Applies best practices when authoring Claude skills, including proper YAML frontmatter structure, effective descriptions, progressive disclosure patterns, and testing strategies. Use when creating or modifying SKILL.md files.
version: 1.0.0
---

# Creating Claude Skills

Apply these best practices when authoring Claude skills to ensure they are discoverable, maintainable, and effective.

## YAML Frontmatter Requirements

Every SKILL.md must start with YAML frontmatter containing:

**Required fields:**

- `name`: Maximum 64 characters, lowercase letters/numbers/hyphens only, no XML tags, no reserved words ("anthropic", "claude")
- `description`: Maximum 1024 characters, non-empty, no XML tags, describes what the skill does AND when to use it

## Naming Conventions

Use gerund form (verb + -ing) for consistency:

**Good examples:**

- `processing-pdfs`
- `analyzing-spreadsheets`
- `managing-databases`
- `testing-code`
- `writing-documentation`

**Avoid:**

- Vague names: `helper`, `utils`, `tools`
- Overly generic: `documents`, `data`, `files`
- Reserved words: `anthropic-helper`, `claude-tools`

## Writing Effective Descriptions

The description enables skill discovery. Claude uses it to select the right skill from potentially 100+ available skills.

**Critical rules:**

- Always write in third person (injected into system prompt)
- Be specific and include key terms/triggers
- Describe WHAT the skill does AND WHEN to use it
- Include context clues for automatic invocation

**Good:** "Processes Excel files and generates reports when working with .xlsx files"
**Avoid:** "I can help you process Excel files"
**Avoid:** "You can use this to process Excel files"

## Progressive Disclosure Structure

Skills use a three-level progressive disclosure system to minimize token usage:

1. **Metadata (name/description)**: Claude scans this first to determine relevance
2. **Markdown body**: Loaded if skill is selected, contains instructions and examples
3. **Referenced files**: Only loaded when needed for execution

Keep the main SKILL.md under 4,000 words (~500 lines). When it becomes unwieldy, split content into separate files and reference them via `~/.claude/skills/<skill>/references/<the-reference>.md`.

## Content Guidelines

**Use imperative language:**

- "Analyze code for security vulnerabilities"
- "Generate unit tests following the project's testing patterns"
- "Format communications using company templates"

**Include examples:**

- Show example inputs and expected outputs
- Demonstrate the success criteria
- Provide edge cases when relevant

**Balance freedom vs. constraint:**

- High constraint: Database migrations, security-critical operations (provide exact steps)
- High freedom: Code reviews, creative tasks (provide general direction)

## Testing Strategy

**Before uploading:**

1. Verify all referenced files exist
2. Check description accurately reflects triggers
3. Test with example prompts
4. Review for clarity and completeness

## Best Practices

**Keep skills focused:** Create separate skills for different workflows. Multiple focused skills compose better than one large skill.

## Skill vs. Agent Decision

A capability should be a **skill** when:

- You want Claude to automatically apply it when relevant
- It provides reusable expertise across many conversations
- It enhances workflows without needing isolation
- It's expertise, not a complex task requiring separate context

A capability should be an **agent** when:

- It handles substantial tasks with significant working context
- It benefits from isolated workspace to avoid cluttering main thread
- It processes large volumes (full codebase review, complete documentation generation)
- It runs in parallel or requires deliberate invocation

## Example Skill Structure

```
---
name: enforcing-typescript-standards
description: Applies company TypeScript/React code conventions, naming patterns, and formatting standards when writing or reviewing code. Use for all TypeScript development work.
---

# TypeScript Standards Enforcement

Apply these standards to all TypeScript code:

## Naming Conventions
- Use PascalCase for React components: `UserProfile`, `DataTable`
- Use camelCase for functions and variables: `getUserData`, `isLoading`
- Use UPPER_SNAKE_CASE for constants: `API_BASE_URL`

## Component Structure
- Prefer function components with hooks
- Extract custom hooks for reusable logic
- Use TypeScript interfaces for props

[Additional guidelines...]
```
