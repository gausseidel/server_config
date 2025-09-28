set fish_greeting
set -g theme_color_scheme dark
starship init fish | source
zoxide init fish | source
function user
    # Trova il primo utente con shell bash, sh, fish o zsh, escludendo root
    set utente (getent passwd | awk -F: '$7 ~ /(bash|sh|fish|zsh)$/ && $1 != "root" { print $1; exit }')

    if test -n "$utente"
        echo "Eseguo su - $utente"
        su - $utente
    else
        echo "Nessun utente trovato con shell bash, sh, fish o zsh diverso da root."
        return 1
    end
end


alias ls 'lsd -l --group-directories-first'
alias la 'lsd -la --group-directories-first'
abbr -a log "journalctl -xe"
alias v "nvim"
alias grep "grep --color=auto"
abbr -a s "systemctl"
abbr -a st "systemctl status"
abbr -a sr "systemctl restart"
abbr -a update "cd $HOME/server_config; git pull; stow . --adopt --target=$HOME/.config"

