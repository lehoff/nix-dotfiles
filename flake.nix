{
  description = "Torben's darwin system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin/master";

    home-manager.url = "github:nix-community/home-manager";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, darwin, nixpkgs, home-manager, ... }:
    let
      common = [
        ./darwin-configuration.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.pepo = import ./home.nix;
        }
      ];
    in {

      darwinConfigurations = {

        "mimer" = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          modules = common ++ [
            ({ pkgs, config, ... }: {
              networking = {
                hostName = "mimer";
                computerName = "mimer";
                localHostName = "mimer";
              };
            })
          ];
        };
      };
    };
}
