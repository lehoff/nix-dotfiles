# { pkgs ? import <nixpkgs> {}}:

# # from https://ejpcmac.net/blog/using-nix-in-elixir-projects/
# let
#   inherit optional optionals;
#   elixir = beam.packages.erlangR21.elixir_1_14;
# in

# mkShell {
#   buildInputs = [ elixir git ]
#     ++ optional stdenv.isLinux libnotify # For ExUnit Notifier on Linux.
#     ++ optional stdenv.isLinux inotify-tools # For file_system on Linux.
#     ++ optional stdenv.isDarwin terminal-notifier # For ExUnit Notifier on macOS.
#     ++ optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
#       # For file_system on macOS.
#       CoreFoundation
#       CoreServices
#     ]);
# }


# from https://til.codes/nix-shell-for-elixir-projects/
{pkgs ? import <nixpkgs> {} }:
  
with pkgs;

let
  inherit (lib) optional optionals;

  erlang = beam.interpreters.erlangR25;
  #elixir = beam.packages.erlangR25.elixir_1_14;
  elixir = (beam.packagesWith erlang).elixir.override {
   version = "1.14.0";
    # nix-prefetch-url --unpack https://github.com/elixir-lang/elixir/archive/refs/tags/v1.14.0.tar.gz
    sha256 = "16rc4qaykddda6ax5f8zw70yhapgwraqbgx5gp3f40dvfax3d51l";
  };
  nodejs = nodejs-18_x;
in

mkShell {
  buildInputs = [cacert git erlang elixir cargo nodejs]
    ++ optional stdenv.isLinux inotify-tools
    ++ optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
      CoreFoundation
      CoreServices
    ]);

    shellHook = ''
      alias mdg="mix deps.get"
      alias mps="mix phx.server"
      alias test="mix test"
      alias c="iex -S mix"
    '';
}