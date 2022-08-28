{ pkgs ? import <nixpkgs> { } }:

rec {
  docs = with import ./docs.nix { inherit pkgs; }; {
    html = manual.html;
  };
}
