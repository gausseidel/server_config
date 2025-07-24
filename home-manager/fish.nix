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
      ls = "ls --color=auto";
      v = "nvim";
      nv = "nvim";
      cat = "bat";
      grep = "grep --color=auto";
    };
  };
}
