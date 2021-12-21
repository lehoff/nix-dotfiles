#!/bin/sh

ln -sf ${PWD}/nix-channels ~/.nix-channels
export NIX_PATH=home-manager=$HOME/.nix-defexpr/channels/home-manager:$NIX_PATH
export NIX_PATH=darwin-config=$HOME/.nixpkgs/darwin-configuration.nix:$HOME/.nix-defexpr/channels:$NIX_PATH

nix-channel --update

# nix-shell '<home-manager>' -A install 

mkdir -p ~/.nixpkgs
ln -sf ${PWD}/config.nix ~/.nixpkgs/
ln -sf ${PWD}/nix.conf ~/.nixpkgs/
ln -sf ${PWD}/darwin-configuration.nix ~/.nixpkgs/

# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

nix-build '<darwin>' -A installer --out-link /tmp/nix-darwin && /tmp/nix-darwin/bin/darwin-installer



#nix-env -iA nixpkgs.nixFlakes
#nix build ./\#darwinConfigurations.mimer.system
#./result/sw/bin/darwin-rebuild switch --flake ./
