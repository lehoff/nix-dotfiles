{ config, lib, pkgs, ... }:

with lib;

let
  # from https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults-write.nix
  isFloat = x:
    isString x && builtins.match "^[+-]?([0-9]*[.])?[0-9]+$" x != null;

  boolValue = x: if x then "YES" else "NO";

  writeValue = value:
    if isBool value then
      "-bool ${boolValue value}"
    else if isInt value then
      "-int ${toString value}"
    else if isFloat value then
      "-float ${toString value}"
    else if isString value then
      "-string '${value}'"
    else
      throw "invalid value type";

  writeDefault = domain: key: value:
    "defaults write ${domain} '${key}' ${writeValue value}";
in {

  system = {
    defaults = {
      dock = {
        orientation =
          "right"; # remember to do a `killall Dock` if install.sh does not
      };
      #    NSGlobalDomain = {
      #      "com.apple.trackpad.TrackpadOrientationMode" = 1;
      #    };
    };
  };

  # Does not work atm. Done in install.sh instead.
  #writeDefault "com.freron.MailMate" MmMessagesOutlineMoveStrategy "previous";

  # Nix
  services.nix-daemon.enable = true;

  nix = {
    trustedUsers = [ "root" "lehoff" ];
    package = pkgs.nix_2_4;
    extraOptions = ''
      experimental-features = nix-command flakes
      extra-platforms = aarch64-darwin
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
    #systemPackages = with pkgs; [ 
    #  zsh
    #  gcc
    #  ripgrep
    #  speedtest-cli
    #];
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

  homebrew = {
    brewPrefix = "/opt/homebrew/bin";
    enable = true;
    global.brewfile = true;

    taps = [ "homebrew/core" "homebrew/cask" "homebrew/cask-drivers" ];

    brews = [ "mas" ];
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
      "skim"
      "wkhtmltopdf"
      # "dash" sha mismatch error... manual install
    ];

    masApps = { Amphetamine = 937984704; };
  };

  programs = { bash.enable = false; };

}
