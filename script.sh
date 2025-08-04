#!/usr/bin/env bash
set -uo pipefail

REPO_DIR="/root/server_config"
CONFIG_DIR="/root/.config"

# Install packages
apt install -y fish zoxide tmux stow htop curl lsd net-tools gcc 

# Update Locale
echo "[*] Decommento it_IT.UTF-8 e en_US.UTF-8 in /etc/locale.gen..."
sed -i '/^# *it_IT.UTF-8 UTF-8/s/^# *//' /etc/locale.gen
#sed -i '/^# *en_US.UTF-8 UTF-8/s/^# *//' /etc/locale.gen
echo "[*] Genero i locale..."
locale-gen
echo "[*] Imposto LANG e LC_ALL su it_IT.UTF-8..."
update-locale LANG=it_IT.UTF-8 LC_ALL=it_IT.UTF-8
echo "[✓] Localizzazione completata. Riavvia il terminale o fai logout/login."

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
