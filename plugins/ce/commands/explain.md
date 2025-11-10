---
description: Explain code in detail with examples
argument-hint: "<file-path-or-concept>"
allowed-tools: Read, Grep, Glob
---

Provide a detailed explanation of code or concepts in the codebase.

Arguments:

- `$ARGUMENTS`: File path, function name, or concept to explain

Process:

1. If a file path is provided, read and explain the file
2. If a function/class name is provided, search for it and explain its implementation
3. If a concept is provided, find examples in the codebase and explain the pattern

Your explanation should include:

- **Purpose**: What does this code do and why?
- **Key Components**: Main functions, classes, or modules involved
- **Data Flow**: How data moves through the code
- **Dependencies**: What does this rely on?
- **Usage Examples**: How is this typically used?
- **Gotchas**: Any tricky parts or edge cases to be aware of

Tailor the depth of explanation to the complexity of the code.
