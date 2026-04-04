{
  description = "A cute collection of tastefull (ok maybe not) nix modules for different software";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      flake-utils,
    }:
    {
      homeManagerModules = {
        zsh = import ./modules/zsh.nix;
        default = {
          imports = [
            ./modules/zsh.nix
          ];
        };
      };
    };
}
