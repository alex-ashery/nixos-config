{ lib, inputs, nixpkgs, ... }:

let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in
{
  desktop = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs; };
    modules = [
      ./desktop
      ./configuration.nix
    ];
  };
}
