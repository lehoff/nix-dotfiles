#!/bin/sh
PATH=/Users/lehoff/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH

ln -sf ${PWD}/nix-channels ~/.nix-channels

#from https://github.com/NixOS/nixpkgs/issues/149791#issuecomment-994964166
#fixes file 'nixpkgs' was not found in the Nix search path
export NIX_PATH=${NIX_PATH:+$NIX_PATH:}$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels

export NIX_PATH=darwin=$HOME/.nix-defexpr/channels/darwin:$NIX_PATH
export NIX_PATH=home-manager=$HOME/.nix-defexpr/channels/home-manager:$NIX_PATH
export NIX_PATH=darwin-config=$HOME/.nixpkgs/darwin-configuration.nix:$HOME/.nix-defexpr/channels:$NIX_PATH

echo "Current environment:"
env |grep -i ^nix

echo "NEXT: channel update"
nix-channel --update

echo "NEXT: install home-manager"
nix-shell '<home-manager>' -A install 

echo "NEXT: linking configuration files..."
mkdir -p ~/.nixpkgs
ln -sf ${PWD}/config.nix ~/.nixpkgs/
ln -sf ${PWD}/nix.conf ~/.nixpkgs/
ln -sf ${PWD}/darwin-configuration.nix ~/.nixpkgs/
ln -sf ${PWD}/home.nix ~/.nixpkgs/

echo "NEXT: build darwin"
nix-build '<darwin>' -A installer --out-link /tmp/nix-darwin && /tmp/nix-darwin/bin/darwin-installer
echo "NEXT: darwin-rebuild switch"
/run/current-system/sw/bin/darwin-rebuild switch

# ensure chages take effect…
echo "NEXT: As we modify the Dock settings we restart it..."
killall Dock 

# @TODO: find a way to do this with nix
defaults write com.freron.MailMate MmMessagesOutlineMoveStrategy -string "previous"
defaults write com.apple.trackpad.orientation TrackpadOrientationMode 1

# HOME MANAGER
#nix-shell '<home-manager>' -A install
#home-manager switch
#/run/current-system/sw/bin/darwin-rebuild switch
