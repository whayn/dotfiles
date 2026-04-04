{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;

    enableCompletion = true;

    antidote = {
      enable = true;
      plugins = [
        "olets/zsh-autosuggestions-abbreviations-strategy"
      ];
    };

    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    historySubstringSearch.enable = true;
    zsh-abbr.enable = true;

    history = {
      size = 10000;
      save = 10000;
      ignoreDups = true;
    };

    shellAliases = {
      ls = "eza --group-directories-first --icons --header";
      cat = "bat";
    };

    initContent = ''
      abbr add --quiet --position anywhere -- --help '--help | bat -plhelp'
      abbr add --quiet --position anywhere -- -h '-h | bat -plhelp'

      # good lookaing completiosn
      zmodload zsh/complist
      zstyle ':completion:*' menu select
      zstyle ':completion:*' list-colors ""


      PROMPT="%F{green}%n%f@%F{cyan}%m%f:%F{yellow}%~%f %F{magenta}>%f "

      # some fukcin bindings
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
      bindkey "^[[1;3C" forward-word
      bindkey "^[[1;3D" backward-word
      bindkey "^[[H" beginning-of-line
      bindkey "^[[F" end-of-line
      bindkey "^[[3~" delete-char

      # sorry sudo
      prepend-sudo() {
        if [[ -z "$BUFFER" ]]; then
          LBUFFER="sudo $(fc -ln -1)"
        elif [[ $BUFFER != su(do|)\ * ]]; then
          BUFFER="sudo $BUFFER"
          CURSOR+=5
        fi
      }
      zle -N prepend-sudo
      bindkey "^[s" prepend-sudo

      # Syntax higlighting
      source ${
        pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "zsh-syntax-highlighting";
          rev = "7926c3d3e17d26b3779851a2255b95ee650bd928";
          hash = "sha256-l6tztApzYpQ2/CiKuLBf8vI2imM6vPJuFdNDSEi7T/o=";
        }
      }/themes/catppuccin_macchiato-zsh-syntax-highlighting.zsh
    '';
    # can add
    # ${builtins.readFile ../assets/rainbow-prompt.zsh}
  };

  # programs.starship = {
  #   enable = true;
  #   enableZshIntegration = true;

  # };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.bat = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
