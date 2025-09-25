if status is-interactive
    if type -q eza
        alias ls='eza --group-directories-first --icons --header'
    end
    if type -q bat
        alias cat='bat'
    end

    # Set up bat for man pages if available
    if type -q batman
        alias man='batman'
    end
end

# Variables to set
set -Ux GOPATH $HOME/.go
set -Ux GOBIN $HOME/.local/bin

set -g fish_greeting

# Set Default Editor
set -gx EDITOR zed

# Starship setup
starship init fish | source

# Zoxide setup
zoxide init fish | source

# Set up fzf key bindings
# fzf --fish | source

# aliases :
alias wake-pc="wol 04:7C:16:ED:00:82"
alias fishconfig="zed ~/.config/fish/config.fish"
alias dotconfig="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias lg-dotconfig='lazygit --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'


# Direnv setup
direnv hook fish | source



# fastfetch
