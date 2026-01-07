fish_add_path /opt/homebrew/bin

~/.local/bin/mise activate fish | source
mise activate fish | source

function fish_prompt
    set_color blue
    echo -n (prompt_pwd)
    set_color green
    fish_git_prompt " (%s)"
    set_color normal
    echo -n ' $ '
end


fish_add_path /Users/chriszempel/Documents/projects/aha/aha-dev-cli
alias aha-dev-cli='/Users/chriszempel/Documents/projects/aha/aha-dev-cli/aha'

if status is-interactive
  # Commands to run in interactive sessions can go here

  bind -e \ca  # unbind C-a in fish
end
