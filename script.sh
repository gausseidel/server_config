#!/bin/bash

set -e

# Installa i pacchetti necessari
apt update
apt install -y tmux fish stow

# Verifica se nvim è già presente
if [ ! -x /usr/local/bin/nvim ]; then
  echo "Neovim non trovato, procedo con l'installazione..."

  # Scarica neovim
  wget https://github.com/neovim/neovim/releases/download/v0.11.3/nvim-linux-x86_64.tar.gz

  # Estrai
  tar xzvf nvim-linux-x86_64.tar.gz

  # Sposta e crea il link simbolico
  mv nvim-linux-x86_64 /opt/nvim
  ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim

  # Pulizia file temporanei
  rm nvim-linux-x86_64.tar.gz
else
  echo "Neovim già installato, salto il download."
fi

if [ ! -x /usr/local/bin/starship ]; then
  echo "Starship non trovato, procedo con l'installazione..."
  yes | curl -sS https://starship.rs/install.sh | sh
else
  echo "Starship è già installato, salto l'installazione."
fi

# Rimuove configurazioni precedenti
rm -rf /root/.config /root/.tmux.conf /root/.profile

# Aggiorna configurazione da git e applica con stow
cd /root/server_config/
git pull
stow . --adopt
