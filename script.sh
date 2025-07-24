#!/usr/bin/env bash
set -euo pipefail

echo "🔧 Installazione di Nix (se non già presente)..."
if ! command -v nix &>/dev/null; then
  sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
  source /etc/profile.d/nix.sh
else
  echo "✅ Nix già installato."
fi

echo "📦 Aggiunta canale home-manager (se non già presente)..."
if ! nix-channel --list | grep -q '^home-manager'; then
  nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
fi

echo "🔄 Aggiornamento dei canali..."
nix-channel --update

echo "📥 Installazione di home-manager nel profilo utente..."
if ! command -v home-manager &>/dev/null; then
  nix-env -iA home-manager -f '<home-manager>'
fi

echo "📁 Collegamento configurazione Home Manager..."
mkdir -p ~/.config/nixpkgs

TARGET="/root/server_config/nix"
LINK="$HOME/.config/nixpkgs"

ln -sf "$TARGET/home.nix" "$LINK/home.nix"
ln -sf "$TARGET/fish.nix" "$LINK/fish.nix"
ln -sf "$TARGET/tmux.nix" "$LINK/tmux.nix"

echo "🏠 Applicazione della configurazione Home Manager..."
home-manager switch

echo "🎉 Configurazione completata con successo!"
