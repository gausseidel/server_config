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
    ripgrep
    htop
    tmux
    bat
    lsd
  ];

  imports = [ ./fish.nix ./tmux.nix ];

  home.file.".profile" =
    if user == "root" then {
      text = ''
        if [[ -z "$TMUX" && -n "$SSH_TTY" ]]; then
            tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
            logout
        fi
      '';
    } else {
      text = ''
        if [[ -z "$TMUX" && -t 0 ]]; then
          tmux attach-session -t user_tmux || tmux new-session -s user_tmux
        fi
        exec fish
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
