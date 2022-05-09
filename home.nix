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
   # devops
   skaffold
   terraform
   kind
   kubectl
   nodePackages.npm
  ];

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

    # Review prezto and pure options
    prezto = {
      enable = true;
      prompt.theme = "pure";
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
