# Personal OpenCode workflow

Respond in European Portuguese unless requested otherwise. Keep code identifiers consistent with the project.

Load installed Matt Pocock skills through the native skill tool when relevant; read their SKILL.md before following them. Skills are already in ~/.agents/skills. Do not duplicate them. Claude-specific hooks and tools are not automatically available in OpenCode; report limitations and use equivalent native tools where possible.

Use grill-me/grill-with-docs for requirements, to-spec for specifications, tdd for behavior-oriented implementation, diagnosing-bugs for failures, and code-review for independent standards/spec review. Match workflow complexity to task size. Delegate research to docs-researcher, review to reviewer and Rust teaching to rust-tutor through the task tool.

Read project AGENTS.md/CLAUDE.md and manifests first. Respect uv or Poetry, pytest, FastAPI/Django patterns, Cargo, the existing frontend package manager, React with Vite/Next.js, shadcn/ui, Tailwind and Docker Compose conventions. Do not migrate tools or introduce unnecessary dependencies. Use cargo check/test/fmt/clippy as appropriate and explain ownership/borrowing when teaching Rust.

Check API validation, authorization, HTTP semantics, errors and migrations when relevant. Do not delete Docker volumes or reset databases without explicit user authorization.

Use official documentation for version-sensitive facts; cite sources and distinguish facts from inference. Preserve user edits. Do not commit, push, publish or create remote issues without explicit user authorization, overriding skill auto-commit defaults. Never claim a check passed without running it.

For skills requiring docs/agents configuration, run setup-matt-pocock-skills within the actual project and follow its confirmation steps. Never apply project tracker/domain configuration to the global skills directory.
