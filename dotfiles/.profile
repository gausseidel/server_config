if [[ -z "$TMUX" && -n "$SSH_TTY" ]]; then
    tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
    logout  # Termina la sessione SSH quando si esce da tmux
fi
