# OpenCode setup

Personal OpenCode agents and instructions, with a snapshot of 37 skills from [mattpocock/skills](https://github.com/mattpocock/skills). The skills were installed on 2026-08-28; their original source paths and hashes are recorded in `skills-lock.json`. Upstream skill files are kept unchanged.

## Install on Linux / WSL

From the dotfiles repository:

```bash
bash opencode/install.sh
```

The installer copies rules and agents to `${XDG_CONFIG_HOME:-$HOME/.config}/opencode` and skills to `~/.agents/skills`. Changed existing files are backed up under `~/.local/state/dotfiles-opencode/backups`. It preserves unrelated files and model/provider configuration. Re-running it skips identical files.

The script checks for OpenCode on PATH or in ~/.opencode/bin. If absent, it uses curl and the official https://opencode.ai/install installer, which detects the OS and CPU. macOS, Linux and WSL are supported; run it inside WSL on Windows. Install curl first if missing. If OpenCode is managed by NVM, activate the corresponding Node version before running to avoid installing a second copy. Start a new shell/session after installation if needed. The official installer may update shell startup files to add OpenCode to PATH.

## Agents

- `developer`: Python APIs, Rust and React; select with Tab.
- `@docs-researcher`: official documentation research and cited notes.
- `@reviewer`: separate standards and specification review.
- `@rust-tutor`: Rust explanations and learning exercises.

Agents inherit your selected model. Skills load through the native skill tool; ask to load `grill-me`, `to-spec`, `tdd`, `diagnosing-bugs` or `code-review` by name.

In each actual project, load `setup-matt-pocock-skills` to configure its tracker, triage labels and domain docs. Claude-specific hooks/tools may require separate adaptation. Global instructions require explicit user authorization for commits, pushes and remote issue creation.

## Verify

```bash
opencode agent list
opencode debug skill
```

The initial setup was validated with OpenCode 1.18.35. The installer does not include dependencies, authentication, provider settings, databases, logs or caches.
