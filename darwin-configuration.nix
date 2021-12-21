{ config, lib, pkgs, ... }:

{
  services.nix-daemon.enable = true;

  nix = {
    trustedUsers = [ "root" "lehoff" ];
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment = {
    shells = [ pkgs.zsh ];
    systemPackages = [ 
      pkgs.zsh
      pkgs.gcc
      pkgs.ripgrep
      pkgs.speedtest-cli
    ];
  };

  users = {

    nix.configureBuildUsers = true;
    users = {
      lehoff = {
        home = "/Users/lehoff";
        shell = pkgs.zsh;
      };
    };

  };

  programs = {
    bash.enable = false;
    zsh.enable = true;
  };

  homebrew = {
    brewPrefix = "/opt/homebrew/bin";
    enable = true;
    global.brewfile = true;

    taps = [ "homebrew/core" "homebrew/cask" ];

    casks = [
      "bettertouchtool"
      "fork"
      "visual-studio-code"
      "alfred"
      "controlplane"
      "docker"
      "karabiner-elements"
      "vivaldi"
      "firefox"
      "iterm2"
      "mailmate"
      "qmk-toolbox"
      "reflector"
      "skim"
      "slack"
      "telegram"
      "ukelele"
      "whatsapp"
      "xmind"
      "zoom"
    ];
  };

}
