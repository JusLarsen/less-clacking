## Why Less Clacking?

Because I'm tired of resetting up my shell as I move around from machine to machine.

This repository configures OS X the way I like it.

## Tools

- Package Management: [Homebrew](https://brew.sh/)
- Package Dependency Management: [Brewfile](https://thoughtbot.com/blog/brewfile-a-gemfile-but-for-homebrew)
- Dotfile Management: [RCM](https://github.com/thoughtbot/rcm)
- Shell: [ZSH](http://www.zsh.org/)
- Shell Theme: [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- Window Hotkeys: [hammerspoon](https://www.hammerspoon.org/)

## Installation

Simple enough:

```
git clone git@github.com:JusLarsen/less-clacking.git ~/.dotfiles
bash ~/.dotfiles/install.sh
```

If it breaks, just run the commands one by one? Godspeed.


## Directory Layout

This repository manages `git` identities using the following directory structure

- `~/.dotfiles` - contains top level configs for the home environment and a blanket `.gitignore`
- `~/development` - assumed landing place for all development work
- `~/development/personal` - code staged here will be signed with my personal key. Open source and hobby projects go here.
- `~/development/work` - code staged here will be signed with my work key. Anything owned by my company goes here.


## Code Maintainers

| Name          | GitHub                                             | Email                                                 | Role             |
|:--------------|:---------------------------------------------------|:------------------------------------------------------|:-----------------|
| Justin Larsen | [`JusLarsen`](https://github.com/JusLarsen)   | [justin@larsen.dev](mailto://justin@larsen.dev)   | Sentient Meat |
