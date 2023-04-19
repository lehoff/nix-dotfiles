{ config, pkgs, lib, ... }:
{
  programs.home-manager.enable = true;

  ############
  # Packages #
  ############

  home.packages = with pkgs; [
   tree
   yq
   jq
   direnv
   speedtest-cli
   ripgrep
   git
   fasd
   hub
   nodejs
   rebar3
   asciidoctor-with-extensions
   jre # needed for asciidoctor

   #nodePackages.mermaid-cli
   # devops
   docker
   skaffold
   terraform
   kind
   kubectl
   nodePackages.npm
   imagemagick
  ];

  home.stateVersion = "22.05";

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.bat.enable = true;

  programs.fzf.enable = true;

  programs.lsd = {
    enable = true;
    enableAliases = true;
  };

  ###################
  # SHELL/ZSH  ######
  ###################

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;

    history.extended = true;

    initExtra = ''
      PATH=/opt/homebrew/bin:$PATH
      eval "$(fasd --init auto)"
      '';

    # Review prezto and pure options
    prezto = {
      enable = true;
      prompt.theme = "bart";
    };

    sessionVariables = {
      DOCKER_BUILDKIT = 1;
      ERL_AFLAGS = "-kernel shell_history enabled";
      NIX_PATH =
        "darwin-config=$HOME/.nixpkgs/darwin-configuration.nix:$HOME/.nix-defexpr/channels\${NIX_PATH:+:}$NIX_PATH";
      FZF_DEFAULT_COMMAND = "rg --files --hidden --follow";
    };
  };
}
