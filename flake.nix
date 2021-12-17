{
  description = "Torben's darwin system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, darwin, nixpkgs }: {
    darwinConfigurations.mimer.localdomain = darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = [ ./darwin-configuration.nix ]
           ++ [
               {
                 networking = {
                   hostName = "mimer";
                   computerName = "mimer";
                   localHostName = "mimer";
                 };
               }
              ];
    };
  };
}
