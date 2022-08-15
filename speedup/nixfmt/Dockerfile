FROM nixos/nix

RUN nix-channel --update

RUN nix-build -A nixpkgs-fmt '<nixpkgs>'
