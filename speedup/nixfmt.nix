{ pkgs ? import <nixpkgs> { }
, pkgsLinux ? import <nixpkgs> { system = "x86_64-linux"; }
}:

pkgs.dockerTools.buildImage {
  name = "cofob/nixfmt";
  tag = "latest";
  contents = with pkgsLinux; [ toybox nixpkgs-fmt bash ];
}
