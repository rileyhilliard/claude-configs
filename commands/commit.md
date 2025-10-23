---
description: Create a well-formatted git commit for current changes
model: sonnet
allowed-tools: Bash
---

Create a git commit for the current staged changes with a well-crafted commit message.

Process:

1. Run `git status` to see what's staged
2. Run `git diff --staged` to review the changes
3. Analyze the changes and draft a commit message:
   - First line: Concise summary (50 chars max)
   - Blank line
   - Body: Explain WHY the changes were made (wrap at 72 chars)
   - Include context about what problem this solves
4. Show the proposed commit message to the user
5. Create the commit with the message

Do not add attribution footers to commit messages:

```
🤖 Generated with Claude Code
Co-Authored-By: Claude
```

**Commit Message Format:**

First, check recent commits with `git log -10 --oneline` to match the project's existing style.

If no clear pattern exists or the existing commits are poorly formatted, use **Conventional Commits** format:

```
<type>(<optional scope>): <description>

[optional body]

[optional footer(s)]
```

**Common Types:**
- `feat`: New feature for the user
- `fix`: Bug fix
- `docs`: Documentation only changes
- `style`: Code style changes (formatting, semicolons, etc.)
- `refactor`: Code change that neither fixes a bug nor adds a feature
- `perf`: Performance improvement
- `test`: Adding or updating tests
- `build`: Changes to build system or dependencies
- `ci`: CI/CD configuration changes
- `chore`: Other changes that don't modify src or test files
- `revert`: Reverts a previous commit

**Style Guidelines:**
- **Imperative mood**: Write as commands (e.g., "Add feature" not "Added feature")
- Think: "If applied, this commit will ___"
- **Subject line**: 50 characters max, no period at end
- **Body**: Wrap at 72 characters, explain WHAT and WHY (not HOW)
- **Breaking changes**: Add `!` after type (e.g., `feat!: redesign API`)

**Examples:**
```
feat(auth): add OAuth2 authentication support

Implements OAuth2 flow to allow users to sign in with third-party
providers. This resolves the long-standing request for social login.

Closes #123
```

```
fix: prevent race condition in user session handling

The session handler was not properly locking shared resources,
causing intermittent authentication failures under high load.
```
