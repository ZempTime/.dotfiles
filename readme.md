## What is this

At one point I used macvim. Then I swapped back to vscode for standardization reasons. Then I used tmux for a bit and docker'd before docker was a thing.

After some years of stagnation, I decided it'd be good for me to continually focus and iterate on my development environment. Tinkering, for it's own sake.

So at the start of 2025, I moved to neovim. 

Now it's time to learn/rediscover the better ways to dev, one tool at a time.

## Getting started

```
brew install neovim lazygit direnv
```

## **Use Symlinks to Link Configurations**
Keep your configurations in the `.dotfiles` directory and create symlinks to the expected locations.

Example:
```bash
ln -s ~/.dotfiles/nvim ~/.config/nvim
ln -s ~/.dotfiles/direnv/direnvrc ~/.config/direnv/direnvrc


# ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
# ln -s ~/.dotfiles/gitconfig ~/.gitconfig
```

### Direnv

Create the files and directories:
```
touch ~/.envrc
```

Add the following content to ~/.envrc:
```
source_env ~/.config/direnv/direnvrc
```

Allow the .envrc file:
```
direnv allow ~
```

Shell configuration

```
plugins=(git direnv)
```

Link to here
```
mkdir -p ~/.config/direnv
ln -s ~/.dotfiles/direnv/direnvrc ~/.config/direnv/direnvrc
```
