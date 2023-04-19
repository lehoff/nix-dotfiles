# from https://til.codes/nix-shell-for-elixir-projects/
{pkgs ? import <nixpkgs> {} }:
  
with pkgs;

let
  inherit (lib) optional optionals;

  erlang = beam.interpreters.erlangR25;
  elixir = beam.packages.erlangR25.elixir_1_14;
  nodejs = nodejs-18_x;
in

mkShell {
  buildInputs = [cacert git erlang elixir cargo nodejs]
    ++ optional stdenv.isLinux inotify-tools
    ++ optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
      CoreFoundation
      CoreServices
    ]);

}