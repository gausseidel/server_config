{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
      set -g theme_color_scheme dark
      starship init fish | source
    '';

    shellAliases = {
      ls = "lsd -l --color=auto";
      log = "journalctl -xe";
      v = "nvim";
      nano = "nvim";
      cat = "bat";
      grep = "grep --color=auto";
      s = "systemctl";
      st = "systemctl status";
      sr = "systemctl restart";
    };
  };
}
