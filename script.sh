#!/usr/bin/env bash
set -uo pipefail

REPO_DIR="/root/server_config"
CONFIG_DIR="/root/.config"

# Install packages
apt install -y fish zoxide tmux stow htop curl lsd net-tools gcc

# Link dotfiles
mkdir -p $CONFIG_DIR
cd $REPO_DIR/dotfiles
stow . --target=$CONFIG_DIR --adopt
ln -s $CONFIG_DIR/.profile $HOME

# Starship
#curl -sS https://starship.rs/install.sh | sh

# NeoVim
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.appimage
chmod +x nvim-linux-x86_64.appimage
mv  nvim-linux-x86_64.appimage /usr/local/bin/nvim
