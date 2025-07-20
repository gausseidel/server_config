if status is-interactive
    # Commands to run in interactive sessions can go here
end

#bash /root/.config/startup.sh
#zoxide init fish | source

if type -q tmux
    if not test -n "$TMUX"
        tmux attach-session -t default; or tmux new-session -s default
    end
end
