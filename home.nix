{ config, lib, pkgs, ... }: {

  programs.home-manager.enable = true;
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

  programs.zsh = {
    enable = true;
    shellAliases = { ll = "ls -l"; };
    plugins = [{
      name = "zsh-nix-shell";
      file = "nix-shell.plugin.zsh";
      src = pkgs.fetchFromGitHub {
        owner = "chisui";
        repo = "zsh-nix-shell";
        rev = "v0.4.0";
        sha256 = "037wz9fqmx0ngcwl9az55fgkipb745rymznxnssr3rx9irb6apzg";
      };
    }];

    prezto = {
      enable = true;
      prompt.theme = "bart";
    };

    sessionVariables = {
      ERL_AFLAGS = "-kernel shell_history enabled";
      NIX_PATH =
        "darwin-config=$HOME/.nixpkgs/darwin-configuration.nix:$HOME/.nix-defexpr/channels\${NIX_PATH:+:}$NIX_PATH";
    };
    initExtra = ''
      ${builtins.readFile "/Users/lehoff/nix-dotfiles/dot-zshrc"}
    '';
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };
}
