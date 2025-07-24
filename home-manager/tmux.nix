{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    terminal = "tmux-256color";
    extraConfig = ''
      set-option -ga terminal-overrides ",xterm-256color:Tc"
      set-option -g window-status-style bg=default
      set-option -g status-style bg=default,fg=default
      set-option -g window-status-current-style bg=default
      set -g mouse on
      bind -n C-h select-pane -L
      bind -n C-j select-pane -D
      bind -n C-k select-pane -U
      bind -n C-l select-pane -R
    '';
  };
}

