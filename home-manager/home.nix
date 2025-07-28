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
    gcc
    htop
    tmux
    bat
    lsd
  ];

  imports = [ ./fish.nix ./tmux.nix ];


home.file.".profile" = {
  text = ''
    # Se siamo root (login SSH)
    if [ "$(id -u)" -eq 0 ]; then
      # Se non siamo già dentro tmux e siamo su terminale SSH
      if [ -z "$TMUX" ] && [ -n "$SSH_TTY" ]; then
        # Provo ad attaccare la sessione ssh_tmux, se fallisce ne creo una nuova
        tmux attach-session -t ssh_tmux 2>/dev/null || tmux new-session -s ssh_tmux
      fi

    # Se siamo un utente normale (da su - user)
    else
      # Se non siamo già dentro tmux e la shell è interattiva
      if [ -z "$TMUX" ] && [ -t 0 ]; then
        tmux attach-session -t user_tmux 2>/dev/null || tmux new-session -s user_tmux
      fi
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
