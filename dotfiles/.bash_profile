# Esegui prima il contenuto di .profile, se esiste
if [ -f ~/.profile ]; then
    . ~/.profile
fi

# Avvia tmux se non siamo già dentro (funziona anche con su -)
if [[ -z "$TMUX" ]]; then
    # Avvia tmux con fish come shell
    exec tmux new-session -A -s user_session fish
else
    # Se siamo già in tmux, passa solo a fish
    exec fish
fi
