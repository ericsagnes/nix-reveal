{ pkgs ? import <nixpkgs> {} }:

with pkgs.lib;

(pkgs.callPackage ../mkPresentation.nix) {
  src = ./.;
  name = "example-presentation";
  # reveal version can be changed with revealJS
  # 4.1.0 is used by default
  revealVersion = "4.1.0";
}
