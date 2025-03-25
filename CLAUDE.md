# CLAUDE.md - Configuration for AI Agents

## Environment Setup
- This is a personal dotfiles repository for macOS configuration
- Uses `rcup` from thoughtbot's RCM for dotfile management
- Main setup: `./install.sh` (installs dependencies and links files)

## Code Style
- Shell scripts: Use bash for compatibility
- Use meaningful comments for complex operations
- Maintain proper indentation (2-space preferred)
- Keep functions small and focused on a single task
- Use explicit paths rather than relative ones when appropriate

## Tools & Frameworks
- Package management: Homebrew (via Brewfile)
- Shell: Zsh with Oh-My-Zsh and Powerlevel10k theme
- Version managers: asdf, nvm, pyenv, chruby
- Git identity management via directory-specific .gitconfig files

## Organization
- System configs in root directory
- Directory structure follows standard dotfiles conventions
- Specialized configs in dedicated subdirectories when needed

## Git Practices
- Default branch: development
- Uses directory-specific git identities for personal/work separation