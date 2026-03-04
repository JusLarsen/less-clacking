# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Personal macOS dotfiles repository that automates development environment setup: shell configuration, tool installation, git identity management, macOS preferences, and AI agent protocols. Supports multi-vendor AI agents (Claude and Gemini) with persistent memory.

## Commands

```bash
make lint              # Run all linters (shellcheck + shfmt + markdownlint)
make lint-shell        # Lint shell scripts only
make lint-markdown     # Lint markdown files (README.md and CLAUDE.md)
make format            # Auto-format shell scripts and markdown
make install-linters   # Install linting tools via Homebrew
```

Shell scripts use 2-space indentation with case indent (`shfmt -i 2 -ci`). Markdown linting disables line length (MD013) and fenced code language (MD040) rules.

## Architecture

### Installation Flow

`install.sh` is the entry point: Homebrew -> Brewfile packages -> macOS defaults -> Oh-My-Zsh -> development directory structure with per-directory git identity configs (symlinked via `ln -sf`) -> GPG setup -> Claude Code CLI -> rcup symlinks (including p10k.zsh) -> AI agent symlinks.

Dotfiles are symlinked via `rcup` (from rcm package). AI agent protocol files are symlinked from `AGENT_PROTOCOL.md` to both `~/.claude/CLAUDE.md` and `~/.gemini/GEMINI.md`.

### Git Identity System

Directory-based git identity selection via includeIf in `.gitconfig`:

- `~/development/personal/` -> `gitconfig.personal` (personal email + GPG key)
- `~/development/work/` -> `gitconfig.work` (work email + GPG key)
- `~/development/` -> `gitconfig.development` (fallback config)

### AI Agent System

`AGENT_PROTOCOL.md` defines the shared agent protocol (symlinked to both Claude and Gemini user-level configs). The `agents/` directory contains 7 specialized agent definitions: investigator, developer, code-reviewer, security-engineer, qa-specialist, software-architect, technical-writer. These get symlinked to `~/.claude/agents/` and `~/.gemini/agents/` via rcup.

### Shell Environment

`zshrc` detects VSCode terminal (`IN_VSCODE` flag) and conditionally loads Oh-My-Zsh only outside VSCode. Plugins: asdf, git. Powerlevel10k is sourced via `brew --prefix` with VSCode and `command -v brew` guards; p10k instant prompt is at the top of zshrc before any output. Zoxide is initialized via `eval` with `command -v` guard. `zprofile` contains aliases and path setup.

## Key Files

| File | Purpose |
| ------ | ------- |
| `install.sh` | Main setup script |
| `Brewfile` | Declarative Homebrew dependencies |
| `AGENT_PROTOCOL.md` | AI agent system spec (symlinked to ~/.claude/CLAUDE.md and ~/.gemini/GEMINI.md) |
| `agents/*.md` | Individual agent definitions |
| `tool-versions` | mise/asdf runtime versions (node 22.14.0, python 3.13.1, ruby 3.3.6) |
| `p10k.zsh` | Powerlevel10k prompt configuration |
| `scripts/setup-gpg.sh` | GPG key setup wizard |
| `.gitconfig` | Main git config with directory-based identity includes |

## Documentation Rules

When modifying code that makes existing documentation outdated (README.md, CLAUDE.md, etc.), update those docs in the same change. Keeping existing docs accurate is not "creating documentation" — it's part of the implementation.

## CI

GitHub Actions (`lint.yml`) runs `make lint` on PRs and pushes to `main`. Installs shellcheck, shfmt, and markdownlint-cli before running.
