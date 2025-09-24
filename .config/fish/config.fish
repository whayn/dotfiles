if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Variables to set
set -Ux GOPATH $HOME/.go
set -Ux GOBIN $HOME/.local/bin

set -g fish_greeting

starship init fish | source

# Zoxide setup
zoxide init fish | source

# Set up fzf key bindings
# fzf --fish | source

# aliases :
alias wake-pc="wol 04:7C:16:ED:00:82"
alias fishconfig="zed ~/.config/fish/config.fish"
alias dotconfig="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias lg-dotconfig='lazygit --git-dir=$HOME/.cfg/ --work-tree=$HOME'


# Direnv setup
direnv hook fish | source

# Set Default Editor
set -gx EDITOR zed

# fastfetch
