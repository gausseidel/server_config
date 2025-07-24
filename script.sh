#!/bin/bash
set -e

sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager
nix-channel --update

home-manager switch

