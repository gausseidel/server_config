{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
      set -g theme_color_scheme dark
      starship init fish | source
      function user
          set home_users (ls /home)
          if count $home_users > 1
              echo "Errore: ci sono più utenti sotto /home. Non so quale usare."
              return 1
          end
          set target_user $home_users[1]
          su - $target_user
      end
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
      update = "cd /root/server_config; git pull; home-manager switch";
    };
  };
}
