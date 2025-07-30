#!/usr/bin/env bash
set -euo pipefail


echo "📁 Collegamento della configurazione in ~/.config/home-manager..."
REPO_DIR="$HOME/server_config"
TARGET="$HOME/.config/home-manager"
mkdir -p "$HOME/.config"
# Rimuove solo il link o directory esistente home-manager 
if [ -L "$TARGET" ] || [ -d "$TARGET" ]; then
  rm -rf "$TARGET"
fi
# Crea il symlink
ln -s "$REPO_DIR/home-manager" "$TARGET"
echo "📥 Installazione di home-manager (se necessario)..."
if ! command -v home-manager &>/dev/null; then
  nix-env -iA home-manager -f '<home-manager>'
fi

echo "🏠 Applico la configurazione Home Manager..."
home-manager switch

echo "🎉 Configurazione completata!"
