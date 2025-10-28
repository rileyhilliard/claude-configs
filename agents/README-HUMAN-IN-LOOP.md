# Human-in-the-Loop Agents 🤝

**5 specialized agents that work in ANY codebase with intelligent preflight wizards and selective decision tracking.**

These agents were designed to be **truly general-purpose** - they don't require any special project structure, sessions directories, or pre-configuration. They adapt to whatever repository they're working in.

---

## The Agents

### 1. codebase-explorer 🔵

**What it does**: Documents architecture, data flows, and dependencies by exploring your codebase.

**Why it was designed**: 
When joining a new codebase or investigating an unfamiliar system, developers waste hours trying to piece together how things work. This agent systematically explores code to create comprehensive architectural documentation that explains not just *what* the code does, but *why* it works that way.

**Design philosophy**:
- **Narrative-first**: Explains flows as stories, not just lists of functions
- **Reference-only**: Points to code locations, never copies code snippets
- **Context-aware**: Understands that developers need to know WHY, not just WHAT

**What makes it special**:
- **Two invocation modes**: Full context (immediate) or minimal context (wizard)
- **Smart autodetection**: Finds relevant files using Grep/Glob without manual specification
- **Depth levels**: Quick overview, medium detail, or deep dive
- **No dependencies**: Works without git, sessions, or special directories

**Use cases**:
- Onboarding new team members
- Investigating legacy code
- Understanding authentication flows
- Documenting microservice interactions
- Creating ADRs (Architecture Decision Records)

**Example invocations**:

```
# Minimal context - agent will ask for details
@codebase-explorer Explore the authentication system

# Full context - immediate execution
@codebase-explorer Explore src/auth/ focusing on JWT token 
validation, write deep documentation to docs/auth-architecture.md
```

**Does NOT log to major_decisions.json** - Routine documentation work.

---

### 2. session-discovery-logger 🟣

**What it does**: Captures surprising discoveries, gotchas, and hidden behaviors found during work sessions.

**Why it was designed**:
The most valuable knowledge in a codebase isn't in the documentation - it's in developers' heads. This agent captures those "aha!" moments, unexpected behaviors, and hard-won insights that save future developers hours of frustration.

**Design philosophy**:
- **Surprise-focused**: Only logs genuinely unexpected findings
- **Impact-oriented**: Explains why discoveries matter for future work
- **Pattern recognition**: Automatically detects discovery language in conversations

**What makes it special**:
- **Conversation analysis**: Parses conversation for discovery patterns ("Turns out...", "Unexpectedly...")
- **Quality filter**: Distinguishes real discoveries from routine observations
- **Preview and select**: Shows findings, lets user choose which to log
- **Future-focused**: Documents implications for future developers

**Use cases**:
- Debugging sessions that reveal hidden behaviors
- Discovering undocumented system quirks
- Finding performance characteristics not in docs
- Uncovering security implications
- Learning how legacy systems actually work

**Example invocations**:

```
# Log discoveries from current session
@session-discovery-logger Capture the findings from this 
authentication debugging session

# Specify output location
@session-discovery-logger Log discoveries to 
docs/discoveries/auth-tokens-2025-10.md
```

**What qualifies as a discovery**:
- ✅ "Token cache has 5min TTL (undocumented)" - YES
- ✅ "This function mutates global state unexpectedly" - YES
- ❌ "Fixed a typo in variable name" - NO
- ❌ "Chose to use async/await" - NO (implementation choice)

**Does NOT log to major_decisions.json** - Internal learning, not project decisions.

---

### 3. work-session-summarizer 🟢

**What it does**: Transforms work sessions into polished worklogs, commit messages, or session notes.

**Why it was designed**:
At the end of a productive session, developers face the tedious task of summarizing what they accomplished. This agent extracts completed work, decisions made, and problems solved from conversation context, formatting it professionally.

**Design philosophy**:
- **Three formats**: Worklog (chronological), commit message (conventional), or session notes (narrative)
- **Git-aware**: Automatically detects changed files to include in summaries
- **Decision capture**: Extracts not just what was done, but why

**What makes it special**:
- **Automatic git integration**: Detects `git diff` and `git status` changes
- **Multiple format support**: Choose output style for different use cases
- **Implication extraction**: Identifies how work affects the project
- **✅ LOGS DECISIONS**: Automatically logs to major_decisions.json

**Use cases**:
- Daily standup preparation
- Creating commit messages from work sessions
- Maintaining project work logs
- Documenting sprint progress
- Preparing handoff documentation

**Example invocations**:

```
# Worklog format (default)
@work-session-summarizer Create a worklog entry for today

# Commit message format
@work-session-summarizer Generate a commit message for 
the authentication changes

# Session notes (narrative)
@work-session-summarizer Write session notes about the 
Redis caching implementation
```

**Output formats**:

**Worklog**:
```markdown
## Work Log - 2025-10-28

### Completed
- Implemented JWT authentication
- Added Redis caching layer

### Decisions
- Chose 24h token TTL (security vs UX balance)
- Cache tokens for 5min (performance vs revocation delay)

### Files Changed
M  src/auth/jwt_handler.py
A  tests/test_auth.py
```

**Commit Message**:
```
feat: implement JWT authentication with Redis caching

- Added JWT token generation and validation
- Integrated Redis caching for performance
- Created comprehensive test suite

Breaking changes:
- Requires JWT_SECRET environment variable
- Redis must be available for optimal performance

Files changed:
M  src/auth/jwt_handler.py (+89, -0)
A  tests/test_auth.py (+156, -0)

Co-authored-by: Claude <claude@anthropic.com>
```

**✅ LOGS TO major_decisions.json** - Work summaries are significant project documentation.

---

### 4. documentation-updater ⚫

**What it does**: Updates project documentation to match current code implementation.

**Why it was designed**:
Documentation drifts. Code changes, but docs don't. This agent keeps documentation synchronized with reality by detecting changed code and updating relevant docs - without copying code snippets into documentation.

**Design philosophy**:
- **Reference, never duplicate**: Uses file paths with line numbers, never code snippets
- **Structure-aware**: Adapts to services, modules, or single-purpose repos
- **Git-integrated**: Detects recent changes to know what needs updating
- **Preview-first**: Shows what will change before writing

**What makes it special**:
- **Multi-structure support**: Works with service-based, module-based, or single-purpose repos
- **Smart detection**: Finds CLAUDE.md, README.md, and module docstrings automatically
- **No code duplication**: Only references (file.py:lines), never snippets
- **Atomic updates**: Updates one section at a time with rollback capability

**Use cases**:
- Keeping CLAUDE.md files current
- Updating architecture documentation
- Syncing API documentation with code
- Maintaining module docstrings
- Refreshing integration point docs

**Example invocations**:

```
# Update based on recent changes
@documentation-updater Sync documentation with recent 
authentication changes

# Update specific scope
@documentation-updater Update docs for the user service

# Full documentation refresh
@documentation-updater Review and update all project 
documentation
```

**Documentation patterns by repo type**:

**Service-based** (`services/auth/`, `services/user/`):
- Maintains `services/{name}/CLAUDE.md` per service
- Documents service boundaries and integration points

**Module-based** (`src/auth/`, `src/api/`):
- Root `CLAUDE.md` for architecture
- Module docstrings for Python/JS files

**Single-purpose** (one focused codebase):
- Comprehensive root `CLAUDE.md`
- Function/class docstrings

**Critical rule**: **NEVER includes code snippets**. Only references:
```markdown
✅ CORRECT:
- `src/auth/jwt.py:generate_token()` at line 45 - Generates JWT tokens

❌ WRONG:
\`\`\`python
def generate_token(user_id):
    return jwt.encode({'user_id': user_id}, SECRET)
\`\`\`
```

**Does NOT log to major_decisions.json** - Routine maintenance work.

---

### 5. code-quality-reviewer 🔴

**What it does**: Reviews code changes for security vulnerabilities, performance issues, and consistency with project patterns.

**Why it was designed**:
Code reviews catch bugs, but they're time-consuming and require expertise across security, performance, and architecture. This agent provides expert review across all these dimensions, categorizing findings by severity and providing actionable fixes.

**Design philosophy**:
- **Severity-based**: Critical (blocks deployment), Warnings (should fix), Notes (optional)
- **Pattern-aware**: Compares against existing project conventions
- **Specific and actionable**: Points to exact lines with concrete fix suggestions
- **Context-respectful**: Doesn't impose external "best practices" if project has different conventions

**What makes it special**:
- **Multi-scope review**: Can review diffs, staged changes, PRs, or specific files
- **Comprehensive checklists**: Security, performance, consistency, readability, tests
- **Project-aware**: Understands and respects existing patterns
- **✅ LOGS DECISIONS**: Automatically logs reviews to major_decisions.json

**Use cases**:
- Pre-commit reviews
- Security audits
- Performance investigations
- Consistency checks before merging
- Identifying deployment blockers

**Example invocations**:

```
# Review staged changes
@code-quality-reviewer Review staged changes for security 
and performance

# Review specific files
@code-quality-reviewer Review src/auth/jwt_handler.py 
focusing on security

# Comprehensive review
@code-quality-reviewer Review all changes in this PR, 
focus on all areas
```

**Review output format**:

```markdown
# Code Review - 2025-10-28

## Summary
Reviewed authentication (3 files, 289 lines). Found 1 critical 
issue, 2 warnings, 1 note.

## 🔴 Critical Issues (1)

### 1. Hardcoded Secret Key
**File**: `src/auth/jwt_handler.py:12`
**Issue**: JWT secret hardcoded in source code
**Impact**: SECURITY RISK - Anyone with code access can forge tokens
**Fix**: Move to environment variable
**Block deployment**: YES - Fix immediately

## 🟡 Warnings (2)

### 1. N+1 Query Problem
**File**: `src/auth/middleware.py:45-52`
**Issue**: Database queried in loop for token validation
**Impact**: Slow performance with many requests
**Existing Pattern**: See `core/db.py:89` for batch query pattern
**Priority**: High - Fix before production
```

**Review focus areas**:

| Focus | Checks |
|-------|--------|
| **Security** | Exposed secrets, SQL injection, XSS, auth bypasses, path traversal |
| **Performance** | N+1 queries, memory leaks, blocking I/O, missing indexes |
| **Consistency** | Matches project patterns, similar error handling, naming conventions |
| **Readability** | Clear names, appropriate comments, logical structure |
| **Tests** | Edge cases, error scenarios, realistic test data |

**✅ LOGS TO major_decisions.json** - Reviews identify deployment blockers and quality issues.

---

## Key Design Decisions

### Why Two Invocation Modes?

**The problem**: Agents either require too much setup (annoying) or make too many assumptions (dangerous).

**The solution**: 
- **Full context mode**: When user provides all details, execute immediately with confirmation
- **Minimal context mode**: When details missing, run preflight wizard to gather requirements

This gives power users speed while guiding new users through the process.

### Why Selective Decision Logging?

**The problem**: Logging everything creates noise. Logging nothing loses valuable history.

**The solution**: Only log **significant decisions**:
- ✅ Work summaries (document project progress)
- ✅ Code reviews (identify deployment blockers)
- ❌ Explorations (routine work)
- ❌ Discoveries (internal learning)
- ❌ Doc updates (maintenance)

This keeps major_decisions.json focused on decisions that matter for project governance.

### Why No Dependencies?

**The problem**: Most agents assume specific project structures (sessions/, .claude/state/, etc.), making them unusable in most codebases.

**The solution**: 
- Detect and adapt to ANY repository structure
- Git is optional (graceful fallback)
- No magic directories or files required
- Work anywhere, immediately

### Why Reference-Only Documentation?

**The problem**: Code snippets in docs become outdated immediately, creating confusion.

**The solution**:
- Only reference file locations with line numbers
- Never copy code into documentation
- Keep docs in sync by pointing to source of truth (the code)

---

## Decision Tracking

### Auto-Creation on First Use

When work-session-summarizer or code-quality-reviewer runs for the first time, major_decisions.json is created automatically:

```
📝 Creating major_decisions.json for decision tracking...
   This file logs significant decisions (work summaries, code reviews).

✓ Created major_decisions.json at /path/to/project/major_decisions.json
  View decisions with: cat major_decisions.json | jq
```

### What Gets Logged

**Example decision log entry**:

```json
{
  "timestamp": "2025-10-28T15:30:45Z",
  "session_id": "a7f2c4b1-8d3e-4fa9-b2e7-1c5d9f3a6e8b",
  "category": "work_summary",
  "decision": "Documented authentication implementation work",
  "context": {
    "format": "worklog",
    "work_completed": [
      "Implemented JWT authentication",
      "Added Redis caching layer"
    ],
    "decisions_made": [
      "Chose PyJWT over custom implementation",
      "Set token TTL to 24 hours"
    ],
    "files_changed": [
      "src/auth/jwt_handler.py",
      "src/auth/middleware.py"
    ]
  },
  "implications": [
    "Authentication pattern established for project",
    "Redis dependency added to infrastructure"
  ]
}
```

---

## Installation

See main README.md for installation instructions.

---

## Compatibility

✅ **100% compatible with claude-configs format**  
✅ **Works alongside existing commands and agents**  
✅ **No conflicts with existing configurations**  
✅ **Requires Python 3 for decision logging hook**

---

## Testing

```bash
# Download and run test suite
curl -O https://raw.githubusercontent.com/Tar-ive/claude-configs/main/scripts/test-agents.sh
chmod +x test-agents.sh
./test-agents.sh
```

---

## License

MIT License - These agents are free to use, modify, and share.

---

## Contributing

Found a bug? Have an improvement? PRs welcome!

Built for the Claude Code community. 🤝
