#!/bin/bash

set -e

FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hack.zip"
FONT_DIR="$HOME/.local/share/fonts/HackNerdFont"
TMP_ZIP="/tmp/Hack.zip"

echo "Scarico il font Nerd Font Hack..."
curl -L -o "$TMP_ZIP" "$FONT_URL"

echo "Creo la cartella font locale se non esiste..."
mkdir -p "$FONT_DIR"

echo "Estraggo i font..."
unzip -o "$TMP_ZIP" -d "$FONT_DIR"

echo "Aggiorno la cache dei font..."
fc-cache -fv "$FONT_DIR"

echo "Pulisco..."
rm "$TMP_ZIP"

echo "Installazione completata! Ora puoi impostare il font Nerd Font Hack nel terminale."

