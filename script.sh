#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="/root/server_config"
CONFIG_DIR="/root/.config"

# Install packages
apt install fish zoxide tmux stow htop curl lsd

# Link dotfiles
mkdir -p $CONFIG_DIR
stow --dir=$REPO_DIR --target=$CONFIG_DIR --adopt
ln -s $CONFIG_DIR/.profile $HOME

# Starship
#curl -sS https://starship.rs/install.sh | sh

# NeoVim
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.appimage
chmod +x nvim-linux-x86_64.appimage
mv  nvim-linux-x86_64.appimage /usr/local/bin/nvim
