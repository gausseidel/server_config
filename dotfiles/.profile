# .profile condiviso - versione robusta
if [ -n "$SSH_CONNECTION" ] && [ -z "$TMUX" ]; then
    # Controlla se siamo già in un ambiente tmux (anche se le variabili non sono ereditate)
    if ! pgrep -f "tmux.*$(whoami)" > /dev/null 2>&1; then
        SESSION_NAME="ssh_tmux_$(whoami)"
        tmux attach-session -t "$SESSION_NAME" 2>/dev/null || tmux new-session -s "$SESSION_NAME"
        logout
    fi
fi
