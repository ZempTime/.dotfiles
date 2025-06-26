My personal development environment configuration files and setup instructions.

## Overview

This repository contains my development environment configurations, focusing on a minimal yet powerful setup using:
- Neovim as the primary editor
- Lazygit for Git operations
- Direnv for environment management

I've gone through various setups over the years (macvim → VSCode → tmux), and in 2025 I decided to focus on continually improving my development environment, starting with a move to Neovim. This repository documents my journey and configurations.

## Prerequisites

- macOS (using Homebrew as package manager)
- Git
- oh my Zsh (recommended)

## Installation

### 1. Core Tools

```bash
brew install neovim lazygit direnv
brew install sox # speech to text
```

### 2. Configuration Setup

Clone this repository to your home directory:
```bash
git clone https://github.com/zemptime/.dotfiles ~/.dotfiles
```

### 3. Create Symlinks

Link configuration files to their expected locations:

```bash
# Neovim configuration
ln -s ~/.dotfiles/nvim ~/.config/nvim

# Direnv configuration
mkdir -p ~/.config/direnv
ln -s ~/.dotfiles/direnv/direnvrc ~/.config/direnv/direnvrc

# Optional configurations (uncomment if needed):
# ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
# ln -s ~/.dotfiles/gitconfig ~/.gitconfig
```

### 4. Direnv Setup

1. Create the main environment file:
```bash
touch ~/.envrc
```

2. Add the following content to `~/.envrc`:
```bash
source_env ~/.config/direnv/direnvrc
```

3. Allow the configuration:
```bash
direnv allow ~
```

4. Add direnv to your shell (Zsh):

Add to your `~/.zshrc`:
```bash
plugins=(git direnv)
```

## Tools Overview

### Neovim
Modern, backwards-compatible fork of Vim. Configured for enhanced development experience with:
- LSP support
- Modern plugins
- Custom keybindings

### Lazygit
Terminal UI for Git commands, making version control more intuitive.

### Direnv
Automatically load and unload environment variables depending on the current directory.

## Maintenance

To update configurations:
1. Make changes in the `.dotfiles` directory
2. Changes will automatically reflect in your environment due to symlinks

## Contributing

Feel free to open issues or submit pull requests if you have suggestions for improvements.

## License

MIT
