# Esegui prima il contenuto di .profile, se esiste
if [ -f ~/.profile ]; then
    . ~/.profile
fi

# Poi passa a fish
exec fish
