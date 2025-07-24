#!/usr/bin/env bash
set -euo pipefail

echo "🔧 Verifica installazione di Nix..."
if ! command -v nix &>/dev/null; then
  echo "📥 Installo Nix..."
  printf 'n\ny\n' | sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
  source /etc/profile.d/nix.sh
else
  echo "✅ Nix già installato."
fi

echo "📦 Aggiunta del canale home-manager (se necessario)..."
if ! nix-channel --list | grep -q '^home-manager'; then
  nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
fi

echo "🔄 Aggiornamento dei canali..."
nix-channel --update


echo "📁 Collegamento della configurazione in ~/.config/home-manager..."
mkdir -p ~/.config/home-manager

REPO_DIR="$(realpath "$(dirname "$0")")"
HM_DIR="$REPO_DIR/home-manager"

for file in home.nix fish.nix tmux.nix; do
  ln -sf "$HM_DIR/$file" "$HOME/.config/home-manager/$file"
done

echo "🏠 Applico la configurazione Home Manager..."
home-manager switch
nix-shell -p nix-info --run "nix-info -m"

echo "🎉 Configurazione completata!"
