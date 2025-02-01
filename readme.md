## Getting started

```
brew install neovim
```

## **Use Symlinks to Link Configurations**
Keep your configurations in the `.dotfiles` directory and create symlinks to the expected locations.

Example:
```bash
ln -s ~/.dotfiles/nvim ~/.config/nvim
ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/gitconfig ~/.gitconfig
```

