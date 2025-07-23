#!/bin/bash
set -e

sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon

nix-channel --update
home-manager switch

