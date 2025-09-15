#!/usr/bin/env bash
set -uo pipefail

REPO_DIR="$HOME/server_config"
CONFIG_DIR="$HOME/.config"

# Install packages
apt install -y fish zoxide tmux stow htop curl lsd net-tools gcc xclip neovim

# Update Locale - solo se necessario
if ! locale -a | grep -q "it_IT.utf8\|it_IT.UTF-8"; then
    echo "[*] Decommento it_IT.UTF-8 in /etc/locale.gen..."
    sed -i '/^# *it_IT.UTF-8 UTF-8/s/^# *//' /etc/locale.gen
    echo "[*] Genero i locale..."
    locale-gen
    echo "[*] Imposto LANG e LC_ALL su it_IT.UTF-8..."
    update-locale LANG=it_IT.UTF-8 LC_ALL=it_IT.UTF-8
    echo "[✓] Localizzazione completata. Riavvia il terminale o fai logout/login."
else
    echo "[✓] Locale it_IT.UTF-8 già configurato."
fi

# Link dotfiles
mkdir -p $CONFIG_DIR
cd $REPO_DIR/dotfiles
stow . --target=$CONFIG_DIR --adopt

rm $HOME/.profile
ln -s $CONFIG_DIR/.profile $HOME
ln -s $CONFIG_DIR/.bash_profile $HOME

# Starship
if ! command -v starship >/dev/null 2>&1; then
  curl -sS https://starship.rs/install.sh | sh
else
  echo "✅ Starship è già installato"
fi

