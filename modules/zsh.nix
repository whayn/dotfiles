{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;

    enableCompletion = true;

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-history-substring-search"; }
        { name = "olets/zsh-abbr"; }
      ];
    };

    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      save = 10000;
      ignoreDups = true;
    };

    shellAliases = {
      ls = "eza --group-directories-first --icons --header";
      cat = "bat";
    };

    initExtra = ''
      abbr add --quiet --position anywhere -- --help '--help | bat -plhelp'
      abbr add --quiet --position anywhere -- -h '-h | bat -plhelp'

      PROMPT='%F{red}%n%F{yellow}@%F{green}%m%F{cyan}:%F{blue}%~%F{magenta} > %f'

      # Syntax higlighting
      source ${
        pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "zsh-syntax-highlighting";
          rev = "7926c3d3e17d26b3779851a2255b95ee650bd928";
          hash = "";
        }
      }/themes/catppuccin_macchiato-zsh-syntax-highlighting.zsh
    '';

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
