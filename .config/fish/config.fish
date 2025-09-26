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
if type -q zed
    set -Ux EDITOR zed
else if type -q code
    set -Ux EDITOR code
else if type -q nvim
    set -Ux EDITOR nvim
else
    set -Ux VISUAL nano
end

# Setup mamba before init packages
# >> mamba initialize >>
# !! Contents within this block are managed by 'mamba shell init' !!
# No they arent because I manage them myself ¬_¬
if test -x "$HOME/miniforge3/bin/mamba"
    set -gx MAMBA_EXE "$HOME/miniforge3/bin/mamba"
    set -gx MAMBA_ROOT_PREFIX "$HOME/.local/share/mamba"
    $MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
end
# << mamba initialize <<

# >> conda initialize >>
# !! Contents within this block are managed by 'conda init' !!
# No they arent because I manage them myself ¬_¬
if test -f $HOME/miniforge3/bin/conda
    eval $HOME/miniforge3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "$HOME/miniforge3/etc/fish/conf.d/conda.fish"
        . "$HOME/miniforge3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "$HOME/miniforge3/bin" $PATH
    end
end
# << conda initialize <<

# Starship setup
starship init fish | source

# Zoxide setup
if type -q direnv
	zoxide init fish | source
end

# Set up fzf key bindings
# fzf --fish | source

# aliases :
alias wake-pc="wol 04:7C:16:ED:00:82"
alias fishconfig="zed ~/.config/fish/config.fish"
alias dotconfig="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias lg-dotconfig='lazygit --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Direnv setup
if type -q direnv
	direnv hook fish | source
end


# fastfetch
