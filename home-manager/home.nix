{ config, pkgs, ... }:

let
  user = builtins.getEnv "USER";
  homeDir = builtins.getEnv "HOME";
in
{
  home.username = user;
  home.homeDirectory = homeDir;
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    wget
    curl
    htop
    tmux
    bat
    lsd
  ];

  imports = [ ./fish.nix ./tmux.nix ];

  home.file.".profile".text = ''
    if [[ -z "$TMUX" && -n "$SSH_TTY" ]]; then
        tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
        logout
    fi
  '';

  home.file.".config/starship.toml".source = ./starship.toml;

  home.file.".config/nvim".source = ./nvim;
  programs.neovim.enable = true;

  programs.starship.enable = true;
  programs.fish.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

}
