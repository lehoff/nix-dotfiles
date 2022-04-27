#!/bin/bash

# sh <(curl -L https://nixos.org/nix/install) --daemon
# TODO clone wallepapers https://github.com/catppuccin/wallpapers.git

DOT_FILES_REPO=$HOME/nix-dotfiles

sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.ol
sudo ln -s  $DOT_FILES_REPO/nix.conf /etc/nix/nix.conf

nix build .#darwinConfigurations.mimer.system
./result/sw/bin/darwin-rebuild switch --flake .#mimer
darwin-rebuild switch --flake .#mimer

# maybe error
# https://github.com/LnL7/nix-darwin/issues/451
# monterrey requires you to switch the shell 'chsh -s /etc/profiles/per-user/pepo/bin/zsh'
