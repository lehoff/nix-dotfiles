#!/bin/sh

ln -sf ${PWD}/nix-channels ~/.nix-channels

nix-channel --update

mkdir -p ~/.config/nix 
ln -sf ${PWD}/nix.conf ~/.config/nix/


nix-env -iA nixpkgs.nixFlakes
nix build ./\#darwinConfigurations.mimer.system
./result/sw/bin/darwin-rebuild switch --flake ./
