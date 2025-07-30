        if [ -z "$TMUX" ] && [ -n "$SSH_TTY" ]; then
          tmux attach-session -t ssh_tmux 2>/dev/null || tmux new-session -s ssh_tmux
          logout
        fi
