#!/bin/bash
set -e

sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon

nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
mkdir -p ~/.config/nixpkgs
ln -s /root/server_config/nix/ ~/.config/nixpkgs/

home-manager switch

