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

  homebrew = {
    enable = true;
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
      "ripgrep"
      "skim"
      "slack"
      "speedtest-cli"
      "telegram"
      "ukelele"
      "whatsapp"
      "xmind"
      "zoom"
    ];
  };

}
