{ config, lib, pkgs, ... }:

{
  environment.shells = [ pkgs.zsh ];

  users = {

    nix.configureBuildUsers = true;
    users = {
      lehoff = {
        home = "/Users/lehoff";
        shell = pkgs.zsh;
      };
    };
  };

  programs.bash.enable = false;

  programs.zsh.enable = true;

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

  ############
  #  System  #
  ############

  time.timeZone = "Europe/Copenhagen";

  system = {
    defaults = {
      NSGlobalDomain = {
        "com.apple.mouse.tapBehavior" = 1;
        AppleKeyboardUIMode = 3;
        ApplePressAndHoldEnabled = true;
        InitialKeyRepeat = 10;
        KeyRepeat = 1;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
        _HIHideMenuBar = false;
      };

      screencapture.location = "/tmp";

      dock = {
        autohide = true;
        mru-spaces = false;
        orientation = "right";
        showhidden = true;
        static-only = true;
      };

      finder = {
        AppleShowAllExtensions = true;
        QuitMenuItem = true;
        FXEnableExtensionChangeWarning = false;
      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };
    };
  };

  ############
  # SERVICES #
  ############

  services.nix-daemon.enable = true;

  ############
  # Homebrew #
  ############

  homebrew = {
    enable = true;
    autoUpdate = true;
    cleanup = "zap";
    global.brewfile = true;
    global.noLock = true;

    taps = [ "homebrew/core" "homebrew/cask" ];
    brews = [ "mas" ];
    casks = [
      "bettertouchtool"
      "fork"
       # uncomment on new machine
      #"visual-studio-code"
      "alfred"
      "controlplane"
      "docker"
      "karabiner-elements"
      "vivaldi"
      "firefox"
      "opera"
      "iterm2"
      "mailmate"
      #"qmk-toolbox"
      "reflector"
      "skim"
      "google-drive"
       # uncomment on new machine
      # "slack"
      "telegram"
      "ukelele"
      "whatsapp"
      "xmind"
      "zoom"
      "skim"
      "wkhtmltopdf"
      "aldente"
      "dash" 
      "google-chrome"
      "finicky"
      "logseq"
      # "rename"
      "raycast"
      "inkscape"
      "gimp"
    ];

    masApps = {
      Amphetamine = 937984704;
      Pages = 409201541;
      Keynote = 409183694;
      Numbers = 409203825;
      Slack = 803453959;
      Bitwarden = 1352778147;
      Bear = 1091189122;
      ToogleTrack = 1291898086;

    };
  };

  programs.nix-index.enable = true;

  environment.variables.LANG = "en_GB.UTF-8";
  environment.loginShell = "${pkgs.zsh}/bin/zsh -l";

  environment.systemPackages = [
    pkgs.nodePackages.mermaid-cli
  ];

  services.activate-system.enable = true;
}

