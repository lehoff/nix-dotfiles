{ pkgs ? import <nixpkgs> {}}:

let
  pythonEnv = pkgs.python310.buildEnv.override {
    extraLibs = with pkgs.python310Packages; [
       numpy
       pandas
       ];
  };
in
pkgs.mkShell {
  buildInputs = [
    pythonEnv
  ];
}