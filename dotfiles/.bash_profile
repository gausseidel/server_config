# Esegui prima il contenuto di .profile, se esiste
if [ -f ~/.profile ]; then
    . ~/.profile
fi

# Avvia tmux PRIMA di passare a fish, se siamo via SSH
if [[ -z "$TMUX" && -n "$SSH_TTY" ]]; then
    exec tmux new-session -A -s ssh_tmux fish
else
    # Altrimenti passa normalmente a fish
    exec fish
fi
