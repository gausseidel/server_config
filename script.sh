
#!/usr/bin/env bash
set -euo pipefail

echo "🔧 Installazione di Nix (se non già presente)..."
if ! command -v nix &>/dev/null; then
  sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
else
  echo "✅ Nix già installato."
fi

echo "📦 Aggiunta canale home-manager (se non già presente)..."
if ! nix-channel --list | grep -q '^home-manager'; then
  nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
else
  echo "✅ Canale home-manager già presente."
fi

echo "🔄 Aggiornamento dei canali..."
nix-channel --update

echo "📁 Collegamento configurazione Home Manager..."
mkdir -p ~/.config/nixpkgs

# Link simbolico idempotente
TARGET="/root/server_config/nix"
LINK="$HOME/.config/nixpkgs"

if [ "$(readlink -f "$LINK")" != "$(readlink -f "$TARGET")" ]; then
  rm -f "$LINK/home.nix" "$LINK/fish.nix" "$LINK/tmux.nix" 2>/dev/null || true
  ln -sf "$TARGET/home.nix" "$LINK/home.nix"
  ln -sf "$TARGET/fish.nix" "$LINK/fish.nix"
  ln -sf "$TARGET/tmux.nix" "$LINK/tmux.nix"
  echo "✅ Link creati per home.nix, fish.nix, tmux.nix"
else
  echo "✅ Link già corretti."
fi

echo "🏠 Applicazione della configurazione Home Manager..."
home-manager switch

echo "🎉 Configurazione completata con successo!"

