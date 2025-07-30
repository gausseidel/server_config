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
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    font-awesome
    powerline-fonts
    wget
    curl
    ripgrep
    gcc
    htop
    tmux
    bat
    lsd
  ];

  imports = [ ./fish.nix ./tmux.nix ];


  home.file.".profile" =
    if user == "root" then {
      text = ''
        if [ -z "$TMUX" ] && [ -n "$SSH_TTY" ]; then
          tmux attach-session -t ssh_tmux 2>/dev/null || tmux new-session -s ssh_tmux
          logout
        fi
      '';
    } else {
      text = ''
        if [ -z "$TMUX" ] && [ -t 0 ]; then
          tmux attach-session -t user_tmux 2>/dev/null || tmux new-session -s user_tmux
          exit
        fi
      '';
    };


  home.file.".config/starship.toml".source = ./starship.toml;

  home.file.".config/nvim".source = ./nvim;
  programs.neovim.enable = true;

  programs.starship.enable = true;
  programs.fish.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

}
