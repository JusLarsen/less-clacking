# 🧰 Less Clacking

> Because I'm tired of resetting up my shell as I move around from machine to machine.

A personal dotfiles repository for quick and consistent macOS setup.

## ✨ Features

- **Terminal Environment**: Zsh with Oh-My-Zsh and Powerlevel10k
- **Development Tools**: Configured for Python, Ruby, Node.js, and more
- **Git Identity Management**: Separate configurations for personal and work projects
- **macOS Preferences**: Sensible defaults for Finder, Dock, and other system preferences
- **Editor Setup**: Vim configuration with essential settings

## 🛠️ Tools & Technologies

| Category | Tool | Description |
|:---------|:-----|:------------|
| Package Management | [Homebrew](https://brew.sh/) | The macOS package manager |
| Dependency Management | [Brewfile](https://thoughtbot.com/blog/brewfile-a-gemfile-but-for-homebrew) | Declarative Homebrew dependencies |
| Dotfile Management | [RCM](https://github.com/thoughtbot/rcm) | Thoughtbot's RC file manager |
| Shell | [ZSH](http://www.zsh.org/) | Modern shell with extensive features |
| Shell Framework | [Oh-My-Zsh](https://ohmyz.sh/) | Framework for managing Zsh configuration |
| Shell Theme | [Powerlevel10k](https://github.com/romkatv/powerlevel10k) | Fast and customizable Zsh prompt |
| Window Management | [Hammerspoon](https://www.hammerspoon.org/) | Powerful automation tool for macOS |
| Version Management | [asdf](https://asdf-vm.com/) | Multiple runtime version manager |

## 🚀 Installation

```bash
git clone git@github.com:JusLarsen/less-clacking.git ~/.dotfiles
bash ~/.dotfiles/install.sh
```

The install script will:
1. Install Homebrew if needed
2. Install packages from Brewfile
3. Set macOS preferences
4. Configure Oh-My-Zsh
5. Set up development directories
6. Link dotfiles to your home directory using RCM

## 📂 Directory Structure

This repository manages `git` identities using the following directory structure:

```
~
├── .dotfiles           # Configuration files and setup scripts
├── development         # Main development directory
│   ├── personal        # Personal projects (signed with personal key)
│   └── work            # Work projects (signed with work key)
```

## 🔑 Git Identity Management

Each development subdirectory has its own `.gitconfig` to manage different identities:

- **Personal**: For open source and hobby projects
- **Work**: For company-related repositories

The main `.gitconfig` includes the appropriate configuration based on the current directory.

## 🧠 Customization

- **Shell**: Edit `~/.zshrc` or `~/.zprofile`
- **Git**: Edit `~/.gitconfig` or the specific configs in development directories
- **Packages**: Edit `~/.dotfiles/Brewfile` and run `brew bundle install`
- **Vim**: Edit `~/.vimrc`
- **OS Preferences**: Add to `install.sh` (macOS section)

## 👤 Maintainer

| Name | GitHub | Email | Role |
|:-----|:-------|:------|:-----|
| Justin Larsen | [`JusLarsen`](https://github.com/JusLarsen) | [justin@larsen.dev](mailto://justin@larsen.dev) | Sentient Meat |