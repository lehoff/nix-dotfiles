mkdir -p ~/.config/nixpkgs
mkdir -p ~/.nixpkgs

ln -s  $HOME/Repos/dot-files/darwin-configuration.nix $HOME/.nixpkgs/darwin-configuration.nix

# Configure the channel

if ! grep -q nix-darwin ~/.nix-channels; then
  echo "https://github.com/LnL7/nix-darwin/archive/master.tar.gz darwin" >> ~/.nix-channels
fi
export NIX_PATH=darwin=$HOME/.nix-defexpr/channels/darwin:$NIX_PATH

export NIX_PATH=darwin-config=$HOME/.nixpkgs/darwin-configuration.nix:$HOME/.nix-defexpr/channels:$NIX_PATH
nix-channel --update


echo $NIX_PATH
nix-build '<darwin>' -A installer --out-link /tmp/nix-darwin && /tmp/nix-darwin/bin/darwin-installer

# Isn't it supposed to do this? It doesn't.
rm -rf /run/*
ln -shf /nix/store/$(ls /nix/store | grep darwin-system- | grep -v drv | head -1) /run/current-system

/run/current-system/sw/bin/darwin-rebuild switch

# . /etc/static/bashrc
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH

