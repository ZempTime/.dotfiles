My personal development environment configuration files and setup instructions.

## Overview

This repository contains my development environment configurations, focusing on a minimal yet powerful setup using:
- Neovim as the primary editor
- tmux for terminal multiplexing
- mise for runtime version management (Ruby, Node, etc.)
- Lazygit for Git operations
- Direnv for environment management

I've gone through various setups over the years (macvim → VSCode → tmux), and in 2025 I decided to focus on continually improving my development environment, starting with a move to Neovim. This repository documents my journey and configurations.

## New Computer Setup

Complete instructions for setting up a new machine.

### 1. Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Install Core Tools

```bash
# Editor & terminal
brew install neovim lazygit tmux

# CLI utilities (used by Claude Code and general development)
brew install fd rg ast-grep direnv gh jq uv

# Languages (managed by mise, but Go installed directly)
brew install go

# Other
brew install sox  # speech to text

# Fonts
brew install --cask font-jetbrains-mono-nerd-font
```

**Tool summary:**
| Tool | Purpose |
|------|---------|
| `fd` | Fast find alternative |
| `rg` | ripgrep - fast grep alternative |
| `ast-grep` | AST-based code search/refactor |
| `direnv` | Directory-specific environment variables |
| `gh` | GitHub CLI |
| `jq` | JSON processor |
| `uv` | Fast Python package manager |
| `go` | Go programming language |
| `mise` | Runtime version manager (Ruby, Node, Python) |

### 3. Install mise (Runtime Version Manager)

```bash
curl https://mise.run | sh
```

Add to your `~/.zshrc`:
```bash
eval "$(/Users/YOUR_USERNAME/.local/bin/mise activate zsh)"
```

Install runtimes:
```bash
mise use -g ruby@3.3.4
mise use -g node@20.18.0
# Add other runtimes as needed
```

### 4. Clone Dotfiles

```bash
git clone https://github.com/zemptime/.dotfiles ~/.dotfiles
```

### 5. Create Symlinks

```bash
# Neovim configuration
ln -s ~/.dotfiles/nvim ~/.config/nvim

# tmux configuration
ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf

# Direnv configuration
mkdir -p ~/.config/direnv
ln -s ~/.dotfiles/direnv/direnvrc ~/.config/direnv/direnvrc

# mise configuration (optional - or just run mise use -g commands)
mkdir -p ~/.config/mise
ln -s ~/.dotfiles/mise/config.toml ~/.config/mise/config.toml
```

### 6. tmux Plugin Manager (TPM)

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Start tmux and install plugins:
```bash
tmux
# Press C-Space I (capital I) to install plugins
```

### 7. Neovim First Launch

Open Neovim - Lazy.nvim will automatically install plugins:
```bash
nvim
```

Mason will install LSP servers on first use. To manually install:
```vim
:MasonInstall ruby-lsp prettierd
```

### 8. Claude Code Setup

Install Claude Code:
```bash
npm install -g @anthropic-ai/claude-code
```

Link configuration files:
```bash
# Root CLAUDE.md (global instructions)
ln -s ~/.dotfiles/claude/CLAUDE.md ~/.claude/CLAUDE.md

# Settings (copy template and edit with your project ID)
cp ~/.dotfiles/claude/settings.json.template ~/.claude/settings.json
# Edit ~/.claude/settings.json and replace YOUR_PROJECT_ID_HERE

# Custom skills
ln -s ~/.dotfiles/claude/skills ~/.claude/skills

# Custom slash commands
ln -s ~/.dotfiles/claude/commands ~/.claude/commands
```

Install plugins (superpowers + episodic memory):
```bash
claude
# Then run: /install-plugin superpowers-marketplace/superpowers
# Then run: /install-plugin superpowers-marketplace/episodic-memory
```

**Restore episodic memory (optional):**

Episodic memory stores conversation history at `~/.config/superpowers/`.
To preserve memory across machines, back it up separately:

```bash
# Backup (on old machine)
tar -czf ~/episodic-memory-backup.tar.gz ~/.config/superpowers/conversation-archive ~/.config/superpowers/conversation-index

# Restore (on new machine)
mkdir -p ~/.config/superpowers
tar -xzf ~/episodic-memory-backup.tar.gz -C /
```

Or sync via cloud storage (Dropbox, iCloud, etc.):
```bash
# Move to cloud and symlink
mv ~/.config/superpowers ~/Dropbox/superpowers-memory
ln -s ~/Dropbox/superpowers-memory ~/.config/superpowers
```

### 9. Configure iTerm2 Font

1. Open **iTerm2 → Settings** (Cmd+,)
2. Go to **Profiles → Text**
3. Set font to **JetBrainsMono Nerd Font**

### 10. Shell Aliases

Add to your `~/.zshrc`:
```bash
alias halp='cat ~/.dotfiles/cheatsheet.txt'
```

### 10. Direnv Setup

1. Add to `~/.zshrc`:
```bash
plugins=(git direnv)
```

2. Create and configure:
```bash
touch ~/.envrc
echo 'source_env ~/.config/direnv/direnvrc' >> ~/.envrc
direnv allow ~
```

## Quick Reference

Run `halp` in terminal to see the full cheatsheet, or see `cheatsheet.txt`.

### Key Bindings Summary

| Context | Key | Action |
|---------|-----|--------|
| Neovim | `<leader>cf` | Copy @file:line reference |
| Neovim | `<leader>tc` | Send @file:line to Claude pane |
| Neovim | `<leader>f` | Format (Prettier/LSP) |
| Neovim | `C-h/j/k/l` | Navigate splits (works with tmux) |
| tmux | `C-Space \|` | Split pane horizontally |
| tmux | `C-Space -` | Split pane vertically |
| tmux | `C-Space z` | Zoom pane |
| tmux | `M-H / M-L` | Previous/next window |

## Repository Structure

```
~/.dotfiles/
├── cheatsheet.txt              # Command reference (halp alias)
├── claude/                     # Claude Code configuration
│   ├── CLAUDE.md               # Global instructions
│   ├── settings.json.template  # Settings template (edit for your project)
│   ├── skills/                 # Custom skills
│   └── commands/               # Custom slash commands
├── nvim/                       # Neovim configuration
│   └── lua/config/
│       ├── plugins.lua
│       ├── nvim-lsp.lua
│       ├── options.lua
│       └── ...
├── tmux/
│   └── tmux.conf               # tmux configuration
├── direnv/
│   └── direnvrc                # Direnv configuration
├── mise/
│   └── config.toml             # mise global tool versions (optional)
└── readme.md
```

## Tools Overview

### Neovim
Modern, backwards-compatible fork of Vim. Configured with:
- LSP support (Ruby, TypeScript, Lua, etc.)
- conform.nvim for formatting (Prettier + LSP fallback)
- vim-tmux-navigator for seamless pane navigation
- Telescope for fuzzy finding
- Oil for file exploration

### tmux
Terminal multiplexer for managing multiple sessions/windows/panes:
- Prefix: `C-Space`
- vim-tmux-navigator integration
- Persistent sessions survive terminal close

### mise
Runtime version manager (replaces asdf/rbenv/nvm):
- Manages Ruby, Node, Python, etc.
- Project-specific versions via `.tool-versions`
- Global defaults via `~/.config/mise/config.toml`

### Lazygit
Terminal UI for Git commands, making version control more intuitive.

### Direnv
Automatically load and unload environment variables depending on the current directory.

## Maintenance

To update configurations:
1. Make changes in the `.dotfiles` directory
2. Changes will automatically reflect in your environment due to symlinks
3. Commit and push to keep in sync across machines

## License

MIT
