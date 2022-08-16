#!/bin/bash

# for now install homebrew manually:
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# sh <(curl -L https://nixos.org/nix/install) --daemon
# TODO clone wallepapers https://github.com/catppuccin/wallpapers.git

# nix-shell -p nix-info --run "nix-info -m"

DOT_FILES_REPO=$HOME/nix-dotfiles

sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.old
sudo ln -s  $DOT_FILES_REPO/nix.conf /etc/nix/nix.conf

nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
./result/bin/darwin-installer
# questions:
# Would you like to edit the default configuration.nix before starting? [y/n] NO
# Would you like to manage <darwin> with nix-channel? [y/n] YES
# Would you like to load darwin configuration in /etc/bashrc? [y/n] y
# Would you like to load darwin configuration in /etc/zshrc? [y/n] y

# remove flake.lock (maybe)
# mv /Users/lehoff/.zshrc /Users/lehoff/.zshrc.pre.flake

# Start a fresh shell.

nix build ./\#darwinConfigurations.mimer.system

# make a backup of ~/.zshrc: 
# mv ~/.zshrc ~/.zshrc.before-nix
./result/sw/bin/darwin-rebuild switch --flake ./\#mimer

# maybe error
# https://github.com/LnL7/nix-darwin/issues/451
# monterrey requires you to switch the shell 'chsh -s /etc/profiles/per-user/pepo/bin/zsh'
