{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
      set -g theme_color_scheme dark
      starship init fish | source

      function user
          # Trova il primo utente con shell bash, sh, fish o zsh, escludendo root
          set utente (awk -F: '$7 ~ /(bash|sh|fish|zsh)$/ && $1 != "root" {print $1; exit}' /etc/passwd)

          if test -n "$utente"
              echo "Eseguo su - $utente"
              su - $utente
          else
              echo "Nessun utente trovato con shell bash, sh, fish o zsh diverso da root."
              return 1
          end
      end
    '';

 
    abbreviations = {
      ls = "lsd -l --color=auto";
      log = "journalctl -xe";
      v = "nvim";
      nano = "nvim";
      cat = "bat";
      grep = "grep --color=auto";
      s = "systemctl";
      st = "systemctl status";
      sr = "systemctl restart";
      update = "cd $HOME/server_config; git pull; home-manager switch";
    };
  };
}
