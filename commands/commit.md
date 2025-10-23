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

Follow conventional commit format: check recent commits with `git log -10 --oneline` to match the project's style.
