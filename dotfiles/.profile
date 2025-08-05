# .profile condiviso
if [ -n "$SSH_CONNECTION" ] && [ -z "$TMUX" ]; then
    SESSION_NAME="ssh_tmux_$(whoami)"
    tmux attach-session -t "$SESSION_NAME" 2>/dev/null || tmux new-session -s "$SESSION_NAME"
    logout
fi
