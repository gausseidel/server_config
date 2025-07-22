if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting ''

zoxide init fish | source
starship init fish | source

if type -q tmux
    if not test -n "$TMUX"
        tmux attach-session -t default; or tmux new-session -s default
    end
end
