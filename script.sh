#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="/root/server_config"
CONFIG_DIR="/root/.config"

apt install neovim fish zoxide tmux stow htop curl
mkdir -p $CONFIG_DIR
stow --dir=$REPO_DIR --target=$CONFIG_DIR --adopt

