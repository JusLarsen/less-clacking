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

This dotfiles repository implements a directory-based git identity system to automatically use the correct name, email, and signing key based on the location of your repositories.

### How It Works

1. The main `~/.gitconfig` includes a path-specific configuration based on your current directory
2. Directory-specific `.gitconfig` files are set up in the development directories:
   - `~/development/.gitconfig` - Common settings for all development projects
   - `~/development/personal/.gitconfig` - Settings for personal projects
   - `~/development/work/.gitconfig` - Settings for work projects

### Identity Configuration

- **Personal**: Uses `justin@larsen.dev` email for open source and hobby projects
- **Work**: Uses `jlarsen@traeger.com` email for company-related repositories

### GPG Signing

Commits are configured to be signed with GPG for additional security and verification. The `gpgsign = true` setting is enabled in the development configuration.

### Setting Up a New Machine

To configure git identities on a new machine:

1. Clone this repository and run the install script:
   ```bash
   git clone git@github.com:JusLarsen/less-clacking.git ~/.dotfiles
   bash ~/.dotfiles/install.sh
   ```

2. Install GPG if not already installed via Homebrew:
   ```bash
   brew install gnupg pinentry-mac
   ```

3. Configure GPG to use the macOS pinentry program:
   ```bash
   echo "pinentry-program /opt/homebrew/bin/pinentry-mac" > ~/.gnupg/gpg-agent.conf
   gpgconf --kill gpg-agent
   ```

4. Import your GPG keys for signing:
   ```bash
   # Import existing GPG key from a file or USB drive (NEVER email your private key)
   gpg --import /path/to/private-key.asc
   
   # Or generate a new GPG key if needed
   gpg --full-generate-key
   ```

5. Configure GPG key for git:
   ```bash
   # Get your key ID
   gpg --list-secret-keys --keyid-format LONG
   
   # The output will look like this:
   # sec   rsa4096/AABBCCDDEEFF1122 2023-01-01 [SC]
   #       1234567890ABCDEF1234567890ABCDEF12345678
   # uid                 [ultimate] Your Name <your.email@example.com>
   # ssb   rsa4096/1122334455667788 2023-01-01 [E]
   
   # The value after rsa4096/ is your key ID (AABBCCDDEEFF1122 in this example)
   
   # Add the key ID to your personal and/or work .gitconfig files
   echo "  signingkey = YOUR_KEY_ID" >> ~/development/personal/.gitconfig
   echo "  signingkey = YOUR_KEY_ID" >> ~/development/work/.gitconfig
   ```

6. Make sure the GPG key is trusted:
   ```bash
   gpg --edit-key YOUR_KEY_ID
   # At the gpg> prompt, type:
   # trust
   # 5
   # y
   # quit
   ```

7. Configure git to always use GPG:
   ```bash
   # This is already set in the development/.gitconfig, but double-check:
   git config --list | grep gpg
   # Should show "commit.gpgsign=true"
   ```

8. Test your configuration:
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

9. Make a test commit in each location to verify signatures are working correctly:
   ```bash
   # Test commit
   echo "test" > test.txt
   git add test.txt
   git commit -m "Test signed commit"
   git log --show-signature -1  # Verify the signature is good
   ```

### Security Considerations

- **NEVER** store your private GPG keys in your dotfiles repository or any public repository
- Use a strong passphrase for your GPG key
- Consider using a YubiKey or other hardware security key for storing your GPG keys
- Regularly back up your GPG keys to a secure, encrypted location
- If you're using multiple machines, securely transfer your GPG keys between them

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