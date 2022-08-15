{ pkgs ? import <nixpkgs> { }
, pkgsLinux ? import <nixpkgs> { system = "x86_64-linux"; }
}:

pkgs.dockerTools.buildImage {
  name = "nixfmt";
  tag = "latest";
  config = {
    Cmd = [ "${pkgsLinux.nixpkgs-fmt}/bin/nixpkgs-fmt" "--check" "." ];
  };
}
