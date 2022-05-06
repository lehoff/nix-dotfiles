{ config, pkgs, lib, ... }:
let
gitconfig = {
    userEmail = "torben.lehoff@gmail.com";
  };

in {

  programs.home-manager.enable = true;

  ############
  # Packages #
  ############

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
      tree
      yq
      jq
  ];

  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
    };
    # plugins = [
    # {
    #   name = "zsh-nix-shell";
    #   file = "nix-shell.plugin.zsh";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "chisui";
    #     repo = "zsh-nix-shell";
    #     rev = "v0.4.0";
    #     sha256 = "037wz9fqmx0ngcwl9az55fgkipb745rymznxnssr3rx9irb6apzg";
    #   };
    # }
    # ];
    initExtra = ''
      ${builtins.readFile "/Users/lehoff/nix-dotfiles/dot-zshrc"}
    '';
  };

}