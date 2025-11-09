---
description: Comprehensive code review using the code-reviewer agent
allowed-tools: Bash, Task, AskUserQuestion
---

Invoke the code-reviewer agent to perform a comprehensive code review.

Steps:

1. Check git status to see if there are uncommitted changes
2. Check current branch name
3. Determine what to review:
   - If uncommitted changes exist: Review uncommitted changes
   - If no uncommitted changes exist:
     - Check if on a feature branch (not main/master/develop)
     - Suggest reviewing all changes in current branch against main (or upstream branch)
     - Ask user what should be reviewed
4. Invoke the code-reviewer agent with appropriate instructions
