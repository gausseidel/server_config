#!/usr/bin/env bash
set -uo pipefail

REPO_DIR="/root/server_config"
CONFIG_DIR="/root/.config"

# Install packages
apt install -y fish zoxide tmux stow htop curl lsd net-tools gcc unzip

# Update Locale
locale-gen it_IT.UTF-8
echo "LANG=it_IT.UTF-8" > /etc/default/locale
update-locale

# Link dotfiles
mkdir -p $CONFIG_DIR
cd $REPO_DIR/dotfiles
stow . --target=$CONFIG_DIR --adopt

rm $HOME/.profile
ln -s $CONFIG_DIR/.profile $HOME

# Starship
if ! command -v starship >/dev/null 2>&1; then
  curl -sS https://starship.rs/install.sh | sh
else
  echo "✅ Starship è già installato"
fi

if [ ! -x /usr/local/bin/nvim ]; then
    echo "Neovim non trovato. Procedo con l'installazione..."
    wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.appimage
    chmod +x nvim-linux-x86_64.appimage
    mv nvim-linux-x86_64.appimage /usr/local/bin/nvim
    echo "Neovim installato in /usr/local/bin/nvim"
else
    echo "Neovim è già installato in /usr/local/bin/nvim"
fi
