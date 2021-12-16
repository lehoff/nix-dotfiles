#!/bin/sh

# nix-env -iA nixpkgs.nixFlakes
nix build ./\#darwinConfigurations.YOURHOSTNAME.system
./result/sw/bin/darwin-rebuild switch --flake ./
