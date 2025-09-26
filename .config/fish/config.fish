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
# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
set -gx MAMBA_EXE "/home/tp-home018/4a5d105a-0c44-4968-a1a6-f754540e9e6d/miniforge3/bin/mamba"
set -gx MAMBA_ROOT_PREFIX "/home/tp-home018/4a5d105a-0c44-4968-a1a6-f754540e9e6d/.local/share/mamba"
$MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
# <<< mamba initialize <<<

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/tp-home018/mfalgay/miniforge3/bin/conda
    eval /home/tp-home018/mfalgay/miniforge3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/home/tp-home018/mfalgay/miniforge3/etc/fish/conf.d/conda.fish"
        . "/home/tp-home018/mfalgay/miniforge3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/home/tp-home018/mfalgay/miniforge3/bin" $PATH
    end
end
# <<< conda initialize <<<

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



