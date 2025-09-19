# Less Clacking

[![Lint](https://github.com/JusLarsen/less-clacking/actions/workflows/lint.yml/badge.svg?branch=main)](https://github.com/JusLarsen/less-clacking/actions/workflows/lint.yml)

Personal dotfiles for consistent macOS development setup.

## Features

- **Terminal Environment**: Zsh with Oh-My-Zsh and Powerlevel10k
- **Development Tools**: Unified version management with asdf, modern Python tooling with uv
- **Git Identity Management**: Separate configurations for personal and work projects
- **macOS Preferences**: Sensible defaults for Finder, Dock, and other system preferences
- **Editor Setup**: Basic vim configuration for occasional use

## Tools & Technologies

| Category | Tool | Description |
|:---------|:-----|:------------|
| Package Management | [Homebrew](https://brew.sh/) | The macOS package manager |
| Dependency Management | [Brewfile](https://thoughtbot.com/blog/brewfile-a-gemfile-but-for-homebrew) | Declarative Homebrew dependencies |
| Dotfile Management | [RCM](https://github.com/thoughtbot/rcm) | Thoughtbot's RC file manager |
| Shell | [ZSH](http://www.zsh.org/) | Modern shell with extensive features |
| Shell Framework | [Oh-My-Zsh](https://ohmyz.sh/) | Framework for managing Zsh configuration |
| Shell Theme | [Powerlevel10k](https://github.com/romkatv/powerlevel10k) | Fast and customizable Zsh prompt |
| Window Management | [Hammerspoon](https://www.hammerspoon.org/) | Powerful automation tool for macOS |
| Version Management | [asdf](https://asdf-vm.com/) | Unified runtime version manager for all languages |
| Python Development | [uv](https://docs.astral.sh/uv/) | Fast Python package and project manager |

## Installation

```bash
git clone git@github.com:JusLarsen/less-clacking.git ~/.dotfiles
bash ~/.dotfiles/install.sh
```

This installs Homebrew packages, configures shell/macOS preferences, and links dotfiles.

## Repository Structure

The `.dotfiles` directory contains install scripts and files that will be symlinked into our home directory.

```
.dotfiles/
├── README.md              # This documentation
├── CLAUDE.md              # AI assistant guidelines
├── Makefile               # Linting and formatting commands
├── install.sh             # Main installation script
├── Brewfile               # Homebrew dependencies
├── .github/
│   └── workflows/
│       └── lint.yml       # GitHub Actions linting workflow
├── claude/
│   └── agents/            # Claude agent configurations
│       ├── code-reviewer.md
│       ├── developer.md
│       ├── investigator.md
│       ├── qa-specialist.md
│       ├── security-engineer.md
│       └── software-architect.md
├── scripts/
│   └── setup-gpg.sh       # GPG configuration automation
├── gitconfig              # Main git configuration
├── gitconfig.development  # Shared development settings
├── gitconfig.personal     # Personal git identity
├── gitconfig.work         # Work git identity
├── gitignore              # Global git ignore rules
├── zshrc                  # Zsh shell configuration
├── zprofile               # Zsh profile settings
├── vimrc                  # Vim editor configuration
├── p10k.zsh               # Powerlevel10k theme
├── tool-versions          # asdf version specifications
└── hammerspoon/           # Window management scripts
```

## Installed Structure

After installation, your development environment uses directory-based git identity management:

```
~/
├── .dotfiles/             # This repository (cloned)
├── .claude/               # Claude agent configurations
├── .gitconfig             # Symlinked from .dotfiles/gitconfig
├── .zshrc                 # Symlinked from .dotfiles/zshrc
├── .vimrc                 # Symlinked from .dotfiles/vimrc
├── .hammerspoon/          # Symlinked from .dotfiles/hammerspoon/
└── development/           # Main development directory
    ├── personal/          # Personal projects
    │   └── .gitconfig     # Uses justin@larsen.dev
    └── work/              # Work projects
        └── .gitconfig     # Uses jlarsen@traeger.com
```

## Git Identity Management

This dotfiles repository implements a directory-based git identity system to automatically use the correct name, email, and signing key based on the location of your repositories.

Directory-based git configuration automatically uses the correct identity:

- `~/development/personal/` - Uses `justin@larsen.dev` email
- `~/development/work/` - Uses `jlarsen@traeger.com` email

### GPG Signing

Commits are configured to be signed with GPG for additional security and verification. The `gpgsign = true` setting is enabled in the development configuration.

### Setting Up a New Machine

To configure git identities on a new machine:

1. Clone this repository and run the install script:

   ```bash
   git clone git@github.com:JusLarsen/less-clacking.git ~/.dotfiles
   bash ~/.dotfiles/install.sh
   ```

2. Import or generate your GPG keys:

   ```bash
   # Import existing key (NEVER email private keys)
   gpg --import /path/to/private-key.asc
   # Or generate new
   gpg --full-generate-key
   ```

3. Run the automated setup:

   ```bash
   ./scripts/setup-gpg.sh
   ```

   This configures GPG signing for both personal and work identities automatically.

4. Test your configuration:

   ```bash
   # Navigate to a personal project and verify git config
   cd ~/development/personal/your-project
   git config --get user.email  # Should show personal email
   git config --get user.signingkey  # Should show your GPG key ID
   
   # Navigate to a work project and verify git config
   cd ~/development/work/your-project
   git config --get user.email  # Should show work email
   git config --get user.signingkey  # Should show your GPG key ID
   ```

### Security Notes

- Never store private GPG keys in repositories
- Use strong passphrases and consider hardware security keys
- Back up keys to secure, encrypted locations

## Python Development

This dotfiles configuration uses **uv** for fast, modern Python development alongside **asdf** for version management.

Uses **uv** - a fast Python package manager (10-100x faster than pip/poetry) that handles versions, virtual environments, and dependencies with `pyproject.toml` and lock files.

### Python Development Workflow

1. **Project Setup** (uv handles Python installation automatically):

   ```bash
   cd ~/development/personal/my-project
   echo "3.13.1" > .python-version  # Matches global asdf version
   uv init
   uv add fastapi requests pytest
   ```

2. **Development**:

   ```bash
   uv run python main.py          # Run Python scripts
   uv run pytest                  # Run tests
   uv add --dev black ruff        # Add development dependencies
   uv sync                        # Install/sync all dependencies
   ```

3. **Environment Management**:

   ```bash
   uv venv                        # Create virtual environment
   source .venv/bin/activate      # Activate (or let uv handle it)
   uv pip list                    # List installed packages
   ```

To migrate existing projects: `uvx migrate-to-uv`

## Version Management

This configuration uses **asdf** as the unified version manager for all programming languages, replacing multiple version managers (nvm, pyenv, chruby) with a single tool.

### Supported Languages

Languages are managed through `.tool-versions` files:

```bash
# Global versions (in ~/.tool-versions)
nodejs 22.14.0
python 3.13.1  
ruby 3.3.6

# Project-specific versions (in your project/.tool-versions)
nodejs 20.10.0
python 3.12.0
```

### Common Commands

```bash
# Install a language runtime
asdf install nodejs 22.14.0
asdf install python 3.13.1
asdf install ruby 3.3.6

# Set global default versions
asdf global nodejs 22.14.0
asdf global python 3.13.1
asdf global ruby 3.3.6

# Set project-specific version
cd ~/development/personal/my-project
asdf local nodejs 20.10.0

# List available versions
asdf list all nodejs
asdf list all python

# List installed versions
asdf list nodejs
asdf list python
```

### Language-Specific Setup

- **Python**: Use `uv` for package management (see Python Development section)
- **Node.js**: Use `npm` or your preferred package manager
- **Ruby**: Use `gem` and `bundle` for dependency management

## Customization

- **Shell**: Edit `~/.zshrc` or `~/.zprofile`
- **Git**: Edit `~/.gitconfig` or the specific configs in development directories
- **Packages**: Edit `~/.dotfiles/Brewfile` and run `brew bundle install`
- **Vim**: Edit `~/.vimrc`
- **OS Preferences**: Add to `install.sh` (macOS section)

## Maintainer

| Name | GitHub | Email | Role |
|:-----|:-------|:------|:-----|
| Justin Larsen | [`JusLarsen`](https://github.com/JusLarsen) | [justin@larsen.dev](mailto://justin@larsen.dev) | Sentient Meat |
